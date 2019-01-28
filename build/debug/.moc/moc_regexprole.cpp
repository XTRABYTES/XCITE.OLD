/****************************************************************************
** Meta object code from reading C++ file 'regexprole.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../frontend/support/SortFilterProxyModel/proxyroles/regexprole.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'regexprole.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_qqsfpm__RegExpRole_t {
    QByteArrayData data[9];
    char stringdata0[127];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_qqsfpm__RegExpRole_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_qqsfpm__RegExpRole_t qt_meta_stringdata_qqsfpm__RegExpRole = {
    {
QT_MOC_LITERAL(0, 0, 18), // "qqsfpm::RegExpRole"
QT_MOC_LITERAL(1, 19, 15), // "roleNameChanged"
QT_MOC_LITERAL(2, 35, 0), // ""
QT_MOC_LITERAL(3, 36, 14), // "patternChanged"
QT_MOC_LITERAL(4, 51, 22), // "caseSensitivityChanged"
QT_MOC_LITERAL(5, 74, 8), // "roleName"
QT_MOC_LITERAL(6, 83, 7), // "pattern"
QT_MOC_LITERAL(7, 91, 15), // "caseSensitivity"
QT_MOC_LITERAL(8, 107, 19) // "Qt::CaseSensitivity"

    },
    "qqsfpm::RegExpRole\0roleNameChanged\0\0"
    "patternChanged\0caseSensitivityChanged\0"
    "roleName\0pattern\0caseSensitivity\0"
    "Qt::CaseSensitivity"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_qqsfpm__RegExpRole[] = {

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
       5, QMetaType::QString, 0x00495103,
       6, QMetaType::QString, 0x00495103,
       7, 0x80000000 | 8, 0x0049510b,

 // properties: notify_signal_id
       0,
       1,
       2,

       0        // eod
};

void qqsfpm::RegExpRole::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        RegExpRole *_t = static_cast<RegExpRole *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->roleNameChanged(); break;
        case 1: _t->patternChanged(); break;
        case 2: _t->caseSensitivityChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (RegExpRole::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&RegExpRole::roleNameChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (RegExpRole::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&RegExpRole::patternChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (RegExpRole::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&RegExpRole::caseSensitivityChanged)) {
                *result = 2;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        RegExpRole *_t = static_cast<RegExpRole *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->roleName(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->pattern(); break;
        case 2: *reinterpret_cast< Qt::CaseSensitivity*>(_v) = _t->caseSensitivity(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        RegExpRole *_t = static_cast<RegExpRole *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setRoleName(*reinterpret_cast< QString*>(_v)); break;
        case 1: _t->setPattern(*reinterpret_cast< QString*>(_v)); break;
        case 2: _t->setCaseSensitivity(*reinterpret_cast< Qt::CaseSensitivity*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject qqsfpm::RegExpRole::staticMetaObject = {
    { &ProxyRole::staticMetaObject, qt_meta_stringdata_qqsfpm__RegExpRole.data,
      qt_meta_data_qqsfpm__RegExpRole,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *qqsfpm::RegExpRole::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *qqsfpm::RegExpRole::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_qqsfpm__RegExpRole.stringdata0))
        return static_cast<void*>(this);
    return ProxyRole::qt_metacast(_clname);
}

int qqsfpm::RegExpRole::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = ProxyRole::qt_metacall(_c, _id, _a);
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
void qqsfpm::RegExpRole::roleNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void qqsfpm::RegExpRole::patternChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void qqsfpm::RegExpRole::caseSensitivityChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
