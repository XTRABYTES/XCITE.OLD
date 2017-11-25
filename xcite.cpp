#include "xcite.h"
#include "ui_xcite.h"

Xcite::Xcite(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::Xcite)
{
    ui->setupUi(this);
}

Xcite::~Xcite()
{
    delete ui;
}
