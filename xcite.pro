#
# Filename: xcite.pro
#
# XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
# blockchain protocol to host decentralized applications
#
# Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
#
# This file is part of an XTRABYTES Ltd. project.
#

VERSION_MAJOR=0
VERSION_MINOR=3
VERSION_BUILD=0

VERSION = $${VERSION_MAJOR}.$${VERSION_MINOR}.$${VERSION_BUILD}

QT	+= core gui xml quick svg charts
CONFIG	+= c++11

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += "VERSION_MAJOR=$$VERSION_MAJOR" \
    "VERSION_MINOR=$$VERSION_MINOR" \
    "VERSION_BUILD=$$VERSION_BUILD"

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

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

include(backend/support/qrcode/libqrencode.pri)
include(backend/support/qrcode/qt-qrcode.pri)

SOURCES += main/main.cpp \
	    backend/xchat/xchat.cpp \
	    backend/xchat/xchataiml.cpp \
            backend/p2p/p2p.cpp \
            frontend/support/sortfilterproxymodel.cpp \
            backend/xchat/xchatconversationmodel.cpp \
            backend/XCITE/nodes/nodetransaction.cpp \
            backend/testnet/testnet.cpp \
            backend/testnet/transactionmodel.cpp \
            backend/addressbook/addressbookmodel.cpp \
            backend/support/ClipboardProxy.cpp \
            backend/support/globaleventfilter.cpp \
            backend/testnet/xchattestnetclient.cpp \
            backend/integrations/MarketValue.cpp \
            backend/support/ReleaseChecker.cpp \
            backend/support/FileDownloader.cpp \
    backend/support/Settings.cpp

RESOURCES += resources/resources.qrc
RESOURCES += frontend/frontend.qrc

HEADERS  += backend/xchat/xchat.hpp \
	    backend/xchat/xchataiml.hpp \
            backend/p2p/p2p.hpp \
            frontend/support/sortfilterproxymodel.hpp \
            backend/xchat/xchatconversationmodel.hpp \
            backend/XCITE/nodes/nodetransaction.h \
            backend/testnet/testnet.hpp \
            backend/testnet/transactionmodel.hpp \
            backend/addressbook/addressbookmodel.hpp \
            backend/support/ClipboardProxy.hpp \
            backend/support/globaleventfilter.hpp \
            backend/testnet/xchattestnetclient.hpp \
            backend/integrations/MarketValue.hpp \
            backend/support/ReleaseChecker.hpp \
            backend/support/FileDownloader.hpp \
    backend/support/Settings.hpp

DISTFILES += \
    xcite.ico \
    packages/global.xtrabytes.xcite/meta/package.xml \
    config/config.xml \
    packages/global.xtrabytes.xcite/meta/installscript.qs \
    packages/global.xtrabytes.xcite/meta/license.txt \
    config/banner.png \
    config/logo.png

RC_ICONS = xcite.ico
CONFIG(debug, debug|release) {
    DESTDIR = $$PWD/build/debug
} else {
    DESTDIR = $$PWD/build/release
}

win32 {
    # Copy OpenSSL DDLs into the build dir on Windows
    DESTDIR_WIN = $${DESTDIR}
    DESTDIR_WIN ~= s,/,\\,g
    PWD_WIN = $${PWD}
    PWD_WIN ~= s,/,\\,g
    QMAKE_POST_LINK += $$quote(cmd /c copy /y \"$${PWD_WIN}\\support\\*.dll\" \"$${DESTDIR_WIN}\")
}

mac {
    ICON = resources/ios/xcite.icns

    macx {
    }
    else:ios {
        xcode_product_bundle_identifier_setting.value = "global.xtrabytes.xcite"
        QMAKE_INFO_PLIST = resources/ios/Info.plist
        app_launch_images.files = resources/ios/LaunchScreen.storyboard resources/backgrounds/launchscreen-logo.png
        QMAKE_BUNDLE_DATA += app_launch_images
    }
}

FORMS += \
    packages/global.xtrabytes.xcite/meta/feedbackpage.ui
