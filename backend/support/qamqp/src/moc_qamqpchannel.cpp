/****************************************************************************
** Meta object code from reading C++ file 'qamqpchannel.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "qamqpchannel.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qamqpchannel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_QAmqpChannel_t {
    QByteArrayData data[17];
    char stringdata0[134];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QAmqpChannel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QAmqpChannel_t qt_meta_stringdata_QAmqpChannel = {
    {
QT_MOC_LITERAL(0, 0, 12), // "QAmqpChannel"
QT_MOC_LITERAL(1, 13, 6), // "opened"
QT_MOC_LITERAL(2, 20, 0), // ""
QT_MOC_LITERAL(3, 21, 6), // "closed"
QT_MOC_LITERAL(4, 28, 7), // "resumed"
QT_MOC_LITERAL(5, 36, 6), // "paused"
QT_MOC_LITERAL(6, 43, 5), // "error"
QT_MOC_LITERAL(7, 49, 12), // "QAMQP::Error"
QT_MOC_LITERAL(8, 62, 10), // "qosDefined"
QT_MOC_LITERAL(9, 73, 5), // "close"
QT_MOC_LITERAL(10, 79, 6), // "reopen"
QT_MOC_LITERAL(11, 86, 6), // "resume"
QT_MOC_LITERAL(12, 93, 7), // "_q_open"
QT_MOC_LITERAL(13, 101, 15), // "_q_disconnected"
QT_MOC_LITERAL(14, 117, 6), // "number"
QT_MOC_LITERAL(15, 124, 4), // "open"
QT_MOC_LITERAL(16, 129, 4) // "name"

    },
    "QAmqpChannel\0opened\0\0closed\0resumed\0"
    "paused\0error\0QAMQP::Error\0qosDefined\0"
    "close\0reopen\0resume\0_q_open\0_q_disconnected\0"
    "number\0open\0name"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QAmqpChannel[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       3,   82, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       6,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   69,    2, 0x06 /* Public */,
       3,    0,   70,    2, 0x06 /* Public */,
       4,    0,   71,    2, 0x06 /* Public */,
       5,    0,   72,    2, 0x06 /* Public */,
       6,    1,   73,    2, 0x06 /* Public */,
       8,    0,   76,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       9,    0,   77,    2, 0x0a /* Public */,
      10,    0,   78,    2, 0x0a /* Public */,
      11,    0,   79,    2, 0x0a /* Public */,
      12,    0,   80,    2, 0x09 /* Protected */,
      13,    0,   81,    2, 0x09 /* Protected */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 7,    6,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
      14, QMetaType::Int, 0x00095401,
      15, QMetaType::Bool, 0x00095401,
      16, QMetaType::QString, 0x00095103,

       0        // eod
};

void QAmqpChannel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QAmqpChannel *_t = static_cast<QAmqpChannel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->opened(); break;
        case 1: _t->closed(); break;
        case 2: _t->resumed(); break;
        case 3: _t->paused(); break;
        case 4: _t->error((*reinterpret_cast< QAMQP::Error(*)>(_a[1]))); break;
        case 5: _t->qosDefined(); break;
        case 6: _t->close(); break;
        case 7: _t->reopen(); break;
        case 8: _t->resume(); break;
        case 9: _t->d_func()->_q_open(); break;
        case 10: _t->d_func()->_q_disconnected(); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 4:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QAMQP::Error >(); break;
            }
            break;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (QAmqpChannel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpChannel::opened)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (QAmqpChannel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpChannel::closed)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (QAmqpChannel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpChannel::resumed)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (QAmqpChannel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpChannel::paused)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (QAmqpChannel::*)(QAMQP::Error );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpChannel::error)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (QAmqpChannel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpChannel::qosDefined)) {
                *result = 5;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        QAmqpChannel *_t = static_cast<QAmqpChannel *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = _t->channelNumber(); break;
        case 1: *reinterpret_cast< bool*>(_v) = _t->isOpen(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->name(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        QAmqpChannel *_t = static_cast<QAmqpChannel *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 2: _t->setName(*reinterpret_cast< QString*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject QAmqpChannel::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_QAmqpChannel.data,
    qt_meta_data_QAmqpChannel,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *QAmqpChannel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QAmqpChannel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_QAmqpChannel.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int QAmqpChannel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
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
void QAmqpChannel::opened()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void QAmqpChannel::closed()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void QAmqpChannel::resumed()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void QAmqpChannel::paused()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void QAmqpChannel::error(QAMQP::Error _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void QAmqpChannel::qosDefined()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
