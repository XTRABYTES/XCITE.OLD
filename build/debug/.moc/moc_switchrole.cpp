/****************************************************************************
** Meta object code from reading C++ file 'switchrole.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../frontend/support/SortFilterProxyModel/proxyroles/switchrole.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'switchrole.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_qqsfpm__SwitchRoleAttached_t {
    QByteArrayData data[4];
    char stringdata0[47];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_qqsfpm__SwitchRoleAttached_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_qqsfpm__SwitchRoleAttached_t qt_meta_stringdata_qqsfpm__SwitchRoleAttached = {
    {
QT_MOC_LITERAL(0, 0, 26), // "qqsfpm::SwitchRoleAttached"
QT_MOC_LITERAL(1, 27, 12), // "valueChanged"
QT_MOC_LITERAL(2, 40, 0), // ""
QT_MOC_LITERAL(3, 41, 5) // "value"

    },
    "qqsfpm::SwitchRoleAttached\0valueChanged\0"
    "\0value"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_qqsfpm__SwitchRoleAttached[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       1,   20, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   19,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,

 // properties: name, type, flags
       3, QMetaType::QVariant, 0x00495103,

 // properties: notify_signal_id
       0,

       0        // eod
};

void qqsfpm::SwitchRoleAttached::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        SwitchRoleAttached *_t = static_cast<SwitchRoleAttached *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->valueChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (SwitchRoleAttached::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&SwitchRoleAttached::valueChanged)) {
                *result = 0;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        SwitchRoleAttached *_t = static_cast<SwitchRoleAttached *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QVariant*>(_v) = _t->value(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        SwitchRoleAttached *_t = static_cast<SwitchRoleAttached *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setValue(*reinterpret_cast< QVariant*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject qqsfpm::SwitchRoleAttached::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_qqsfpm__SwitchRoleAttached.data,
      qt_meta_data_qqsfpm__SwitchRoleAttached,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *qqsfpm::SwitchRoleAttached::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *qqsfpm::SwitchRoleAttached::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_qqsfpm__SwitchRoleAttached.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int qqsfpm::SwitchRoleAttached::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 1;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void qqsfpm::SwitchRoleAttached::valueChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}
struct qt_meta_stringdata_qqsfpm__SwitchRole_t {
    QByteArrayData data[9];
    char stringdata0[149];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_qqsfpm__SwitchRole_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_qqsfpm__SwitchRole_t qt_meta_stringdata_qqsfpm__SwitchRole = {
    {
QT_MOC_LITERAL(0, 0, 18), // "qqsfpm::SwitchRole"
QT_MOC_LITERAL(1, 19, 15), // "DefaultProperty"
QT_MOC_LITERAL(2, 35, 7), // "filters"
QT_MOC_LITERAL(3, 43, 22), // "defaultRoleNameChanged"
QT_MOC_LITERAL(4, 66, 0), // ""
QT_MOC_LITERAL(5, 67, 19), // "defaultValueChanged"
QT_MOC_LITERAL(6, 87, 15), // "defaultRoleName"
QT_MOC_LITERAL(7, 103, 12), // "defaultValue"
QT_MOC_LITERAL(8, 116, 32) // "QQmlListProperty<qqsfpm::Filter>"

    },
    "qqsfpm::SwitchRole\0DefaultProperty\0"
    "filters\0defaultRoleNameChanged\0\0"
    "defaultValueChanged\0defaultRoleName\0"
    "defaultValue\0QQmlListProperty<qqsfpm::Filter>"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_qqsfpm__SwitchRole[] = {

 // content:
       7,       // revision
       0,       // classname
       1,   14, // classinfo
       2,   16, // methods
       3,   28, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // classinfo: key, value
       1,    2,

 // signals: name, argc, parameters, tag, flags
       3,    0,   26,    4, 0x06 /* Public */,
       5,    0,   27,    4, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
       6, QMetaType::QString, 0x00495103,
       7, QMetaType::QVariant, 0x00495103,
       2, 0x80000000 | 8, 0x00095009,

 // properties: notify_signal_id
       0,
       1,
       0,

       0        // eod
};

void qqsfpm::SwitchRole::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        SwitchRole *_t = static_cast<SwitchRole *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->defaultRoleNameChanged(); break;
        case 1: _t->defaultValueChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (SwitchRole::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&SwitchRole::defaultRoleNameChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (SwitchRole::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&SwitchRole::defaultValueChanged)) {
                *result = 1;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        SwitchRole *_t = static_cast<SwitchRole *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->defaultRoleName(); break;
        case 1: *reinterpret_cast< QVariant*>(_v) = _t->defaultValue(); break;
        case 2: *reinterpret_cast< QQmlListProperty<qqsfpm::Filter>*>(_v) = _t->filtersListProperty(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        SwitchRole *_t = static_cast<SwitchRole *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setDefaultRoleName(*reinterpret_cast< QString*>(_v)); break;
        case 1: _t->setDefaultValue(*reinterpret_cast< QVariant*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject qqsfpm::SwitchRole::staticMetaObject = {
    { &SingleRole::staticMetaObject, qt_meta_stringdata_qqsfpm__SwitchRole.data,
      qt_meta_data_qqsfpm__SwitchRole,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *qqsfpm::SwitchRole::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *qqsfpm::SwitchRole::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_qqsfpm__SwitchRole.stringdata0))
        return static_cast<void*>(this);
    if (!strcmp(_clname, "FilterContainer"))
        return static_cast< FilterContainer*>(this);
    if (!strcmp(_clname, "fr.grecko.SortFilterProxyModel.FilterContainer"))
        return static_cast< qqsfpm::FilterContainer*>(this);
    return SingleRole::qt_metacast(_clname);
}

int qqsfpm::SwitchRole::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = SingleRole::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 2)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 2;
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
void qqsfpm::SwitchRole::defaultRoleNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void qqsfpm::SwitchRole::defaultValueChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
