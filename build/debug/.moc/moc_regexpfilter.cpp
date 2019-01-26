/****************************************************************************
** Meta object code from reading C++ file 'regexpfilter.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../frontend/support/SortFilterProxyModel/filters/regexpfilter.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'regexpfilter.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_qqsfpm__RegExpFilter_t {
    QByteArrayData data[16];
    char stringdata0[203];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_qqsfpm__RegExpFilter_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_qqsfpm__RegExpFilter_t qt_meta_stringdata_qqsfpm__RegExpFilter = {
    {
QT_MOC_LITERAL(0, 0, 20), // "qqsfpm::RegExpFilter"
QT_MOC_LITERAL(1, 21, 14), // "patternChanged"
QT_MOC_LITERAL(2, 36, 0), // ""
QT_MOC_LITERAL(3, 37, 13), // "syntaxChanged"
QT_MOC_LITERAL(4, 51, 22), // "caseSensitivityChanged"
QT_MOC_LITERAL(5, 74, 7), // "pattern"
QT_MOC_LITERAL(6, 82, 6), // "syntax"
QT_MOC_LITERAL(7, 89, 13), // "PatternSyntax"
QT_MOC_LITERAL(8, 103, 15), // "caseSensitivity"
QT_MOC_LITERAL(9, 119, 19), // "Qt::CaseSensitivity"
QT_MOC_LITERAL(10, 139, 6), // "RegExp"
QT_MOC_LITERAL(11, 146, 8), // "Wildcard"
QT_MOC_LITERAL(12, 155, 11), // "FixedString"
QT_MOC_LITERAL(13, 167, 7), // "RegExp2"
QT_MOC_LITERAL(14, 175, 12), // "WildcardUnix"
QT_MOC_LITERAL(15, 188, 14) // "W3CXmlSchema11"

    },
    "qqsfpm::RegExpFilter\0patternChanged\0"
    "\0syntaxChanged\0caseSensitivityChanged\0"
    "pattern\0syntax\0PatternSyntax\0"
    "caseSensitivity\0Qt::CaseSensitivity\0"
    "RegExp\0Wildcard\0FixedString\0RegExp2\0"
    "WildcardUnix\0W3CXmlSchema11"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_qqsfpm__RegExpFilter[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       3,   32, // properties
       1,   44, // enums/sets
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
       6, 0x80000000 | 7, 0x0049510b,
       8, 0x80000000 | 9, 0x0049510b,

 // properties: notify_signal_id
       0,
       1,
       2,

 // enums: name, flags, count, data
       7, 0x0,    6,   48,

 // enum data: key, value
      10, uint(qqsfpm::RegExpFilter::RegExp),
      11, uint(qqsfpm::RegExpFilter::Wildcard),
      12, uint(qqsfpm::RegExpFilter::FixedString),
      13, uint(qqsfpm::RegExpFilter::RegExp2),
      14, uint(qqsfpm::RegExpFilter::WildcardUnix),
      15, uint(qqsfpm::RegExpFilter::W3CXmlSchema11),

       0        // eod
};

void qqsfpm::RegExpFilter::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        RegExpFilter *_t = static_cast<RegExpFilter *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->patternChanged(); break;
        case 1: _t->syntaxChanged(); break;
        case 2: _t->caseSensitivityChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (RegExpFilter::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&RegExpFilter::patternChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (RegExpFilter::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&RegExpFilter::syntaxChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (RegExpFilter::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&RegExpFilter::caseSensitivityChanged)) {
                *result = 2;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        RegExpFilter *_t = static_cast<RegExpFilter *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->pattern(); break;
        case 1: *reinterpret_cast< PatternSyntax*>(_v) = _t->syntax(); break;
        case 2: *reinterpret_cast< Qt::CaseSensitivity*>(_v) = _t->caseSensitivity(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        RegExpFilter *_t = static_cast<RegExpFilter *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setPattern(*reinterpret_cast< QString*>(_v)); break;
        case 1: _t->setSyntax(*reinterpret_cast< PatternSyntax*>(_v)); break;
        case 2: _t->setCaseSensitivity(*reinterpret_cast< Qt::CaseSensitivity*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject qqsfpm::RegExpFilter::staticMetaObject = {
    { &RoleFilter::staticMetaObject, qt_meta_stringdata_qqsfpm__RegExpFilter.data,
      qt_meta_data_qqsfpm__RegExpFilter,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *qqsfpm::RegExpFilter::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *qqsfpm::RegExpFilter::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_qqsfpm__RegExpFilter.stringdata0))
        return static_cast<void*>(this);
    return RoleFilter::qt_metacast(_clname);
}

int qqsfpm::RegExpFilter::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = RoleFilter::qt_metacall(_c, _id, _a);
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
void qqsfpm::RegExpFilter::patternChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void qqsfpm::RegExpFilter::syntaxChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void qqsfpm::RegExpFilter::caseSensitivityChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
