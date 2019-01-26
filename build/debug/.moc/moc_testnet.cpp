/****************************************************************************
** Meta object code from reading C++ file 'testnet.hpp'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/testnet/testnet.hpp"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'testnet.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_HttpClient_t {
    QByteArrayData data[13];
    char stringdata0[138];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_HttpClient_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_HttpClient_t qt_meta_stringdata_HttpClient = {
    {
QT_MOC_LITERAL(0, 0, 10), // "HttpClient"
QT_MOC_LITERAL(1, 11, 8), // "response"
QT_MOC_LITERAL(2, 20, 0), // ""
QT_MOC_LITERAL(3, 21, 6), // "sender"
QT_MOC_LITERAL(4, 28, 7), // "command"
QT_MOC_LITERAL(5, 36, 6), // "params"
QT_MOC_LITERAL(6, 43, 3), // "res"
QT_MOC_LITERAL(7, 47, 10), // "onResponse"
QT_MOC_LITERAL(8, 58, 14), // "QNetworkReply*"
QT_MOC_LITERAL(9, 73, 28), // "handleAuthenticationRequired"
QT_MOC_LITERAL(10, 102, 5), // "reply"
QT_MOC_LITERAL(11, 108, 15), // "QAuthenticator*"
QT_MOC_LITERAL(12, 124, 13) // "authenticator"

    },
    "HttpClient\0response\0\0sender\0command\0"
    "params\0res\0onResponse\0QNetworkReply*\0"
    "handleAuthenticationRequired\0reply\0"
    "QAuthenticator*\0authenticator"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_HttpClient[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    4,   29,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       7,    1,   38,    2, 0x0a /* Public */,
       9,    2,   41,    2, 0x08 /* Private */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QJsonArray, QMetaType::QJsonObject,    3,    4,    5,    6,

 // slots: parameters
    QMetaType::Void, 0x80000000 | 8,    6,
    QMetaType::Void, 0x80000000 | 8, 0x80000000 | 11,   10,   12,

       0        // eod
};

