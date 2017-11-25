#include "xcite.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Xcite w;
    w.show();

    return a.exec();
}
