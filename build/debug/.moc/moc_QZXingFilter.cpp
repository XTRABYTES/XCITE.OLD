/****************************************************************************
** Meta object code from reading C++ file 'QZXingFilter.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/support/QZXing/QZXingFilter.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'QZXingFilter.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_QZXingFilter_t {
    QByteArrayData data[14];
    char stringdata0[187];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QZXingFilter_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QZXingFilter_t qt_meta_stringdata_QZXingFilter = {
    {
QT_MOC_LITERAL(0, 0, 12), // "QZXingFilter"
QT_MOC_LITERAL(1, 13, 17), // "isDecodingChanged"
QT_MOC_LITERAL(2, 31, 0), // ""
QT_MOC_LITERAL(3, 32, 16), // "decodingFinished"
QT_MOC_LITERAL(4, 49, 9), // "succeeded"
QT_MOC_LITERAL(5, 59, 10), // "decodeTime"
QT_MOC_LITERAL(6, 70, 15), // "decodingStarted"
QT_MOC_LITERAL(7, 86, 18), // "captureRectChanged"
QT_MOC_LITERAL(8, 105, 21), // "handleDecodingStarted"
QT_MOC_LITERAL(9, 127, 22), // "handleDecodingFinished"
QT_MOC_LITERAL(10, 150, 8), // "decoding"
QT_MOC_LITERAL(11, 159, 7), // "decoder"
QT_MOC_LITERAL(12, 167, 7), // "QZXing*"
QT_MOC_LITERAL(13, 175, 11) // "captureRect"

    },
    "QZXingFilter\0isDecodingChanged\0\0"
    "decodingFinished\0succeeded\0decodeTime\0"
    "decodingStarted\0captureRectChanged\0"
    "handleDecodingStarted\0handleDecodingFinished\0"
    "decoding\0decoder\0QZXing*\0captureRect"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QZXingFilter[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       3,   56, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   44,    2, 0x06 /* Public */,
       3,    2,   45,    2, 0x06 /* Public */,
       6,    0,   50,    2, 0x06 /* Public */,
       7,    0,   51,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       8,    0,   52,    2, 0x08 /* Private */,
       9,    1,   53,    2, 0x08 /* Private */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool, QMetaType::Int,    4,    5,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,    4,

 // properties: name, type, flags
      10, QMetaType::Bool, 0x00495001,
      11, 0x80000000 | 12, 0x00095009,
      13, QMetaType::QRectF, 0x00495003,

 // properties: notify_signal_id
       0,
       0,
       3,

       0        // eod
};

void QZXingFilter::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QZXingFilter *_t = static_cast<QZXingFilter *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->isDecodingChanged(); break;
        case 1: _t->decodingFinished((*reinterpret_cast< bool(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 2: _t->decodingStarted(); break;
        case 3: _t->captureRectChanged(); break;
        case 4: _t->handleDecodingStarted(); break;
        case 5: _t->handleDecodingFinished((*reinterpret_cast< bool(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (QZXingFilter::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QZXingFilter::isDecodingChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (QZXingFilter::*)(bool , int );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QZXingFilter::decodingFinished)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (QZXingFilter::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QZXingFilter::decodingStarted)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (QZXingFilter::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QZXingFilter::captureRectChanged)) {
                *result = 3;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 1:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QZXing* >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        QZXingFilter *_t = static_cast<QZXingFilter *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = _t->isDecoding(); break;
        case 1: *reinterpret_cast< QZXing**>(_v) = _t->getDecoder(); break;
        case 2: *reinterpret_cast< QRectF*>(_v) = _t->captureRect; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        QZXingFilter *_t = static_cast<QZXingFilter *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 2:
            if (_t->captureRect != *reinterpret_cast< QRectF*>(_v)) {
                _t->captureRect = *reinterpret_cast< QRectF*>(_v);
                Q_EMIT _t->captureRectChanged();
            }
            break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject QZXingFilter::staticMetaObject = {
    { &QAbstractVideoFilter::staticMetaObject, qt_meta_stringdata_QZXingFilter.data,
      qt_meta_data_QZXingFilter,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *QZXingFilter::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QZXingFilter::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_QZXingFilter.stringdata0))
        return static_cast<void*>(this);
    return QAbstractVideoFilter::qt_metacast(_clname);
}

int QZXingFilter::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractVideoFilter::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 6;
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
void QZXingFilter::isDecodingChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void QZXingFilter::decodingFinished(bool _t1, int _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void QZXingFilter::decodingStarted()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void QZXingFilter::captureRectChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}
struct qt_meta_stringdata_QZXingFilterRunnable_t {
    QByteArrayData data[1];
    char stringdata0[21];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QZXingFilterRunnable_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QZXingFilterRunnable_t qt_meta_stringdata_QZXingFilterRunnable = {
    {
QT_MOC_LITERAL(0, 0, 20) // "QZXingFilterRunnable"

    },
    "QZXingFilterRunnable"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QZXingFilterRunnable[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

       0        // eod
};

void QZXingFilterRunnable::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    Q_UNUSED(_o);
    Q_UNUSED(_id);
    Q_UNUSED(_c);
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject QZXingFilterRunnable::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QZXingFilterRunnable.data,
      qt_meta_data_QZXingFilterRunnable,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *QZXingFilterRunnable::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QZXingFilterRunnable::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_QZXingFilterRunnable.stringdata0))
        return static_cast<void*>(this);
    if (!strcmp(_clname, "QVideoFilterRunnable"))
        return static_cast< QVideoFilterRunnable*>(this);
    return QObject::qt_metacast(_clname);
}

int QZXingFilterRunnable::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