void HttpClient::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        HttpClient *_t = static_cast<HttpClient *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->response((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QJsonArray(*)>(_a[3])),(*reinterpret_cast< QJsonObject(*)>(_a[4]))); break;
        case 1: _t->onResponse((*reinterpret_cast< QNetworkReply*(*)>(_a[1]))); break;
        case 2: _t->handleAuthenticationRequired((*reinterpret_cast< QNetworkReply*(*)>(_a[1])),(*reinterpret_cast< QAuthenticator*(*)>(_a[2]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 1:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QNetworkReply* >(); break;
            }
            break;
        case 2:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QNetworkReply* >(); break;
            }
            break;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (HttpClient::*)(QString , QString , QJsonArray , QJsonObject );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&HttpClient::response)) {
                *result = 0;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject HttpClient::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_HttpClient.data,
      qt_meta_data_HttpClient,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *HttpClient::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *HttpClient::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_HttpClient.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int HttpClient::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void HttpClient::response(QString _t1, QString _t2, QJsonArray _t3, QJsonObject _t4)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)), const_cast<void*>(reinterpret_cast<const void*>(&_t4)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
struct qt_meta_stringdata_Testnet_t {
    QByteArrayData data[16];
    char stringdata0[178];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Testnet_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Testnet_t qt_meta_stringdata_Testnet = {
    {
QT_MOC_LITERAL(0, 0, 7), // "Testnet"
QT_MOC_LITERAL(1, 8, 8), // "response"
QT_MOC_LITERAL(2, 17, 0), // ""
QT_MOC_LITERAL(3, 18, 13), // "walletChanged"
QT_MOC_LITERAL(4, 32, 11), // "walletError"
QT_MOC_LITERAL(5, 44, 6), // "sender"
QT_MOC_LITERAL(6, 51, 13), // "walletSuccess"
QT_MOC_LITERAL(7, 65, 15), // "consoleResponse"
QT_MOC_LITERAL(8, 81, 7), // "request"
QT_MOC_LITERAL(9, 89, 10), // "onResponse"
QT_MOC_LITERAL(10, 100, 7), // "balance"
QT_MOC_LITERAL(11, 108, 11), // "unconfirmed"
QT_MOC_LITERAL(12, 120, 12), // "transactions"
QT_MOC_LITERAL(13, 133, 17), // "TransactionModel*"
QT_MOC_LITERAL(14, 151, 8), // "accounts"
QT_MOC_LITERAL(15, 160, 17) // "AddressBookModel*"

    },
    "Testnet\0response\0\0walletChanged\0"
    "walletError\0sender\0walletSuccess\0"
    "consoleResponse\0request\0onResponse\0"
    "balance\0unconfirmed\0transactions\0"
    "TransactionModel*\0accounts\0AddressBookModel*"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Testnet[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       4,   80, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   49,    2, 0x06 /* Public */,
       3,    0,   52,    2, 0x06 /* Public */,
       4,    2,   53,    2, 0x06 /* Public */,
       6,    1,   58,    2, 0x06 /* Public */,
       7,    1,   61,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       8,    3,   64,    2, 0x0a /* Public */,
       9,    4,   71,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QVariant,    1,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QVariant, QMetaType::QVariant,    5,    1,
    QMetaType::Void, QMetaType::QVariant,    1,
    QMetaType::Void, QMetaType::QVariant,    1,

 // slots: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QVariantList,    2,    2,    2,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QJsonArray, QMetaType::QJsonObject,    2,    2,    2,    2,

 // properties: name, type, flags
      10, QMetaType::LongLong, 0x00495003,
      11, QMetaType::LongLong, 0x00495003,
      12, 0x80000000 | 13, 0x0049500b,
      14, 0x80000000 | 15, 0x0049500b,

 // properties: notify_signal_id
       1,
       1,
       1,
       1,

       0        // eod
};

void Testnet::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Testnet *_t = static_cast<Testnet *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->response((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 1: _t->walletChanged(); break;
        case 2: _t->walletError((*reinterpret_cast< QVariant(*)>(_a[1])),(*reinterpret_cast< QVariant(*)>(_a[2]))); break;
        case 3: _t->walletSuccess((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 4: _t->consoleResponse((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 5: _t->request((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QVariantList(*)>(_a[3]))); break;
        case 6: _t->onResponse((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QJsonArray(*)>(_a[3])),(*reinterpret_cast< QJsonObject(*)>(_a[4]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Testnet::*)(QVariant );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Testnet::response)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Testnet::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Testnet::walletChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Testnet::*)(QVariant , QVariant );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Testnet::walletError)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Testnet::*)(QVariant );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Testnet::walletSuccess)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (Testnet::*)(QVariant );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Testnet::consoleResponse)) {
                *result = 4;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 3:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< AddressBookModel* >(); break;
        case 2:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< TransactionModel* >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        Testnet *_t = static_cast<Testnet *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< qlonglong*>(_v) = _t->m_balance; break;
        case 1: *reinterpret_cast< qlonglong*>(_v) = _t->m_unconfirmed; break;
        case 2: *reinterpret_cast< TransactionModel**>(_v) = _t->m_transactions; break;
        case 3: *reinterpret_cast< AddressBookModel**>(_v) = _t->m_accounts; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        Testnet *_t = static_cast<Testnet *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0:
            if (_t->m_balance != *reinterpret_cast< qlonglong*>(_v)) {
                _t->m_balance = *reinterpret_cast< qlonglong*>(_v);
                Q_EMIT _t->walletChanged();
            }
            break;
        case 1:
            if (_t->m_unconfirmed != *reinterpret_cast< qlonglong*>(_v)) {
                _t->m_unconfirmed = *reinterpret_cast< qlonglong*>(_v);
                Q_EMIT _t->walletChanged();
            }
            break;
        case 2:
            if (_t->m_transactions != *reinterpret_cast< TransactionModel**>(_v)) {
                _t->m_transactions = *reinterpret_cast< TransactionModel**>(_v);
                Q_EMIT _t->walletChanged();
            }
            break;
        case 3:
            if (_t->m_accounts != *reinterpret_cast< AddressBookModel**>(_v)) {
                _t->m_accounts = *reinterpret_cast< AddressBookModel**>(_v);
                Q_EMIT _t->walletChanged();
            }
            break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject Testnet::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Testnet.data,
      qt_meta_data_Testnet,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *Testnet::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Testnet::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_Testnet.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Testnet::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 7;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 4;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void Testnet::response(QVariant _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Testnet::walletChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void Testnet::walletError(QVariant _t1, QVariant _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void Testnet::walletSuccess(QVariant _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void Testnet::consoleResponse(QVariant _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
