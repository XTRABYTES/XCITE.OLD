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
CONFIG  += c++11 qzxing_multimedia qzxing_qml

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

include(backend/support/QZXing/QZXing.pri)
include(frontend/support/SortFilterProxyModel/SortFilterProxyModel.pri)

INCLUDEPATH += C:/Qt/Deps/boost160
#LIBS += -LC:/Qt/Deps/db-4.8.30.NC/build_windows
#LIBS += C:/Qt/Deps/boost_1_60_0/libs
#LIBS += C:/Qt/Deps/boost_1_60_0/stage/lib/libboost_system-mgw53-mt-1_60.a

BOOST_LIB_SUFFIX=-mgw53-mt-1_60
BOOST_INCLUDE_PATH=C:/Qt/Deps/boost_1_60_0
BOOST_LIB_PATH=C:/Qt/Deps/boost_1_60_0/libs
BDB_INCLUDE_PATH=C:/Qt/Deps/db-4.8.30.NC2/db-4.8.30.NC/build_unix
BDB_LIB_PATH=C:/Qt/Deps/db-4.8.30.NC2/db-4.8.30.NC/build_unix
OPENSSL_INCLUDE_PATH=C:/Qt/Deps/openssl-1.0.2q/include
OPENSSL_LIB_PATH=C:/Qt/Deps/openssl-1.0.2q
MINIUPNPC_INCLUDE_PATH=C:/Qt/Deps
MINIUPNPC_LIB_PATH=C:/Qt/Deps/miniupnpc

INCLUDEPATH += 3rdparty/leveldb/include 3rdparty/leveldb/helpers
INCLUDEPATH += 3rdparty/json
#INCLUDEPATH += C:\Qt\Deps\openssl-1.0.2q\include
#DEPENDPATH += C:\Qt\Deps\openssl-1.0.2q\include
#LIBS += C:\openssl_config\lib
#INCLUDEPATH += C:\Qt\Deps\boost_1_60_0
#DEPENDPATH += C:\Qt\Deps\boost_1_60_0
#INCLUDEPATH += C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\DIA SDK\include
#INCLUDEPATH += C:\Qt\Deps\db-4.8.30.NC\build_windows
#LIBS += C:\Berkeley_DB\lib

isEmpty(QMAKE_LRELEASE) {
    win32:QMAKE_LRELEASE = $$[QT_INSTALL_BINS]\\lrelease.exe
    else:QMAKE_LRELEASE = $$[QT_INSTALL_BINS]/lrelease
}

SOURCES += main/main.cpp \
	    backend/xchat/xchat.cpp \
	    backend/xchat/xchataiml.cpp \
            backend/p2p/p2p.cpp \
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
            backend/support/Settings.cpp \
	    backend/xfuel/addrman.cpp \
	    backend/xfuel/alert.cpp \
	    backend/xfuel/bloom.cpp \
	    backend/xfuel/checkpoints.cpp \
	    backend/xfuel/crypter.cpp \
	    backend/xfuel/db.cpp \
	    backend/xfuel/hash.cpp \
	    backend/xfuel/init.cpp \
	    backend/xfuel/key.cpp \
	    backend/xfuel/keystore.cpp \
	    backend/xfuel/leveldb.cpp \
	    backend/xfuel/xfuel.cpp \
	    backend/xfuel/netbase.cpp \
	    backend/xfuel/net.cpp \
	    backend/xfuel/noui.cpp \
	    backend/xfuel/protocol.cpp \
	    backend/xfuel/rpcblockchain.cpp \
	    backend/xfuel/rpcdump.cpp \
	    backend/xfuel/rpcnet.cpp \
	    backend/xfuel/rpcrawtransaction.cpp \
	    backend/xfuel/rpcwallet.cpp \
	    backend/xfuel/script.cpp \
	    backend/xfuel/sync.cpp \
	    backend/xfuel/txdb.cpp \
	    backend/xfuel/util.cpp \
	    backend/xfuel/version.cpp \
	    backend/xfuel/wallet.cpp \
	    backend/xfuel/walletdb.cpp \
	    backend/xfuel/xfuelrpc.cpp

RESOURCES += resources/resources.qrc
RESOURCES += frontend/frontend.qrc

