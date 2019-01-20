/****************************************************************************
** Meta object code from reading C++ file 'sorter.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../frontend/support/SortFilterProxyModel/sorters/sorter.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'sorter.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_qqsfpm__Sorter_t {
    QByteArrayData data[9];
    char stringdata0[107];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_qqsfpm__Sorter_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_qqsfpm__Sorter_t qt_meta_stringdata_qqsfpm__Sorter = {
    {
QT_MOC_LITERAL(0, 0, 14), // "qqsfpm::Sorter"
QT_MOC_LITERAL(1, 15, 14), // "enabledChanged"
QT_MOC_LITERAL(2, 30, 0), // ""
QT_MOC_LITERAL(3, 31, 16), // "sortOrderChanged"
QT_MOC_LITERAL(4, 48, 11), // "invalidated"
QT_MOC_LITERAL(5, 60, 7), // "enabled"
QT_MOC_LITERAL(6, 68, 14), // "ascendingOrder"
QT_MOC_LITERAL(7, 83, 9), // "sortOrder"
QT_MOC_LITERAL(8, 93, 13) // "Qt::SortOrder"

    },
    "qqsfpm::Sorter\0enabledChanged\0\0"
    "sortOrderChanged\0invalidated\0enabled\0"
    "ascendingOrder\0sortOrder\0Qt::SortOrder"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_qqsfpm__Sorter[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       3,   32, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   29,    2, 0x06 /* Public */,
       3,    0,   30,    2, 0x06 /* Public */,
       4,    0,   31,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
       5, QMetaType::Bool, 0x00495103,
       6, QMetaType::Bool, 0x00495103,
       7, 0x80000000 | 8, 0x0049510b,

 // properties: notify_signal_id
       0,
       1,
       1,

       0        // eod
};

void qqsfpm::Sorter::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Sorter *_t = static_cast<Sorter *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->enabledChanged(); break;
        case 1: _t->sortOrderChanged(); break;
        case 2: _t->invalidated(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Sorter::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Sorter::enabledChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Sorter::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Sorter::sortOrderChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Sorter::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Sorter::invalidated)) {
                *result = 2;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        Sorter *_t = static_cast<Sorter *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = _t->enabled(); break;
        case 1: *reinterpret_cast< bool*>(_v) = _t->ascendingOrder(); break;
        case 2: *reinterpret_cast< Qt::SortOrder*>(_v) = _t->sortOrder(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        Sorter *_t = static_cast<Sorter *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setEnabled(*reinterpret_cast< bool*>(_v)); break;
        case 1: _t->setAscendingOrder(*reinterpret_cast< bool*>(_v)); break;
        case 2: _t->setSortOrder(*reinterpret_cast< Qt::SortOrder*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject qqsfpm::Sorter::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_qqsfpm__Sorter.data,
      qt_meta_data_qqsfpm__Sorter,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *qqsfpm::Sorter::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *qqsfpm::Sorter::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_qqsfpm__Sorter.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int qqsfpm::Sorter::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 3;
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
void qqsfpm::Sorter::enabledChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void qqsfpm::Sorter::sortOrderChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void qqsfpm::Sorter::invalidated()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
