
#include "dicom.hpp"
#include <QDebug>
#include <QJsonObject>
#include <QStringList>
#include <QJsonDocument>

using namespace dicom;


sessionkey::sessionkey() {
    generate();
}

bool sessionkey::generate() {
    int ret = 0;

    BIGNUM *bne = NULL;
    bne = BN_new();
    ret = BN_set_word(bne, RSA_F4);
    if (ret != 1) {
        std::cout << "problem creating bne" << std::endl;
        BN_free(bne);
        return false;
    }

    RSA *rsa = NULL;
    rsa = RSA_new();
    ret = RSA_generate_key_ex(rsa, 2048, bne, NULL);
    if (ret != 1) {
        std::cout << "problem generating key" << std::endl;
        RSA_free(rsa);
        BN_free(bne);
        return false;
    }

    EVP_PKEY *evpkey = NULL;
    evpkey = EVP_PKEY_new();
    ret = EVP_PKEY_assign_RSA(evpkey, rsa);
    if (ret != 1) {
        return false;
    }

    BIO *privkey = NULL;
    privkey = BIO_new(BIO_s_mem());
    ret = PEM_write_bio_PrivateKey(privkey, evpkey, NULL, NULL, 0, NULL, NULL);
    if (ret != 1) {
        return false;
    }

    BIO *pubkey = NULL;
    pubkey = BIO_new(BIO_s_mem());
    PEM_write_bio_PUBKEY(pubkey, evpkey);
    if (ret != 1) {
        return false;
    }

    BUF_MEM *pubmem = NULL;
    BIO_get_mem_ptr(pubkey, &pubmem);
    key.pub.assign(pubmem->data, pubmem->data + pubmem->length);

    BUF_MEM *privmem = NULL;
    BIO_get_mem_ptr(privkey, &privmem);
    key.priv.assign(privmem->data, privmem->data + privmem->length);

    // TODO: better cleanup
    BIO_free_all(pubkey);
    BIO_free_all(privkey);
    EVP_PKEY_free(evpkey);

    return true;
}

bool sessionkey::RSASign(RSA* rsa, const unsigned char* Msg, size_t MsgLen, unsigned char** EncMsg, size_t* MsgLenEnc) {
    EVP_MD_CTX* m_RSASignCtx = EVP_MD_CTX_create();
    EVP_PKEY* priKey  = EVP_PKEY_new();
    EVP_PKEY_assign_RSA(priKey, rsa);
    if (EVP_DigestSignInit(m_RSASignCtx,NULL, EVP_sha256(), NULL,priKey)<=0) {
        return false;
    }
    if (EVP_DigestSignUpdate(m_RSASignCtx, Msg, MsgLen) <= 0) {
        return false;
    }
    if (EVP_DigestSignFinal(m_RSASignCtx, NULL, MsgLenEnc) <=0) {
        return false;
    }
    *EncMsg = (unsigned char*)malloc(*MsgLenEnc);
    if (EVP_DigestSignFinal(m_RSASignCtx, *EncMsg, MsgLenEnc) <= 0) {
        return false;
    }

    //EVP_MD_CTX_cleanup(m_RSASignCtx);
    return true;
}

RSA* sessionkey::createPrivateRSA(std::string key) {
    ::RSA *rsa = NULL;
    const char* c_string = key.c_str();
    BIO * keybio = BIO_new_mem_buf((void*)c_string, -1);
    if (keybio==NULL) {
        return 0;
    }
    rsa = PEM_read_bio_RSAPrivateKey(keybio, &rsa,NULL, NULL);

    return rsa;
}

std::string sessionkey::sign(std::string payload) {
    RSA* privateRSA = createPrivateRSA(key.priv);
    unsigned char* encMessage = NULL;
    size_t encMessageLength = 0;

    bool res = RSASign(privateRSA, (unsigned char*) payload.c_str(), payload.length(), &encMessage, &encMessageLength);
    if (!res) {
        std::cout << "problem generating signature" << std::endl;
    }

    //std::cout << "sig is " << encMessageLength << " bytes" << std::endl;

    std::string signatureStr(reinterpret_cast<char const*>(encMessage), encMessageLength);
    QByteArray b(signatureStr.c_str(), signatureStr.length());
    QByteArray b64 = b.toBase64();

    std::string s(b64.constData(), b64.length());

    free(encMessage);

    //std::cout << "encode64: " << s << std::endl;

    return s;
}

