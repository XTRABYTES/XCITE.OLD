/****************************************************************************
** Meta object code from reading C++ file 'filtersorter.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../frontend/support/SortFilterProxyModel/sorters/filtersorter.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'filtersorter.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_qqsfpm__FilterSorter_t {
    QByteArrayData data[4];
    char stringdata0[78];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_qqsfpm__FilterSorter_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_qqsfpm__FilterSorter_t qt_meta_stringdata_qqsfpm__FilterSorter = {
    {
QT_MOC_LITERAL(0, 0, 20), // "qqsfpm::FilterSorter"
QT_MOC_LITERAL(1, 21, 15), // "DefaultProperty"
QT_MOC_LITERAL(2, 37, 7), // "filters"
QT_MOC_LITERAL(3, 45, 32) // "QQmlListProperty<qqsfpm::Filter>"

    },
    "qqsfpm::FilterSorter\0DefaultProperty\0"
    "filters\0QQmlListProperty<qqsfpm::Filter>"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_qqsfpm__FilterSorter[] = {

 // content:
       7,       // revision
       0,       // classname
       1,   14, // classinfo
       0,    0, // methods
       1,   16, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // classinfo: key, value
       1,    2,

 // properties: name, type, flags
       2, 0x80000000 | 3, 0x00095009,

       0        // eod
};

void qqsfpm::FilterSorter::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{

#ifndef QT_NO_PROPERTIES
    if (_c == QMetaObject::ReadProperty) {
        FilterSorter *_t = static_cast<FilterSorter *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QQmlListProperty<qqsfpm::Filter>*>(_v) = _t->filtersListProperty(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
    Q_UNUSED(_o);
    Q_UNUSED(_id);
    Q_UNUSED(_c);
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject qqsfpm::FilterSorter::staticMetaObject = {
    { &Sorter::staticMetaObject, qt_meta_stringdata_qqsfpm__FilterSorter.data,
      qt_meta_data_qqsfpm__FilterSorter,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *qqsfpm::FilterSorter::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *qqsfpm::FilterSorter::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_qqsfpm__FilterSorter.stringdata0))
        return static_cast<void*>(this);
    if (!strcmp(_clname, "FilterContainer"))
        return static_cast< FilterContainer*>(this);
    if (!strcmp(_clname, "fr.grecko.SortFilterProxyModel.FilterContainer"))
        return static_cast< qqsfpm::FilterContainer*>(this);
    return Sorter::qt_metacast(_clname);
}

int qqsfpm::FilterSorter::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = Sorter::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    
#ifndef QT_NO_PROPERTIES
   if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
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
QT_WARNING_POP
QT_END_MOC_NAMESPACE
