#ifndef XCITE_H
#define XCITE_H

#include <QMainWindow>

namespace Ui {
class Xcite;
}

class Xcite : public QMainWindow
{
    Q_OBJECT

public:
    explicit Xcite(QWidget *parent = 0);
    ~Xcite();

private:
    Ui::Xcite *ui;
};

#endif // XCITE_H
