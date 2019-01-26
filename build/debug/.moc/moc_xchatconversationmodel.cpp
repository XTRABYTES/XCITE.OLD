/****************************************************************************
** Meta object code from reading C++ file 'xchatconversationmodel.hpp'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../backend/xchat/xchatconversationmodel.hpp"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'xchatconversationmodel.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_XChatConversationMessage_t {
    QByteArrayData data[4];
    char stringdata0[49];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_XChatConversationMessage_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_XChatConversationMessage_t qt_meta_stringdata_XChatConversationMessage = {
    {
QT_MOC_LITERAL(0, 0, 24), // "XChatConversationMessage"
QT_MOC_LITERAL(1, 25, 7), // "message"
QT_MOC_LITERAL(2, 33, 6), // "isMine"
QT_MOC_LITERAL(3, 40, 8) // "datetime"

    },
    "XChatConversationMessage\0message\0"
    "isMine\0datetime"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_XChatConversationMessage[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       3,   14, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // properties: name, type, flags
       1, QMetaType::QString, 0x00095003,
       2, QMetaType::Bool, 0x00095003,
       3, QMetaType::QDateTime, 0x00095003,

       0        // eod
};

void XChatConversationMessage::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{

#ifndef QT_NO_PROPERTIES
    if (_c == QMetaObject::ReadProperty) {
        XChatConversationMessage *_t = static_cast<XChatConversationMessage *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->m_message; break;
        case 1: *reinterpret_cast< bool*>(_v) = _t->m_isMine; break;
        case 2: *reinterpret_cast< QDateTime*>(_v) = _t->m_datetime; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        XChatConversationMessage *_t = static_cast<XChatConversationMessage *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0:
            if (_t->m_message != *reinterpret_cast< QString*>(_v)) {
                _t->m_message = *reinterpret_cast< QString*>(_v);
            }
            break;
        case 1:
            if (_t->m_isMine != *reinterpret_cast< bool*>(_v)) {
                _t->m_isMine = *reinterpret_cast< bool*>(_v);
            }
            break;
        case 2:
            if (_t->m_datetime != *reinterpret_cast< QDateTime*>(_v)) {
                _t->m_datetime = *reinterpret_cast< QDateTime*>(_v);
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

QT_INIT_METAOBJECT const QMetaObject XChatConversationMessage::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_XChatConversationMessage.data,
      qt_meta_data_XChatConversationMessage,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *XChatConversationMessage::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *XChatConversationMessage::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_XChatConversationMessage.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int XChatConversationMessage::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    
#ifndef QT_NO_PROPERTIES
   if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
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
struct qt_meta_stringdata_XChatConversationModel_t {
    QByteArrayData data[3];
    char stringdata0[35];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_XChatConversationModel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_XChatConversationModel_t qt_meta_stringdata_XChatConversationModel = {
    {
QT_MOC_LITERAL(0, 0, 22), // "XChatConversationModel"
QT_MOC_LITERAL(1, 23, 10), // "addMessage"
QT_MOC_LITERAL(2, 34, 0) // ""

    },
    "XChatConversationModel\0addMessage\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_XChatConversationModel[] = {

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
       1,    3,   19,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::QDateTime, QMetaType::Bool,    2,    2,    2,

       0        // eod
};

void XChatConversationModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        XChatConversationModel *_t = static_cast<XChatConversationModel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->addMessage((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QDateTime(*)>(_a[2])),(*reinterpret_cast< bool(*)>(_a[3]))); break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject XChatConversationModel::staticMetaObject = {
    { &QAbstractListModel::staticMetaObject, qt_meta_stringdata_XChatConversationModel.data,
      qt_meta_data_XChatConversationModel,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *XChatConversationModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *XChatConversationModel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_XChatConversationModel.stringdata0))
        return static_cast<void*>(this);
    return QAbstractListModel::qt_metacast(_clname);
}

int XChatConversationModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
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
