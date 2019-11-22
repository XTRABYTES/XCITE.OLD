#ifndef TTT_H
#define TTT_H

#include <QObject>
#include <array>
#include <string>
#include <memory>
#include <array>
#include <utility>

class Ttt : public QObject
{
    Q_OBJECT

public:
    Ttt(QObject *parent = 0);

    std::array<std::array<char, 3> ,3> board {{{' ', ' ', ' '},
                                               {' ', ' ', ' '},
                                               {' ', ' ', ' '}}};

    // table to map buttons to coordinates
    //std::array<QPushButton*, 10> btn_tbl; //??? new mapping required

    int win=0;
    int draw=0;
    int loose=0;


public slots:
    void setUsername(QString username);
    void buttonClicked(QString btn);
    void newMove(QString player, QString btn);
    void newGame();
    void quitGame();
    void getScore();
    void createGameID(QString user, QString opponent);
    void resetScore(QString wn, QString lst, QString drw);
    void getMoveID(QString move);

signals:
    void gameFinished(QString result, QString win, QString loose, QString draw);
    void playersChoice(QString btn1);
    void opponentsChoice(QString btn2);
    void computersChoice(QString btn2, QString moveID);
    void blockButton(QString btn);
    void clearBoard();
    void scoreBoard(QString win, QString loose, QString draw);
    void yourTurn(bool turn);
    void newGameID(QString gameID);
    void newMoveID(QString move, QString moveID);

private:
    std::pair<int,int> get_coordinates(int val);
    bool has_moves_left();
    int evaluate();
    int minimax(int depth, bool isMax);
    std::pair<int,int> find_best_move();
    bool check_win();
    QString me = "";
    //void block_cells();

};

#endif // TTT_H
