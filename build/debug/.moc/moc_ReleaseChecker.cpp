/****************************************************************************
** Meta object code from reading C++ file 'ReleaseChecker.hpp'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/support/ReleaseChecker.hpp"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ReleaseChecker.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_ReleaseChecker_t {
    QByteArrayData data[7];
    char stringdata0[79];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_ReleaseChecker_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_ReleaseChecker_t qt_meta_stringdata_ReleaseChecker = {
    {
QT_MOC_LITERAL(0, 0, 14), // "ReleaseChecker"
QT_MOC_LITERAL(1, 15, 20), // "xciteUpdateAvailable"
QT_MOC_LITERAL(2, 36, 0), // ""
QT_MOC_LITERAL(3, 37, 14), // "checkForUpdate"
QT_MOC_LITERAL(4, 52, 10), // "dataLoaded"
QT_MOC_LITERAL(5, 63, 11), // "errorString"
QT_MOC_LITERAL(6, 75, 3) // "err"

    },
    "ReleaseChecker\0xciteUpdateAvailable\0"
    "\0checkForUpdate\0dataLoaded\0errorString\0"
    "err"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_ReleaseChecker[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   34,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       3,    0,   35,    2, 0x0a /* Public */,
       4,    0,   36,    2, 0x0a /* Public */,
       5,    1,   37,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    6,

       0        // eod
};

void ReleaseChecker::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        ReleaseChecker *_t = static_cast<ReleaseChecker *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->xciteUpdateAvailable(); break;
        case 1: _t->checkForUpdate(); break;
        case 2: _t->dataLoaded(); break;
        case 3: _t->errorString((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ReleaseChecker::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ReleaseChecker::xciteUpdateAvailable)) {
                *result = 0;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject ReleaseChecker::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ReleaseChecker.data,
      qt_meta_data_ReleaseChecker,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *ReleaseChecker::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ReleaseChecker::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ReleaseChecker.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int ReleaseChecker::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void ReleaseChecker::xciteUpdateAvailable()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
