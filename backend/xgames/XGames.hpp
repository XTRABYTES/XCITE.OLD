#ifndef XGAMES_HPP
#define XGAMES_HPP

#include <QObject>
#include "../xutility/BrokerConnection.h"


class XGames : public QObject
{
    Q_OBJECT
public:
    explicit XGames(QObject *parent = nullptr);
    void Initialize();

signals:
    void sendNewMoveSucceed(QString player, QString game, QString gameID, QString move, QString moveID);
    void newMoveReceived(QString player, QString game, QString gameID, QString move, QString moveID);
    void newMoveConfirmed(QString player, QString game, QString gameID, QString move, QString moveID);
    void sendGameInviteSucceed(QString user, QString opponent, QString game, QString gameID);
    void newGameInvite(QString player1, QString player2, QString game, QString gameID);
    void sendConfirmGameInviteSucceed(QString user, QString opponent, QString game, QString gameID, QString accept);
    void responseGameInvite(QString user, QString game, QString gameID, QString accept);
    void gameCommandFailed();

public slots:
    void sendGameToQueue(const QString player, QString game, QString gameID, QString move);
    void confirmGameSend(const QString player, QString game, QString gameID, QString move, QString moveID);
    void sendGameInvite(const QString user, QString opponent, QString game, QString gameID);
    void confirmGameInvite(const QString user, QString opponent, QString game, QString gameID, QString accept);
    void sendToGame(QJsonObject);
    void confirmGameReceived(QJsonObject);
    void receiveGameInvite(QJsonObject);
    void receiveGameInviteResponse(QJsonObject);
    void xgamesEntry(QByteArray obj);

};

extern XGames xgames;

#endif // XGAMES_HPP
