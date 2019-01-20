/****************************************************************************
** Meta object code from reading C++ file 'xchat.hpp'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/xchat/xchat.hpp"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'xchat.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_Xchat_t {
    QByteArrayData data[1];
    char stringdata0[6];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Xchat_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Xchat_t qt_meta_stringdata_Xchat = {
    {
QT_MOC_LITERAL(0, 0, 5) // "Xchat"

    },
    "Xchat"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Xchat[] = {

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

void Xchat::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    Q_UNUSED(_o);
    Q_UNUSED(_id);
    Q_UNUSED(_c);
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject Xchat::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Xchat.data,
      qt_meta_data_Xchat,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *Xchat::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Xchat::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_Xchat.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Xchat::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    return _id;
}
struct qt_meta_stringdata_XchatObject_t {
    QByteArrayData data[10];
    char stringdata0[132];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_XchatObject_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_XchatObject_t qt_meta_stringdata_XchatObject = {
    {
QT_MOC_LITERAL(0, 0, 11), // "XchatObject"
QT_MOC_LITERAL(1, 12, 19), // "xchatResponseSignal"
QT_MOC_LITERAL(2, 32, 0), // ""
QT_MOC_LITERAL(3, 33, 4), // "text"
QT_MOC_LITERAL(4, 38, 13), // "SubmitMsgCall"
QT_MOC_LITERAL(5, 52, 3), // "msg"
QT_MOC_LITERAL(6, 56, 9), // "SubmitMsg"
QT_MOC_LITERAL(7, 66, 24), // "CheckUserInputForKeyWord"
QT_MOC_LITERAL(8, 91, 22), // "CheckAIInputForKeyWord"
QT_MOC_LITERAL(9, 114, 17) // "HarmonizeKeyWords"

    },
    "XchatObject\0xchatResponseSignal\0\0text\0"
    "SubmitMsgCall\0msg\0SubmitMsg\0"
    "CheckUserInputForKeyWord\0"
    "CheckAIInputForKeyWord\0HarmonizeKeyWords"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_XchatObject[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   44,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       4,    1,   47,    2, 0x0a /* Public */,
       6,    1,   50,    2, 0x0a /* Public */,
       7,    1,   53,    2, 0x0a /* Public */,
       8,    1,   56,    2, 0x0a /* Public */,
       9,    1,   59,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QVariant,    3,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,    5,
    QMetaType::Void, QMetaType::QString,    5,
    QMetaType::Bool, QMetaType::QString,    5,
    QMetaType::Bool, QMetaType::QString,    5,
    QMetaType::QString, QMetaType::QString,    5,

       0        // eod
};

void XchatObject::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        XchatObject *_t = static_cast<XchatObject *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->xchatResponseSignal((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 1: _t->SubmitMsgCall((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 2: _t->SubmitMsg((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 3: { bool _r = _t->CheckUserInputForKeyWord((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->CheckAIInputForKeyWord((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 5: { QString _r = _t->HarmonizeKeyWords((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (XchatObject::*)(QVariant );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&XchatObject::xchatResponseSignal)) {
                *result = 0;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject XchatObject::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_XchatObject.data,
      qt_meta_data_XchatObject,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *XchatObject::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *XchatObject::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_XchatObject.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int XchatObject::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
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
    return _id;
}

// SIGNAL 0
void XchatObject::xchatResponseSignal(QVariant _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
