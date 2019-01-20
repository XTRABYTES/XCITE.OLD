/****************************************************************************
** Meta object code from reading C++ file 'QZXing.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/support/QZXing/QZXing.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'QZXing.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_QZXing_t {
    QByteArrayData data[64];
    char stringdata0[969];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QZXing_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QZXing_t qt_meta_stringdata_QZXing = {
    {
QT_MOC_LITERAL(0, 0, 6), // "QZXing"
QT_MOC_LITERAL(1, 7, 15), // "decodingStarted"
QT_MOC_LITERAL(2, 23, 0), // ""
QT_MOC_LITERAL(3, 24, 16), // "decodingFinished"
QT_MOC_LITERAL(4, 41, 9), // "succeeded"
QT_MOC_LITERAL(5, 51, 21), // "enabledFormatsChanged"
QT_MOC_LITERAL(6, 73, 8), // "tagFound"
QT_MOC_LITERAL(7, 82, 3), // "tag"
QT_MOC_LITERAL(8, 86, 16), // "tagFoundAdvanced"
QT_MOC_LITERAL(9, 103, 6), // "format"
QT_MOC_LITERAL(10, 110, 7), // "charSet"
QT_MOC_LITERAL(11, 118, 4), // "rect"
QT_MOC_LITERAL(12, 123, 5), // "error"
QT_MOC_LITERAL(13, 129, 3), // "msg"
QT_MOC_LITERAL(14, 133, 11), // "decodeImage"
QT_MOC_LITERAL(15, 145, 5), // "image"
QT_MOC_LITERAL(16, 151, 8), // "maxWidth"
QT_MOC_LITERAL(17, 160, 9), // "maxHeight"
QT_MOC_LITERAL(18, 170, 20), // "smoothTransformation"
QT_MOC_LITERAL(19, 191, 19), // "decodeImageFromFile"
QT_MOC_LITERAL(20, 211, 13), // "imageFilePath"
QT_MOC_LITERAL(21, 225, 14), // "decodeImageQML"
QT_MOC_LITERAL(22, 240, 4), // "item"
QT_MOC_LITERAL(23, 245, 17), // "decodeSubImageQML"
QT_MOC_LITERAL(24, 263, 7), // "offsetX"
QT_MOC_LITERAL(25, 271, 7), // "offsetY"
QT_MOC_LITERAL(26, 279, 5), // "width"
QT_MOC_LITERAL(27, 285, 6), // "height"
QT_MOC_LITERAL(28, 292, 8), // "imageUrl"
QT_MOC_LITERAL(29, 301, 10), // "encodeData"
QT_MOC_LITERAL(30, 312, 4), // "data"
QT_MOC_LITERAL(31, 317, 13), // "EncoderFormat"
QT_MOC_LITERAL(32, 331, 13), // "encoderFormat"
QT_MOC_LITERAL(33, 345, 16), // "encoderImageSize"
QT_MOC_LITERAL(34, 362, 26), // "EncodeErrorCorrectionLevel"
QT_MOC_LITERAL(35, 389, 20), // "errorCorrectionLevel"
QT_MOC_LITERAL(36, 410, 28), // "getProcessTimeOfLastDecoding"
QT_MOC_LITERAL(37, 439, 17), // "getEnabledFormats"
QT_MOC_LITERAL(38, 457, 10), // "setDecoder"
QT_MOC_LITERAL(39, 468, 4), // "hint"
QT_MOC_LITERAL(40, 473, 13), // "foundedFormat"
QT_MOC_LITERAL(41, 487, 14), // "processingTime"
QT_MOC_LITERAL(42, 502, 15), // "enabledDecoders"
QT_MOC_LITERAL(43, 518, 9), // "tryHarder"
QT_MOC_LITERAL(44, 528, 13), // "DecoderFormat"
QT_MOC_LITERAL(45, 542, 18), // "DecoderFormat_None"
QT_MOC_LITERAL(46, 561, 19), // "DecoderFormat_Aztec"
QT_MOC_LITERAL(47, 581, 21), // "DecoderFormat_CODABAR"
QT_MOC_LITERAL(48, 603, 21), // "DecoderFormat_CODE_39"
QT_MOC_LITERAL(49, 625, 21), // "DecoderFormat_CODE_93"
QT_MOC_LITERAL(50, 647, 22), // "DecoderFormat_CODE_128"
QT_MOC_LITERAL(51, 670, 25), // "DecoderFormat_DATA_MATRIX"
QT_MOC_LITERAL(52, 696, 19), // "DecoderFormat_EAN_8"
QT_MOC_LITERAL(53, 716, 20), // "DecoderFormat_EAN_13"
QT_MOC_LITERAL(54, 737, 17), // "DecoderFormat_ITF"
QT_MOC_LITERAL(55, 755, 22), // "DecoderFormat_MAXICODE"
QT_MOC_LITERAL(56, 778, 21), // "DecoderFormat_PDF_417"
QT_MOC_LITERAL(57, 800, 21), // "DecoderFormat_QR_CODE"
QT_MOC_LITERAL(58, 822, 20), // "DecoderFormat_RSS_14"
QT_MOC_LITERAL(59, 843, 26), // "DecoderFormat_RSS_EXPANDED"
QT_MOC_LITERAL(60, 870, 19), // "DecoderFormat_UPC_A"
QT_MOC_LITERAL(61, 890, 19), // "DecoderFormat_UPC_E"
QT_MOC_LITERAL(62, 910, 31), // "DecoderFormat_UPC_EAN_EXTENSION"
QT_MOC_LITERAL(63, 942, 26) // "DecoderFormat_CODE_128_GS1"

    },
    "QZXing\0decodingStarted\0\0decodingFinished\0"
    "succeeded\0enabledFormatsChanged\0"
    "tagFound\0tag\0tagFoundAdvanced\0format\0"
    "charSet\0rect\0error\0msg\0decodeImage\0"
    "image\0maxWidth\0maxHeight\0smoothTransformation\0"
    "decodeImageFromFile\0imageFilePath\0"
    "decodeImageQML\0item\0decodeSubImageQML\0"
    "offsetX\0offsetY\0width\0height\0imageUrl\0"
    "encodeData\0data\0EncoderFormat\0"
    "encoderFormat\0encoderImageSize\0"
    "EncodeErrorCorrectionLevel\0"
    "errorCorrectionLevel\0getProcessTimeOfLastDecoding\0"
    "getEnabledFormats\0setDecoder\0hint\0"
    "foundedFormat\0processingTime\0"
    "enabledDecoders\0tryHarder\0DecoderFormat\0"
    "DecoderFormat_None\0DecoderFormat_Aztec\0"
    "DecoderFormat_CODABAR\0DecoderFormat_CODE_39\0"
    "DecoderFormat_CODE_93\0DecoderFormat_CODE_128\0"
    "DecoderFormat_DATA_MATRIX\0DecoderFormat_EAN_8\0"
    "DecoderFormat_EAN_13\0DecoderFormat_ITF\0"
    "DecoderFormat_MAXICODE\0DecoderFormat_PDF_417\0"
    "DecoderFormat_QR_CODE\0DecoderFormat_RSS_14\0"
    "DecoderFormat_RSS_EXPANDED\0"
    "DecoderFormat_UPC_A\0DecoderFormat_UPC_E\0"
    "DecoderFormat_UPC_EAN_EXTENSION\0"
    "DecoderFormat_CODE_128_GS1"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QZXing[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      36,   14, // methods
       3,  376, // properties
       1,  388, // enums/sets
       0,    0, // constructors
       0,       // flags
       7,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,  194,    2, 0x06 /* Public */,
       3,    1,  195,    2, 0x06 /* Public */,
       5,    0,  198,    2, 0x06 /* Public */,
       6,    1,  199,    2, 0x06 /* Public */,
       8,    3,  202,    2, 0x06 /* Public */,
       8,    4,  209,    2, 0x06 /* Public */,
      12,    1,  218,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      14,    4,  221,    2, 0x0a /* Public */,
      14,    3,  230,    2, 0x2a /* Public | MethodCloned */,
      14,    2,  237,    2, 0x2a /* Public | MethodCloned */,
      14,    1,  242,    2, 0x2a /* Public | MethodCloned */,
      19,    4,  245,    2, 0x0a /* Public */,
      19,    3,  254,    2, 0x2a /* Public | MethodCloned */,
      19,    2,  261,    2, 0x2a /* Public | MethodCloned */,
      19,    1,  266,    2, 0x2a /* Public | MethodCloned */,
      21,    1,  269,    2, 0x0a /* Public */,
      23,    5,  272,    2, 0x0a /* Public */,
      23,    4,  283,    2, 0x2a /* Public | MethodCloned */,
      23,    3,  292,    2, 0x2a /* Public | MethodCloned */,
      23,    2,  299,    2, 0x2a /* Public | MethodCloned */,
      23,    1,  304,    2, 0x2a /* Public | MethodCloned */,
      21,    1,  307,    2, 0x0a /* Public */,
      23,    5,  310,    2, 0x0a /* Public */,
      23,    4,  321,    2, 0x2a /* Public | MethodCloned */,
      23,    3,  330,    2, 0x2a /* Public | MethodCloned */,
      23,    2,  337,    2, 0x2a /* Public | MethodCloned */,
      23,    1,  342,    2, 0x2a /* Public | MethodCloned */,
      29,    4,  345,    2, 0x0a /* Public */,
      29,    3,  354,    2, 0x2a /* Public | MethodCloned */,
      29,    2,  361,    2, 0x2a /* Public | MethodCloned */,
      29,    1,  366,    2, 0x2a /* Public | MethodCloned */,
      36,    0,  369,    2, 0x0a /* Public */,
      37,    0,  370,    2, 0x0a /* Public */,
      38,    1,  371,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      40,    0,  374,    2, 0x02 /* Public */,
      10,    0,  375,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,    4,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    7,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString,    7,    9,   10,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QRectF,    7,    9,   10,   11,
    QMetaType::Void, QMetaType::QString,   13,

 // slots: parameters
    QMetaType::QString, QMetaType::QImage, QMetaType::Int, QMetaType::Int, QMetaType::Bool,   15,   16,   17,   18,
    QMetaType::QString, QMetaType::QImage, QMetaType::Int, QMetaType::Int,   15,   16,   17,
    QMetaType::QString, QMetaType::QImage, QMetaType::Int,   15,   16,
    QMetaType::QString, QMetaType::QImage,   15,
    QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int, QMetaType::Bool,   20,   16,   17,   18,
    QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int,   20,   16,   17,
    QMetaType::QString, QMetaType::QString, QMetaType::Int,   20,   16,
    QMetaType::QString, QMetaType::QString,   20,
    QMetaType::QString, QMetaType::QObjectStar,   22,
    QMetaType::QString, QMetaType::QObjectStar, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   22,   24,   25,   26,   27,
    QMetaType::QString, QMetaType::QObjectStar, QMetaType::Int, QMetaType::Int, QMetaType::Int,   22,   24,   25,   26,
    QMetaType::QString, QMetaType::QObjectStar, QMetaType::Int, QMetaType::Int,   22,   24,   25,
    QMetaType::QString, QMetaType::QObjectStar, QMetaType::Int,   22,   24,
    QMetaType::QString, QMetaType::QObjectStar,   22,
    QMetaType::QString, QMetaType::QUrl,   28,
    QMetaType::QString, QMetaType::QUrl, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   28,   24,   25,   26,   27,
    QMetaType::QString, QMetaType::QUrl, QMetaType::Int, QMetaType::Int, QMetaType::Int,   28,   24,   25,   26,
    QMetaType::QString, QMetaType::QUrl, QMetaType::Int, QMetaType::Int,   28,   24,   25,
    QMetaType::QString, QMetaType::QUrl, QMetaType::Int,   28,   24,
    QMetaType::QString, QMetaType::QUrl,   28,
    QMetaType::QImage, QMetaType::QString, 0x80000000 | 31, QMetaType::QSize, 0x80000000 | 34,   30,   32,   33,   35,
    QMetaType::QImage, QMetaType::QString, 0x80000000 | 31, QMetaType::QSize,   30,   32,   33,
    QMetaType::QImage, QMetaType::QString, 0x80000000 | 31,   30,   32,
    QMetaType::QImage, QMetaType::QString,   30,
    QMetaType::Int,
    QMetaType::UInt,
    QMetaType::Void, QMetaType::UInt,   39,

 // methods: parameters
    QMetaType::QString,
    QMetaType::QString,

 // properties: name, type, flags
      41, QMetaType::Int, 0x00095001,
      42, QMetaType::UInt, 0x00495003,
      43, QMetaType::Bool, 0x00095103,

 // properties: notify_signal_id
       0,
       2,
       0,

 // enums: name, flags, count, data
      44, 0x0,   19,  392,

 // enum data: key, value
      45, uint(QZXing::DecoderFormat_None),
      46, uint(QZXing::DecoderFormat_Aztec),
      47, uint(QZXing::DecoderFormat_CODABAR),
      48, uint(QZXing::DecoderFormat_CODE_39),
      49, uint(QZXing::DecoderFormat_CODE_93),
      50, uint(QZXing::DecoderFormat_CODE_128),
      51, uint(QZXing::DecoderFormat_DATA_MATRIX),
      52, uint(QZXing::DecoderFormat_EAN_8),
      53, uint(QZXing::DecoderFormat_EAN_13),
      54, uint(QZXing::DecoderFormat_ITF),
      55, uint(QZXing::DecoderFormat_MAXICODE),
      56, uint(QZXing::DecoderFormat_PDF_417),
      57, uint(QZXing::DecoderFormat_QR_CODE),
      58, uint(QZXing::DecoderFormat_RSS_14),
      59, uint(QZXing::DecoderFormat_RSS_EXPANDED),
      60, uint(QZXing::DecoderFormat_UPC_A),
      61, uint(QZXing::DecoderFormat_UPC_E),
      62, uint(QZXing::DecoderFormat_UPC_EAN_EXTENSION),
      63, uint(QZXing::DecoderFormat_CODE_128_GS1),

       0        // eod
};

