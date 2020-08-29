#
# Filename: xcite.pro
#
# XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
# blockchain protocol to host decentralized applications
#
# Copyright (c) 2017-2020 Zoltan Szabo & XTRABYTES developers
#
# This file is part of an XTRABYTES Ltd. project.
#

VERSION_MAJOR=0
VERSION_MINOR=3
VERSION_BUILD=0

VERSION = $${VERSION_MAJOR}.$${VERSION_MINOR}.$${VERSION_BUILD}

QT	+= core gui xml quick svg charts sql  network
CONFIG  += c++11 qzxing_multimedia qzxing_qml
CONFIG += resources_big
CONFIG += static


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
#include(backend/support/QAMQP/qamqp.pri)
include(frontend/support/SortFilterProxyModel/SortFilterProxyModel.pri)

SOURCES +=  main/main.cpp \
            backend/integrations/Cex.cpp \
            backend/support/ttt.cpp \
            backend/xchat/xchat.cpp \
            backend/xchat/xchataiml.cpp \
            backend/staticnet/staticnet.cpp \
            backend/xgames/XGames.cpp \
            backend/xutility/BrokerConnection.cpp \
            backend/xutility/xutility.cpp \
            backend/xutility/crypto/ctools.cpp \
            backend/xutility/transaction/transaction.cpp \
            backend/xchat/xchatconversationmodel.cpp \
            backend/XCITE/nodes/nodetransaction.cpp \
            backend/addressbook/addressbookmodel.cpp \
            backend/support/ClipboardProxy.cpp \
            backend/support/globaleventfilter.cpp \
            backend/integrations/MarketValue.cpp \
            backend/integrations/Explorer.cpp \
            # backend/support/ReleaseChecker.cpp \
            backend/support/FileDownloader.cpp \
            backend/support/Settings.cpp \
            backend/support/qaesencryption.cpp \
            backend/integrations/xutility_integration.cpp \
            backend/integrations/staticnet_integration.cpp \
            backend/support/DownloadManager.cpp


RESOURCES += resources/resources.qrc
RESOURCES += frontend/frontend.qrc

HEADERS  += backend/xchat/xchat.hpp \
            backend/integrations/Cex.hpp \
            backend/support/ttt.h \
            backend/xchat/xchataiml.hpp \
            backend/xgames/XGames.hpp \
            backend/xutility/BrokerConnection.h \
            backend/xutility/crypto/allocators.h \
            backend/xutility/crypto/ctools.h \
            backend/xutility/crypto/numbers.h \
            backend/xutility/transaction/transaction.h \
            backend/xutility/transaction/serialize.h \
            backend/xchat/xchatconversationmodel.hpp \
            backend/XCITE/nodes/nodetransaction.h \
            backend/staticnet/staticnet.hpp \
            backend/xutility/xutility.hpp \
            backend/addressbook/addressbookmodel.hpp \
            backend/support/ClipboardProxy.hpp \
            backend/support/globaleventfilter.hpp \
            backend/integrations/MarketValue.hpp \
            # backend/support/ReleaseChecker.hpp \
            backend/support/FileDownloader.hpp \
            backend/support/Settings.hpp \
            backend/integrations/MarketValue.hpp \
            backend/integrations/Explorer.hpp \
            backend/support/qaesencryption.h \
            backend/integrations/xutility_integration.hpp \
            backend/integrations/staticnet_integration.hpp \
            backend/support/DownloadManager.hpp \
            backend/support/URLObject.hpp

