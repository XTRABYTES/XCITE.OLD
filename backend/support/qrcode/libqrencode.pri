DEFINES += __STATIC=static MAJOR_VERSION=3 MINOR_VERSION=9 MICRO_VERSION=0 VERSION=\'\"3.9.0\"\'

INCLUDEPATH += $$PWD

SOURCES += \
            backend/support/qrcode/libqrencode/bitstream.c \
            backend/support/qrcode/libqrencode/qrencode.c \
            backend/support/qrcode/libqrencode/mqrspec.c \
            backend/support/qrcode/libqrencode/qrinput.c \
            backend/support/qrcode/libqrencode/split.c \
            backend/support/qrcode/libqrencode/qrspec.c \
            backend/support/qrcode/libqrencode/rsecc.c \
            backend/support/qrcode/libqrencode/mmask.c \
            backend/support/qrcode/libqrencode/mask.c