void client::onResponse(QJsonObject res, QJSValue callback)
{
    QString payloadStr = res.value("payload").toString();
    std::cout << payloadStr.toStdString() << std::endl;

    QByteArray b(payloadStr.toStdString().c_str(), payloadStr.length());
    QJsonDocument doc = QJsonDocument::fromJson(b);
    QJsonObject payload = doc.object();

    QString method = payload.value("method").toString();
    QString signature = res.value("signature").toString();

    // TODO: Verify signature

    if (method == "connect") {
        m_sessionId = payload.value("session_id").toString();
        m_serverPubKey = payload.value("pubkey").toString();
    } else if (method == "user.login") {
        m_username = payload.value("username").toString();
        m_bip38 = payload.value("key").toString();
        qDebug() << "encrypted key is:" << m_bip38;
    }

    if (callback.isCallable()) {
        // TODO: This is deprecated but the engine needs to be the same as the one that originated the callback so can't use a new instance
        QJSValue arg = callback.engine()->toScriptValue<QVariantMap>(payload.toVariantMap());

        callback.call(QJSValueList{arg});
    } else {
        qDebug() << "callback not callable";
    }
}

void client::sessionCreate(QJSValue callback) {
    QJsonObject payloadObject;
    payloadObject.insert("method", QJsonValue::fromVariant("connect"));
    payloadObject.insert("pubkey", QJsonValue::fromVariant(QString::fromStdString((skey.pub()))));
    QJsonDocument payloadDocument(payloadObject);

    execute(payloadDocument.toJson(QJsonDocument::Compact), callback);
}

void client::userLogin(QString username, QString password, QJSValue callback) {
    QJsonObject payloadObject;
    payloadObject.insert("method", QJsonValue::fromVariant("user.login"));
    payloadObject.insert("username", QJsonValue::fromVariant(username));
    payloadObject.insert("password", QJsonValue::fromVariant(password));
    payloadObject.insert("session_id", QJsonValue::fromVariant(m_sessionId));
    QJsonDocument payloadDocument(payloadObject);

    qDebug() << "user.login";

    execute(payloadDocument.toJson(QJsonDocument::Compact), callback);
}

void client::userCreate(QString username, QString password, QJSValue callback) {
    QJsonObject payloadObject;
    payloadObject.insert("method", QJsonValue::fromVariant("user.create"));
    payloadObject.insert("username", QJsonValue::fromVariant(username));
    payloadObject.insert("password", QJsonValue::fromVariant(password));
    payloadObject.insert("session_id", QJsonValue::fromVariant(m_sessionId));
    QJsonDocument payloadDocument(payloadObject);

    qDebug() << "user.create";

    execute(payloadDocument.toJson(QJsonDocument::Compact), callback);
}

void client::sendRequest(QVariantMap arg, QJSValue callback) {
    qDebug() << "send raw request";

    QJsonDocument payloadDocument(QJsonObject::fromVariantMap(arg));
    execute(payloadDocument.toJson(QJsonDocument::Compact), callback);
}

void client::sendRequest(QString r, QJSValue callback) {
    qDebug() << "send raw request";

    QStringList args = r.split(" ");
    QString method = args.at(0).trimmed();
    args.pop_front();

    qDebug() << "method:" << method;
    qDebug() << "args:" << args;
}

void client::execute(QString payload, QJSValue callback) {
    std::string signature = skey.sign(payload.toStdString());

    // TODO: Handle this on the SSS side
    std::string splitsig = "";
    for (size_t i = 0; i < signature.length(); i += 64) {
        splitsig += signature.substr(i, 64) += "\n";
    }

    QJsonObject requestObject;
    requestObject.insert("dicom", QJsonValue::fromVariant("1.0"));
    requestObject.insert("payload", QJsonValue::fromVariant(payload));
    requestObject.insert("signature", QJsonValue::fromVariant(QString::fromStdString(splitsig)));
    QJsonDocument requestDocument(requestObject);

    QString request = requestDocument.toJson(QJsonDocument::Compact);

    qDebug() << "sending request with json: ";
    std::cout << request.toStdString() << std::endl;
    http->request(request, callback);
}