void QZXing::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QZXing *_t = static_cast<QZXing *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->decodingStarted(); break;
        case 1: _t->decodingFinished((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 2: _t->enabledFormatsChanged(); break;
        case 3: _t->tagFound((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 4: _t->tagFoundAdvanced((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3]))); break;
        case 5: _t->tagFoundAdvanced((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QRectF(*)>(_a[4]))); break;
        case 6: _t->error((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 7: { QString _r = _t->decodeImage((*reinterpret_cast< const QImage(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< bool(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 8: { QString _r = _t->decodeImage((*reinterpret_cast< const QImage(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 9: { QString _r = _t->decodeImage((*reinterpret_cast< const QImage(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 10: { QString _r = _t->decodeImage((*reinterpret_cast< const QImage(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 11: { QString _r = _t->decodeImageFromFile((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< bool(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 12: { QString _r = _t->decodeImageFromFile((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 13: { QString _r = _t->decodeImageFromFile((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 14: { QString _r = _t->decodeImageFromFile((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 15: { QString _r = _t->decodeImageQML((*reinterpret_cast< QObject*(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 16: { QString _r = _t->decodeSubImageQML((*reinterpret_cast< QObject*(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const int(*)>(_a[4])),(*reinterpret_cast< const int(*)>(_a[5])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 17: { QString _r = _t->decodeSubImageQML((*reinterpret_cast< QObject*(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const int(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 18: { QString _r = _t->decodeSubImageQML((*reinterpret_cast< QObject*(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 19: { QString _r = _t->decodeSubImageQML((*reinterpret_cast< QObject*(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 20: { QString _r = _t->decodeSubImageQML((*reinterpret_cast< QObject*(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 21: { QString _r = _t->decodeImageQML((*reinterpret_cast< const QUrl(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 22: { QString _r = _t->decodeSubImageQML((*reinterpret_cast< const QUrl(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const int(*)>(_a[4])),(*reinterpret_cast< const int(*)>(_a[5])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 23: { QString _r = _t->decodeSubImageQML((*reinterpret_cast< const QUrl(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])),(*reinterpret_cast< const int(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 24: { QString _r = _t->decodeSubImageQML((*reinterpret_cast< const QUrl(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])),(*reinterpret_cast< const int(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 25: { QString _r = _t->decodeSubImageQML((*reinterpret_cast< const QUrl(*)>(_a[1])),(*reinterpret_cast< const int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 26: { QString _r = _t->decodeSubImageQML((*reinterpret_cast< const QUrl(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 27: { QImage _r = _t->encodeData((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const EncoderFormat(*)>(_a[2])),(*reinterpret_cast< const QSize(*)>(_a[3])),(*reinterpret_cast< const EncodeErrorCorrectionLevel(*)>(_a[4])));
            if (_a[0]) *reinterpret_cast< QImage*>(_a[0]) = std::move(_r); }  break;
        case 28: { QImage _r = _t->encodeData((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const EncoderFormat(*)>(_a[2])),(*reinterpret_cast< const QSize(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QImage*>(_a[0]) = std::move(_r); }  break;
        case 29: { QImage _r = _t->encodeData((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const EncoderFormat(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QImage*>(_a[0]) = std::move(_r); }  break;
        case 30: { QImage _r = _t->encodeData((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QImage*>(_a[0]) = std::move(_r); }  break;
        case 31: { int _r = _t->getProcessTimeOfLastDecoding();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 32: { uint _r = _t->getEnabledFormats();
            if (_a[0]) *reinterpret_cast< uint*>(_a[0]) = std::move(_r); }  break;
        case 33: _t->setDecoder((*reinterpret_cast< const uint(*)>(_a[1]))); break;
        case 34: { QString _r = _t->foundedFormat();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 35: { QString _r = _t->charSet();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (QZXing::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QZXing::decodingStarted)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (QZXing::*)(bool );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QZXing::decodingFinished)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (QZXing::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QZXing::enabledFormatsChanged)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (QZXing::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QZXing::tagFound)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (QZXing::*)(const QString & , const QString & , const QString & ) const;
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QZXing::tagFoundAdvanced)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (QZXing::*)(const QString & , const QString & , const QString & , const QRectF & ) const;
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QZXing::tagFoundAdvanced)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (QZXing::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QZXing::error)) {
                *result = 6;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        QZXing *_t = static_cast<QZXing *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = _t->getProcessTimeOfLastDecoding(); break;
        case 1: *reinterpret_cast< uint*>(_v) = _t->getEnabledFormats(); break;
        case 2: *reinterpret_cast< bool*>(_v) = _t->getTryHarder(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        QZXing *_t = static_cast<QZXing *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 1: _t->setDecoder(*reinterpret_cast< uint*>(_v)); break;
        case 2: _t->setTryHarder(*reinterpret_cast< bool*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject QZXing::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QZXing.data,
      qt_meta_data_QZXing,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *QZXing::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QZXing::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_QZXing.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int QZXing::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 36)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 36;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 36)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 36;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void QZXing::decodingStarted()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void QZXing::decodingFinished(bool _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void QZXing::enabledFormatsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void QZXing::tagFound(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void QZXing::tagFoundAdvanced(const QString & _t1, const QString & _t2, const QString & _t3)const
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(const_cast< QZXing *>(this), &staticMetaObject, 4, _a);
}

// SIGNAL 5
void QZXing::tagFoundAdvanced(const QString & _t1, const QString & _t2, const QString & _t3, const QRectF & _t4)const
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)), const_cast<void*>(reinterpret_cast<const void*>(&_t4)) };
    QMetaObject::activate(const_cast< QZXing *>(this), &staticMetaObject, 5, _a);
}

// SIGNAL 6
void QZXing::error(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
