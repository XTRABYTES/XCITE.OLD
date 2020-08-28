#include "XGames.hpp"

XGames xgames;

XGames::XGames(QObject *parent) : QObject(parent)
{

}
unsigned constexpr const_hash(char const *input) {
    return *input ?
                static_cast<unsigned int>(*input) + 33 * const_hash(input + 1) :
                5381;
}

void XGames::Initialize(){

}
/*
void XGames::xgamesEntry(QByteArray obj){
     QJsonDocument json = QJsonDocument::fromJson(obj);
     QJsonObject jsonObj = json.object();
     QString route = jsonObj.value("route").toString();
    switch(const_hash(route.toStdString().c_str()))
    {

    case const_hash("sendToGame"):
        sendToGame(jsonObj);
        break;
    case const_hash("confirmGameReceived"):
        confirmGameReceived(jsonObj);
        break;
    case const_hash("receiveGameInvite"):
        receiveGameInvite(jsonObj);
        break;
    case const_hash("receiveGameInviteResponse"):
        receiveGameInviteResponse(jsonObj);
        break;
    default:
        qDebug() << "No Route Found";
        break;
    }
}


void XGames::sendGameToQueue(const QString user, QString game, QString gameID, QString move) {
    if (broker.isConnected()) {
        qint64 timeStamp = QDateTime::currentDateTimeUtc().toMSecsSinceEpoch();
        QString moveID = QString::number(timeStamp);
        QJsonObject obj;
        obj.insert("player", user);
        obj.insert("route","sendToGame");
        obj.insert("game", game);
        obj.insert("gameID", gameID);
        obj.insert("move",move);
        obj.insert("moveID", moveID);
        QJsonDocument doc(obj);
        QString strJson(doc.toJson(QJsonDocument::Compact));
        broker.sendMessage("xgames",strJson);
    }
    else {
        emit gameCommandFailed();
    }
}

void XGames::sendToGame(QJsonObject obj) {
    QString player = obj.value("player").toString();
    QString game = obj.value("game").toString();
    QString gameID = obj.value("gameID").toString();
    QString move = obj.value("move").toString();
    QString moveID = obj.value("moveID").toString();

    emit newMoveReceived(player, game, gameID, move, moveID);
}

void XGames::confirmGameSend(const QString user, QString game, QString gameID, QString move, QString moveID) {
    if (broker.isConnected()) {
        QJsonObject obj;
        obj.insert("player", user);
        obj.insert("route","confirmGameReceived");
        obj.insert("game", game);
        obj.insert("gameID", gameID);
        obj.insert("move",move);
        obj.insert("moveID", moveID);
        QJsonDocument doc(obj);
        QString strJson(doc.toJson(QJsonDocument::Compact));
        broker.sendMessage("xgames",strJson);
    }
    else {
        emit gameCommandFailed();
    }
}

void XGames::confirmGameReceived(QJsonObject obj) {
    QString player = obj.value("player").toString();
    QString game = obj.value("game").toString();
    QString gameID = obj.value("gameID").toString();
    QString move = obj.value("move").toString();
    QString moveID = obj.value("moveID").toString();

    emit newMoveConfirmed(player, game, gameID, move, moveID);
}

void XGames::sendGameInvite(const QString user, QString opponent, QString game, QString gameID) {
    if (broker.isConnected()) {
        QJsonObject obj;
        obj.insert("player1", user);
        obj.insert("player2", opponent);
        obj.insert("route","receiveGameInvite");
        obj.insert("game", game);
        obj.insert("gameID", gameID);
        QJsonDocument doc(obj);
        QString strJson(doc.toJson(QJsonDocument::Compact));
        broker.sendMessage("xgames",strJson);
    }
    else {
        emit gameCommandFailed();
    }
}

void XGames::receiveGameInvite(QJsonObject obj) {
    QString player1 = obj.value("player1").toString();
    QString player2 = obj.value("player2").toString();
    QString game = obj.value("game").toString();
    QString gameID = obj.value("gameID").toString();

    emit newGameInvite(player1, player2, game, gameID);
}

void XGames::confirmGameInvite(const QString user, QString opponent, QString game, QString gameID, QString accept) {
    if (broker.isConnected()) {
        QJsonObject obj;
        obj.insert("username", user);
        obj.insert("opponent", opponent);
        obj.insert("route","receiveGameInviteResponse");
        obj.insert("game", game);
        obj.insert("gameID", gameID);
        obj.insert("accept", accept);
        QJsonDocument doc(obj);
        QString strJson(doc.toJson(QJsonDocument::Compact));
        broker.sendMessage("xgames",strJson);
    }
    else {
        emit gameCommandFailed();
    }
}

void XGames::receiveGameInviteResponse(QJsonObject obj) {
    QString user = obj.value("username").toString();
    QString game = obj.value("game").toString();
    QString gameID = obj.value("gameID").toString();
    QString accept = obj.value("accept").toString();

    emit responseGameInvite(user, game, gameID, accept);
}
*/

