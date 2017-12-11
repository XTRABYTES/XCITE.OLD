#-------------------------------------------------
#
# XCITE project created by XBY developers
#
#-------------------------------------------------

VERSION = 0.0.0

QT	+= core gui
QT	+= quick
CONFIG	+= c++11

DEFINES += QT_DEPRECATED_WARNINGS

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = xcite
TEMPLATE = app

CONFIG(debug, debug|release) {
    DESTDIR = build/debug
}
CONFIG(release, debug|release) {
    DESTDIR = build/release
}

OBJECTS_DIR = $$DESTDIR/.obj
MOC_DIR = $$DESTDIR/.moc
RCC_DIR = $$DESTDIR/.qrc
UI_DIR = $$DESTDIR/.u

SOURCES += main/main.cpp \
	    backend/backend.cpp \
	    backend/iobject.cpp

RESOURCES += frontend/qml.qrc

HEADERS  += backend/backend.hpp \
	    backend/iobject.hpp

