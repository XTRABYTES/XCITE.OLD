/****************************************************************************
** Meta object code from reading C++ file 'globaleventfilter.hpp'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/support/globaleventfilter.hpp"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'globaleventfilter.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_GlobalEventFilter_t {
    QByteArrayData data[3];
    char stringdata0[25];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_GlobalEventFilter_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_GlobalEventFilter_t qt_meta_stringdata_GlobalEventFilter = {
    {
QT_MOC_LITERAL(0, 0, 17), // "GlobalEventFilter"
QT_MOC_LITERAL(1, 18, 5), // "focus"
QT_MOC_LITERAL(2, 24, 0) // ""

    },
    "GlobalEventFilter\0focus\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_GlobalEventFilter[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    1,   19,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::Void, QMetaType::QObjectStar,    2,

       0        // eod
};

void GlobalEventFilter::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        GlobalEventFilter *_t = static_cast<GlobalEventFilter *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->focus((*reinterpret_cast< QObject*(*)>(_a[1]))); break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject GlobalEventFilter::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_GlobalEventFilter.data,
      qt_meta_data_GlobalEventFilter,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *GlobalEventFilter::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *GlobalEventFilter::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_GlobalEventFilter.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int GlobalEventFilter::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 1)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 1;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
