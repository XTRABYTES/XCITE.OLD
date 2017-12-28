#-------------------------------------------------
#
# XCITE project created by XBY developers
#
#-------------------------------------------------

VERSION = 0.0.0

QT	+= core gui
QT	+= xml
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
	    backend/xchat/xchat.cpp \
	    backend/xchat/xchataiml.cpp \
	    backend/p2p/p2p.cpp 

RESOURCES += resources/resources.qrc
RESOURCES += frontend/frontend.qrc

QML2_IMPORT_PATH += frontend/EmbeddedAuto
include("frontend/GridStarLayout/quickgridstarlayout.pri")

HEADERS  += backend/xchat/xchat.hpp \
	    backend/xchat/xchataiml.hpp \
	    backend/p2p/p2p.hpp 

