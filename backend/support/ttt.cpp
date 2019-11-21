#include "ttt.h"
#include <algorithm>
#include <cstdint>
#include <cstring>
#include <set>

Ttt::Ttt(QObject *parent) :
    QObject(parent)
{
}

bool Ttt::check_win()
{
    int score = evaluate();
    QString won = QString::number(win);
    QString lost = QString::number(loose);
    QString drawed = QString::number(draw);
    if (score == -10) {
        ++win;
        won = QString::number(win);
        emit gameFinished("win", won, lost, drawed);
        return true;
    }
    else if (score == +10) {
        ++loose;
        lost = QString::number(loose);
        emit gameFinished("loose", won, lost, drawed);
        return true;
    }
    else if (!has_moves_left()) {
        ++draw;
        drawed = QString::number(draw);
        emit gameFinished("draw", won, lost, drawed);
        return true;
    }

    return false;
}

void Ttt::buttonClicked(QString btn)
{
    // Your turn
    QString button1 = btn;
    emit blockButton(button1);
    emit playersChoice(button1);
    int number = btn.toInt();
    auto coord = get_coordinates(number);
    board[coord.first][coord.second] = 'o';
    if (check_win()) {
        return;
    }

    // Computer turn
    auto best = find_best_move();
    board[best.first][best.second] = 'x';
    //auto cell = best.first*3 + best.second + 1; // convert (x,y) coord to btn number
        //auto button2 = btn_tbl[cell];
    qint16 cell = best.first*3 + best.second + 1;
    QString button2 = QString::number(cell);
    emit blockButton(button2);
    emit computersChoice(button2);
        //button2->setEnabled(false);
        //button2->setIcon(x_icon);
    if (check_win()) {
    }
}

inline std::pair<int,int> Ttt::get_coordinates(int val)
{ // returns (row, col) coordinate of given cell
    if (val < 1 || val > 9) throw std::runtime_error("");
    return std::pair<int,int> ((val-1)/3, (val-1)%3);
}

inline bool Ttt::has_moves_left()
{
    for (auto& row: board)
        for (auto& cell: row)
            if (cell == ' ')
                return true;

    return false;
}

// This is the evaluation function
int Ttt::evaluate()
{
    // Checking for Rows for X or O victory.
    for (decltype(board)::size_type row = 0; row<board.size(); ++row)
    {
        if (board[row][0]==board[row][1] &&
            board[row][1]==board[row][2])
        {
            if (board[row][0]=='x')
                return +10;

            else if (board[row][0]=='o')
                return -10;
        }
    }

    // Checking for Columns for X or O victory.
    for (decltype(board)::size_type col = 0; col<board.size(); ++col)
    {
        if (board[0][col]==board[1][col] &&
            board[1][col]==board[2][col])
        {
            if (board[0][col]=='x')
                return +10;

            else if (board[0][col]=='o')
                return -10;
        }
    }

    // Checking for Diagonals for X or O victory.
    if (board[0][0]==board[1][1] && board[1][1]==board[2][2])
    {
        if (board[0][0]=='x')
            return +10;
        else if (board[0][0]=='o')
            return -10;
    }

    if (board[0][2]==board[1][1] && board[1][1]==board[2][0])
    {
        if (board[0][2]=='x')
            return +10;
        else if (board[0][2]=='o')
            return -10;
    }

    // Else if none of them have won then return 0
    return 0;
}

// This is the minimax function. It considers all
// the possible ways the game can go and returns
// the value of the board
int Ttt::minimax(int depth, bool isMax)
{
    int score = evaluate();

    // If Maximizer has won the game return his/her
    // evaluated score minus depth (to make it smarter)
    if (score == 10)
        return score - depth;

    // If Minimizer has won the game return his/her
    // evaluated score plus depth (to make it smarter)
    if (score == -10)
        return score + depth;

    // If there are no more moves and no winner then
    // it is a tie
    if (!has_moves_left())
        return 0;

    // If this maximizer's move
    if (isMax)
    {
        int best = -1000;

        // Traverse all cells
        for (decltype(board)::size_type i = 0; i<board.size(); ++i) {
            for (decltype(i) j = 0; j<board[0].size(); ++j) {
                // Check if cell is empty
                if (board[i][j]==' ') {
                    // Make the move
                    board[i][j] = 'x';

                    // Call minimax recursively and choose
                    // the maximum value
                    best = std::max(best, minimax(depth+1, !isMax));

                    // Undo the move
                    board[i][j] = ' ';
                }
            }
        }
        return best;
    }

    // If this minimizer's move
    else
    {
        int best = 1000;

        // Traverse all cells
        for (decltype(board)::size_type i = 0; i<board.size(); ++i) {
            for (decltype(i) j = 0; j<board[0].size(); ++j) {
                // Check if cell is empty
                if (board[i][j]==' ') {
                    // Make the move
                    board[i][j] = 'o';

                    // Call minimax recursively and choose
                    // the minimum value
                    best = std::min(best, minimax(depth+1, !isMax));

                    // Undo the move
                    board[i][j] = ' ';
                }
            }
        }
        return best;
    }
}

std::pair<int,int> Ttt::find_best_move()
{
    int bestVal = -1000, row = -1, col = -1;

    // Traverse all cells, evalutae minimax function for
    // all empty cells. And return the cell with optimal
    // value.
    for (decltype(board)::size_type i = 0; i<board.size(); ++i) {
        for (decltype(i) j = 0; j<board[0].size(); ++j) {
            // Check if celll is empty
            if (board[i][j]==' ') {
                // Make the move
                board[i][j] = 'x';

                // compute evaluation function for this
                // move.
                int moveVal = minimax(0, false);

                // Undo the move
                board[i][j] = ' ';

                // If the value of the current move is
                // more than the best value, then update
                // best/
                if (moveVal > bestVal) {
                    row = i;
                    col = j;
                    bestVal = moveVal;
                }
            }
        }
    }

    return std::pair<int,int>(row, col);
}

void Ttt::newGame()
{
    for (auto& row: board)
        for (auto& cell: row)
            cell = ' ';
    emit clearBoard();
}

void Ttt::quitGame()
{
    for (auto& row: board)
        for (auto& cell: row)
            cell = ' ';
    emit clearBoard();
}

void Ttt::getScore()
{
    QString won = QString::number(win);
    QString lost = QString::number(loose);
    QString drawed = QString::number(draw);
    emit scoreBoard(won, lost, drawed);
}
