INCLUDEPATH += $$PWD/qt-qrcode/lib

HEADERS += \
            backend/support/qrcode/qt-qrcode/QtQrCodeQuickItem.hpp \
            backend/support/qrcode/qt-qrcode/lib/qtqrcode.h \
            backend/support/qrcode/qt-qrcode/lib/qtqrcodepainter.h

SOURCES += \
            backend/support/qrcode/qt-qrcode/QtQrCodeQuickItem.cpp \
            backend/support/qrcode/qt-qrcode/lib/qtqrcode.cpp \
            backend/support/qrcode/qt-qrcode/lib/qtqrcodepainter.cpp