DISTFILES += \
    xcite.ico \
    packages/global.xtrabytes.xcite/meta/package.xml \
    config/config.xml \
    packages/global.xtrabytes.xcite/meta/installscript.qs \
    packages/global.xtrabytes.xcite/meta/license.txt \
    config/banner.png \
    config/logo.png \
    dev-db/xtrabytes \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    qml/qmlchart/* \
    android/res/drawable-mdpi/icon.png \
    android/res/drawable-mdpi/splash.png \
    android/res/drawable-ldpi/icon.png \
    android/res/drawable-ldpi/splash.png \
    android/res/drawable-hdpi/icon.png \
    android/res/drawable-hdpi/splash.png \
    android/res/drawable-xhdpi/splash.png \
    android/res/drawable-xxhdpi/splash.png \
    android/res/drawable-xxxhdpi/splash.png \
    resources/ios/xcite.icns \
    resources/ios/xcite152px.png \
    resources/ios/xcite120px.png \
    resources/ios/xcite180px.png

RC_ICONS = xcite.ico
# CONFIG(debug, debug|release) {
#    DESTDIR = $$PWD/build/debug
# } else {
#    DESTDIR = $$PWD/build/release
# }

win32 {

    win32-g++:contains(QT_ARCH, x86_64):{
      message("Compiling Windows x86_x64 (64-bit)")

      CONFIG(debug, debug|release) {
      DESTDIR = $$PWD/build/64_bit-debug
     } else {
      DESTDIR = $$PWD/build/64_bit-release
     }

# Copy OpenSSL DDLs into the build dir on Windows
      DESTDIR_WIN = $${DESTDIR}
      DESTDIR_WIN ~= s,/,\\,g
      PWD_WIN = $${PWD}
      PWD_WIN ~= s,/,\\,g
      QMAKE_POST_LINK += $$quote(cmd /c copy /y \"$${PWD_WIN}\\support\\*x64.dll\" \"$${DESTDIR_WIN}\")

# Dependency Location
      LIBS += -L$$PWD/dependencies/windows/openssl/lib/lib64 -llibssl -llibcrypto -lcrypt32 -lws2_32
      INCLUDEPATH += $$PWD/dependencies/include/openssl/include

#      LIBS += -L$$PWD/dependencies/windows/qtmqtt/lib/ -lQt5Mqtt
#      INCLUDEPATH += $$PWD/dependencies/windows/qtmqtt/include

      LIBS += -L$$PWD/dependencies/windows/boost/lib/ -llibboost_system-vc140-mt-1_60
      INCLUDEPATH += $$PWD/dependencies/include/boost/include

      LIBS += -L$$PWD/dependencies/windows/amqp/lib/ -llibamqpcpp

      LIBS += -L$$PWD/dependencies/windows/poco/64bit/ -llibPocoNet -llibPocoFoundation

      LIBS += -L$$PWD/dependencies/windows/qamqp/64bit/ -lqamqp
      INCLUDEPATH += $$PWD/dependencies/include/qamqp/include
    }

    else {
      message("Compiling Windows x86 (32-bit)")
      CONFIG(debug, debug|release) {
      DESTDIR = $$PWD/build/32_bit-debug
     } else {
      DESTDIR = $$PWD/build/32_bit-release
     }

# Copy OpenSSL DDLs into the build dir on Windows
      DESTDIR_WIN = $${DESTDIR}
      DESTDIR_WIN ~= s,/,\\,g
      PWD_WIN = $${PWD}
      PWD_WIN ~= s,/,\\,g
      QMAKE_POST_LINK += $$quote(cmd /c copy /y \"$${PWD_WIN}\\support\\*1_1.dll\" \"$${DESTDIR_WIN}\")

# Dependency Location
      LIBS += -L$$PWD/dependencies/windows/openssl/lib/lib32 -llibssl -llibcrypto -lcrypt32 -lws2_32
      INCLUDEPATH += $$PWD/dependencies/include/openssl/include

      LIBS += -L$$PWD/dependencies/windows/qtmqtt/lib/ -lQt5Mqtt
      INCLUDEPATH += $$PWD/dependencies/windows/qtmqtt/include

      LIBS += -L$$PWD/dependencies/windows/boost/lib/ -llibboost_system-vc140-mt-1_60
      INCLUDEPATH += $$PWD/dependencies/include/boost/include

      # LIBS += -L$$PWD/dependencies/windows/amqp/lib -llibamqpcpp

      LIBS += -L$$PWD/dependencies/windows/qamqp/32bit -llibqamqp
      INCLUDEPATH += $$PWD/dependencies/include/qamqp/include
    }

    INCLUDEPATH += $$PWD/dependencies/include/qamqp/include
    INCLUDEPATH += $$PWD/dependencies/include/amqpcpp
    INCLUDEPATH += $$PWD/dependencies/include/kashmir
    INCLUDEPATH += $$PWD/dependencies/include/poco

}

ios {
    QT += multimedia
    xcode_product_bundle_identifier_setting.value = "global.xtrabytes.xcite"
    QMAKE_INFO_PLIST = resources/ios/Info.plist
    app_launch_images.files = resources/ios/LaunchScreen.storyboard resources/backgrounds/launchScreen-logo_01.png
    QMAKE_BUNDLE_DATA += app_launch_images

    INCLUDEPATH += $$PWD/dependencies/include/openssl/include
    INCLUDEPATH += $$PWD/dependencies/include/boost/include
    INCLUDEPATH += $$PWD/dependencies/include/qamqp/include
    INCLUDEPATH += $$PWD/dependencies/include/amqpcpp
    INCLUDEPATH += $$PWD/dependencies/include/kashmir
    INCLUDEPATH += $$PWD/dependencies/include/poco

    LIBS += -L$$PWD/dependencies/ios/arm64-v8a/openssl/lib -lssl -lcrypto
    LIBS += -L$$PWD/dependencies/ios/x86_64/qamqp/ -lqamqp
    LIBS += -L$$PWD/dependencies/ios/x86_64/poco -lPocoFoundation -lPocoUtil -lPocoNet
    LIBS += -L$$PWD/dependencies/ios/x86_64/amqpcpp -lamqpcpp




    QMAKE_ASSET_CATALOGS = $$PWD/resources/ios/Images.xcassets
    QMAKE_ASSET_CATALOGS_APP_ICON = "AppIcon"
}

linux:!android {
    LIBS += -lssl -lcrypto
    LIBS += -lboost_system
    LIBS += -lamqpcpp
    LIBS += -lPocoFoundation -lPocoUtil -lPocoNet
}

android {
    CONFIG += static
    QT += multimedia androidextras

    android:contains(ANDROID_TARGET_ARCH,armeabi-v7a): {
      message("Compiling Android ARMv7 (32-bit)")

      LIBS += -L$$PWD/dependencies/android/armeabi-v7a/openssl/lib/lib32 -lssl -lcrypto
      INCLUDEPATH += $$PWD/dependencies/include/openssl/include

      LIBS += -L$$PWD/dependencies/android/armeabi-v7a/boost/lib/ -lboost_system
      INCLUDEPATH += $$PWD/dependencies/include/boost/include

      LIBS += -L$$PWD/dependencies/android/armeabi-v7a/qamqp/32bit/ -lqamqp
      LIBS += -L$$PWD/dependencies/android/armeabi-v7a/poco/32bit/ -lPocoFoundation -lPocoUtil -lPocoNet
      LIBS += -L$$PWD/dependencies/android/armeabi-v7a/amqpcpp/32bit/ -lamqpcpp


    }

    android:contains(ANDROID_TARGET_ARCH,arm64-v8a): {
      message("Compiling Android arm64-v8a (64-bit)")

      LIBS += -L$$PWD/dependencies/android/armeabi-v7a/openssl/lib/lib64 -lssl -lcrypto
      INCLUDEPATH += $$PWD/dependencies/include/openssl/include

      LIBS += -L$$PWD/dependencies/android/armeabi-v7a/boost/lib/ -lboost_system-mgw49-mt-d-1_60
      INCLUDEPATH += $$PWD/dependencies/include/boost/include

      LIBS += -L$$PWD/dependencies/android/armeabi-v7a/qamqp/64bit/ -lqamqp
      LIBS += -L$$PWD/dependencies/android/armeabi-v7a/poco/64bit/ -lPocoFoundation -lPocoUtil -lPocoNet
      LIBS += -L$$PWD/dependencies/android/armeabi-v7a/amqpcpp/64bit/ -lamqpcpp

    }

    INCLUDEPATH += $$PWD/dependencies/include/qamqp/include
    INCLUDEPATH += $$PWD/dependencies/include/amqpcpp
    INCLUDEPATH += $$PWD/dependencies/include/kashmir
    INCLUDEPATH += $$PWD/dependencies/include/poco




}

linux {
    LIBS += -L$$PWD/dependencies/linux/boost/lib/
    INCLUDEPATH += $$PWD/dependencies/include/boost/include

    LIBS += -L$$PWD/dependencies/linux/openssl/lib -lssl -lcrypto
    INCLUDEPATH += $$PWD/dependencies/include/openssl/include

    INCLUDEPATH += $$PWD/dependencies/include/qamqp/include
    LIBS += -L$$PWD/dependencies/linux/qamqp/ -lqamqp


}


macx {
        INCLUDEPATH += $$PWD/dependencies/include/openssl/include
        INCLUDEPATH += $$PWD/dependencies/include/boost/include
        INCLUDEPATH += $$PWD/dependencies/include/qamqp/include
        INCLUDEPATH += $$PWD/dependencies/include/amqpcpp
        INCLUDEPATH += $$PWD/dependencies/include/kashmir
        INCLUDEPATH += $$PWD/dependencies/include/poco



        LIBS += -L$$PWD/dependencies/macos/openssl/lib -lssl -lcrypto
        LIBS += -L$$PWD/dependencies/macos/qamqp -lqamqp
        LIBS += -L$$PWD/dependencies/macos/amqp-cpp -lamqpcpp
        LIBS += -L$$PWD/dependencies/macos/poco -lPocoFoundation -lPocoUtil -lPocoNet
}


FORMS += \
    packages/global.xtrabytes.xcite/meta/feedbackpage.ui

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {

    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android

    ANDROID_EXTRA_LIBS = \
        $$PWD/dependencies/android/armeabi-v7a/openssl/lib/lib32/libcrypto_1_1.so \
        $$PWD/dependencies/android/armeabi-v7a/openssl/lib/lib32/libssl_1_1.so \
        $$PWD/dependencies/android/armeabi-v7a/qamqp/32bit/libqamqp.so \
        $$PWD/dependencies/android/armeabi-v7a/poco/32bit/libPocoFoundation.so \
        $$PWD/dependencies/android/armeabi-v7a/poco/32bit/libPocoNet.so \
        $$PWD/dependencies/android/armeabi-v7a/poco/32bit/libPocoUtil.so \
        $$PWD/dependencies/android/armeabi-v7a/poco/32bit/libPocoXML.so \
        $$PWD/dependencies/android/armeabi-v7a/poco/32bit/libPocoJSON.so \
        $$PWD/dependencies/android/armeabi-v7a/amqpcpp/32bit/libamqpcpp.so

}


contains(ANDROID_TARGET_ARCH,arm64-v8a) {

    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android

    ANDROID_EXTRA_LIBS = \
        $$PWD/dependencies/android/armeabi-v7a/openssl/lib/lib64/libcrypto_1_1.so \
        $$PWD/dependencies/android/armeabi-v7a/openssl/lib/lib64/libssl_1_1.so \
        $$PWD/dependencies/android/armeabi-v7a/qamqp/64bit/libqamqp.so \
        $$PWD/dependencies/android/armeabi-v7a/poco/64bit/libPocoFoundation.so \
        $$PWD/dependencies/android/armeabi-v7a/poco/64bit/libPocoNet.so \
        $$PWD/dependencies/android/armeabi-v7a/poco/64bit/libPocoUtil.so \
        $$PWD/dependencies/android/armeabi-v7a/poco/64bit/libPocoXML.so \
        $$PWD/dependencies/android/armeabi-v7a/poco/64bit/libPocoJSON.so \
        $$PWD/dependencies/android/armeabi-v7a/amqpcpp/64bit/libamqpcpp.so

}
