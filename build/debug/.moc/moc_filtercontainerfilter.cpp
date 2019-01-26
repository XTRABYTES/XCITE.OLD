/****************************************************************************
** Meta object code from reading C++ file 'filtercontainerfilter.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../frontend/support/SortFilterProxyModel/filters/filtercontainerfilter.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'filtercontainerfilter.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_qqsfpm__FilterContainerFilter_t {
    QByteArrayData data[6];
    char stringdata0[103];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_qqsfpm__FilterContainerFilter_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_qqsfpm__FilterContainerFilter_t qt_meta_stringdata_qqsfpm__FilterContainerFilter = {
    {
QT_MOC_LITERAL(0, 0, 29), // "qqsfpm::FilterContainerFilter"
QT_MOC_LITERAL(1, 30, 15), // "DefaultProperty"
QT_MOC_LITERAL(2, 46, 7), // "filters"
QT_MOC_LITERAL(3, 54, 14), // "filtersChanged"
QT_MOC_LITERAL(4, 69, 0), // ""
QT_MOC_LITERAL(5, 70, 32) // "QQmlListProperty<qqsfpm::Filter>"

    },
    "qqsfpm::FilterContainerFilter\0"
    "DefaultProperty\0filters\0filtersChanged\0"
    "\0QQmlListProperty<qqsfpm::Filter>"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_qqsfpm__FilterContainerFilter[] = {

 // content:
       7,       // revision
       0,       // classname
       1,   14, // classinfo
       1,   16, // methods
       1,   22, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // classinfo: key, value
       1,    2,

 // signals: name, argc, parameters, tag, flags
       3,    0,   21,    4, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,

 // properties: name, type, flags
       2, 0x80000000 | 5, 0x00495009,

 // properties: notify_signal_id
       0,

       0        // eod
};

void qqsfpm::FilterContainerFilter::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        FilterContainerFilter *_t = static_cast<FilterContainerFilter *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->filtersChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (FilterContainerFilter::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&FilterContainerFilter::filtersChanged)) {
                *result = 0;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        FilterContainerFilter *_t = static_cast<FilterContainerFilter *>(_o);
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
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject qqsfpm::FilterContainerFilter::staticMetaObject = {
    { &Filter::staticMetaObject, qt_meta_stringdata_qqsfpm__FilterContainerFilter.data,
      qt_meta_data_qqsfpm__FilterContainerFilter,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *qqsfpm::FilterContainerFilter::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *qqsfpm::FilterContainerFilter::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_qqsfpm__FilterContainerFilter.stringdata0))
        return static_cast<void*>(this);
    if (!strcmp(_clname, "FilterContainer"))
        return static_cast< FilterContainer*>(this);
    if (!strcmp(_clname, "fr.grecko.SortFilterProxyModel.FilterContainer"))
        return static_cast< qqsfpm::FilterContainer*>(this);
    return Filter::qt_metacast(_clname);
}

int qqsfpm::FilterContainerFilter::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = Filter::qt_metacall(_c, _id, _a);
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
void qqsfpm::FilterContainerFilter::filtersChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
