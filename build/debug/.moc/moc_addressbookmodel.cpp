/****************************************************************************
** Meta object code from reading C++ file 'addressbookmodel.hpp'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/addressbook/addressbookmodel.hpp"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'addressbookmodel.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_Address_t {
    QByteArrayData data[3];
    char stringdata0[21];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Address_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Address_t qt_meta_stringdata_Address = {
    {
QT_MOC_LITERAL(0, 0, 7), // "Address"
QT_MOC_LITERAL(1, 8, 4), // "name"
QT_MOC_LITERAL(2, 13, 7) // "address"

    },
    "Address\0name\0address"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Address[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       2,   14, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // properties: name, type, flags
       1, QMetaType::QString, 0x00095003,
       2, QMetaType::QString, 0x00095003,

       0        // eod
};

void Address::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{

#ifndef QT_NO_PROPERTIES
    if (_c == QMetaObject::ReadProperty) {
        Address *_t = static_cast<Address *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->m_name; break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->m_address; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        Address *_t = static_cast<Address *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0:
            if (_t->m_name != *reinterpret_cast< QString*>(_v)) {
                _t->m_name = *reinterpret_cast< QString*>(_v);
            }
            break;
        case 1:
            if (_t->m_address != *reinterpret_cast< QString*>(_v)) {
                _t->m_address = *reinterpret_cast< QString*>(_v);
            }
            break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
    Q_UNUSED(_o);
    Q_UNUSED(_id);
    Q_UNUSED(_c);
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject Address::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Address.data,
      qt_meta_data_Address,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *Address::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Address::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_Address.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Address::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    
#ifndef QT_NO_PROPERTIES
   if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 2;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}
struct qt_meta_stringdata_AddressBookModel_t {
    QByteArrayData data[11];
    char stringdata0[79];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_AddressBookModel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_AddressBookModel_t qt_meta_stringdata_AddressBookModel = {
    {
QT_MOC_LITERAL(0, 0, 16), // "AddressBookModel"
QT_MOC_LITERAL(1, 17, 15), // "setCurrentIndex"
QT_MOC_LITERAL(2, 33, 0), // ""
QT_MOC_LITERAL(3, 34, 3), // "idx"
QT_MOC_LITERAL(4, 38, 3), // "get"
QT_MOC_LITERAL(5, 42, 6), // "append"
QT_MOC_LITERAL(6, 49, 6), // "update"
QT_MOC_LITERAL(7, 56, 6), // "remove"
QT_MOC_LITERAL(8, 63, 5), // "clear"
QT_MOC_LITERAL(9, 69, 4), // "save"
QT_MOC_LITERAL(10, 74, 4) // "load"

    },
    "AddressBookModel\0setCurrentIndex\0\0idx\0"
    "get\0append\0update\0remove\0clear\0save\0"
    "load"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_AddressBookModel[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   54,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       4,    1,   57,    2, 0x02 /* Public */,
       5,    2,   60,    2, 0x02 /* Public */,
       6,    3,   65,    2, 0x02 /* Public */,
       7,    1,   72,    2, 0x02 /* Public */,
       8,    0,   75,    2, 0x02 /* Public */,
       9,    0,   76,    2, 0x02 /* Public */,
      10,    0,   77,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::Int,    3,

 // methods: parameters
    QMetaType::QVariantMap, QMetaType::Int,    3,
    QMetaType::Int, QMetaType::QString, QMetaType::QString,    2,    2,
    QMetaType::Void, QMetaType::Int, QMetaType::QString, QMetaType::QString,    2,    2,    2,
    QMetaType::Int, QMetaType::Int,    2,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,

       0        // eod
};

void AddressBookModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        AddressBookModel *_t = static_cast<AddressBookModel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->setCurrentIndex((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: { QVariantMap _r = _t->get((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantMap*>(_a[0]) = std::move(_r); }  break;
        case 2: { int _r = _t->append((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 3: _t->update((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 4: { int _r = _t->remove((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 5: _t->clear(); break;
        case 6: { bool _r = _t->save();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 7: { bool _r = _t->load();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (AddressBookModel::*)(int );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AddressBookModel::setCurrentIndex)) {
                *result = 0;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject AddressBookModel::staticMetaObject = {
    { &QAbstractListModel::staticMetaObject, qt_meta_stringdata_AddressBookModel.data,
      qt_meta_data_AddressBookModel,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *AddressBookModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *AddressBookModel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_AddressBookModel.stringdata0))
        return static_cast<void*>(this);
    return QAbstractListModel::qt_metacast(_clname);
}

int AddressBookModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 8;
    }
    return _id;
}

// SIGNAL 0
void AddressBookModel::setCurrentIndex(int _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