HEADERS  += backend/xchat/xchat.hpp \
	    backend/xchat/xchataiml.hpp \
            backend/p2p/p2p.hpp \
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
	    backend/support/Settings.hpp \
    	    backend/integrations/MarketValue.hpp \
	    backend/xfuel/addrman.h \
	    backend/xfuel/alert.h \
	    backend/xfuel/allocators.h \
	    backend/xfuel/base58.h \
	    backend/xfuel/bignum.h \
	    backend/xfuel/bloom.h \
	    backend/xfuel/checkpoints.h \
	    backend/xfuel/checkqueue.h \
	    backend/xfuel/clientversion.h \
	    backend/xfuel/coincontrol.h \
	    backend/xfuel/compat.h \
	    backend/xfuel/crypter.h \
	    backend/xfuel/db.h \
	    backend/xfuel/hash.h \
	    backend/xfuel/init.h \
	    backend/xfuel/key.h \
	    backend/xfuel/keystore.h \
	    backend/xfuel/leveldb.h \
	    backend/xfuel/limitedmap.h \
	    backend/xfuel/xfuel.h \
	    backend/xfuel/mruset.h \
	    backend/xfuel/netbase.h \
	    backend/xfuel/net.h \
	    backend/xfuel/protocol.h \
	    backend/xfuel/script.h \
	    backend/xfuel/serialize.h \
	    backend/xfuel/sync.h \
	    backend/xfuel/threadsafety.h \
	    backend/xfuel/txdb.h \
	    backend/xfuel/ui_interface.h \
	    backend/xfuel/uint256.h \
	    backend/xfuel/util.h \
	    backend/xfuel/version.h \
	    backend/xfuel/walletdb.h \
	    backend/xfuel/wallet.h \
	    backend/xfuel/xfuelrpc.h

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

    mac!ios {
    }

    ios {
        QT += multimedia
        xcode_product_bundle_identifier_setting.value = "global.xtrabytes.xcite"
        QMAKE_INFO_PLIST = resources/ios/Info.plist
        app_launch_images.files = resources/ios/LaunchScreen.storyboard resources/backgrounds/launchscreen-logo.png
        QMAKE_BUNDLE_DATA += app_launch_images
    }
}

linux:!android {
}

android {
    QT += multimedia
}

#LIBS += -lboost_system-mgw53-mt-1_60 -lboost_filesystem -lboost_program_options -lboost_thread
#LIBS += -lssl -lcrypto -ldb_cxx

FORMS += \
    packages/global.xtrabytes.xcite/meta/feedbackpage.ui


# genleveldb.commands = cd $$PWD/3rdparty/leveldb && CC=$$QMAKE_CC CXX=$$QMAKE_CXX $(MAKE) OPT=\"$$QMAKE_CXXFLAGS $$QMAKE_CXXFLAGS_RELEASE\" libleveldb.a libmemenv.a
# genleveldb.target = $$PWD/3rdparty/leveldb/libleveldb.a
# genleveldb.depends = FORCE
# PRE_TARGETDEPS += $$PWD/3rdparty/leveldb/libleveldb.a
# QMAKE_EXTRA_TARGETS += genleveldb
# QMAKE_CLEAN += $$PWD/3rdparty/leveldb/libleveldb.a; cd $$PWD/3rdparty/leveldb ; $(MAKE) clean

# LIBS += $$PWD/3rdparty/leveldb/libleveldb.a $$PWD/3rdparty/leveldb/libmemenv.a
# Set libraries and includes at end, to use platform-defined defaults if not overridden

INCLUDEPATH += $$BOOST_INCLUDE_PATH $$BDB_INCLUDE_PATH $$OPENSSL_INCLUDE_PATH $$QRENCODE_INCLUDE_PATH $$MINIUPNPC_INCLUDE_PATH
LIBS += $$join(BOOST_LIB_PATH,,-L,) $$join(BDB_LIB_PATH,,-L,) $$join(OPENSSL_LIB_PATH,,-L,) $$join(QRENCODE_LIB_PATH,,-L,) $$join(MINIUPNPC_LIB_PATH,,-L,)
LIBS += -lssl -lcrypto -ldb_cxx$$BDB_LIB_SUFFIX
# -lgdi32 has to happen after -lcrypto (see  #681)
#windows:LIBS += -lws2_32 -lshlwapi -lmswsock -lole32 -loleaut32 -luuid -lgdi32
windows:LIBS += -lws2_32 -lshlwapi -lmswsock -lole32 -loleaut32 -luuid -lgdi32 -pthread

LIBS += -lboost_system$$BOOST_LIB_SUFFIX -lboost_filesystem$$BOOST_LIB_SUFFIX -lboost_program_options$$BOOST_LIB_SUFFIX -lboost_thread$$BOOST_LIB_SUFFIX
windows:LIBS += -lboost_chrono$$BOOST_LIB_SUFFIX

contains(RELEASE, 1) {
    !windows:!macx {
        # Linux: turn dynamic linking back on for c/c++ runtime libraries
        LIBS += -Wl,-Bdynamic
    }
}

system($$QMAKE_LRELEASE -silent $$_PRO_FILE_)
