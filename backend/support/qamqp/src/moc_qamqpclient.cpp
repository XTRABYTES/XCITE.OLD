/****************************************************************************
** Meta object code from reading C++ file 'qamqpclient.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "qamqpclient.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#include <QtCore/QList>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qamqpclient.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_QAmqpClient_t {
    QByteArrayData data[32];
    char stringdata0[402];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QAmqpClient_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QAmqpClient_t qt_meta_stringdata_QAmqpClient = {
    {
QT_MOC_LITERAL(0, 0, 11), // "QAmqpClient"
QT_MOC_LITERAL(1, 12, 9), // "connected"
QT_MOC_LITERAL(2, 22, 0), // ""
QT_MOC_LITERAL(3, 23, 12), // "disconnected"
QT_MOC_LITERAL(4, 36, 9), // "heartbeat"
QT_MOC_LITERAL(5, 46, 5), // "error"
QT_MOC_LITERAL(6, 52, 12), // "QAMQP::Error"
QT_MOC_LITERAL(7, 65, 11), // "socketError"
QT_MOC_LITERAL(8, 77, 28), // "QAbstractSocket::SocketError"
QT_MOC_LITERAL(9, 106, 18), // "socketStateChanged"
QT_MOC_LITERAL(10, 125, 28), // "QAbstractSocket::SocketState"
QT_MOC_LITERAL(11, 154, 5), // "state"
QT_MOC_LITERAL(12, 160, 9), // "sslErrors"
QT_MOC_LITERAL(13, 170, 16), // "QList<QSslError>"
QT_MOC_LITERAL(14, 187, 6), // "errors"
QT_MOC_LITERAL(15, 194, 15), // "ignoreSslErrors"
QT_MOC_LITERAL(16, 210, 18), // "_q_socketConnected"
QT_MOC_LITERAL(17, 229, 21), // "_q_socketDisconnected"
QT_MOC_LITERAL(18, 251, 12), // "_q_readyRead"
QT_MOC_LITERAL(19, 264, 14), // "_q_socketError"
QT_MOC_LITERAL(20, 279, 12), // "_q_heartbeat"
QT_MOC_LITERAL(21, 292, 10), // "_q_connect"
QT_MOC_LITERAL(22, 303, 13), // "_q_disconnect"
QT_MOC_LITERAL(23, 317, 4), // "port"
QT_MOC_LITERAL(24, 322, 4), // "host"
QT_MOC_LITERAL(25, 327, 11), // "virtualHost"
QT_MOC_LITERAL(26, 339, 4), // "user"
QT_MOC_LITERAL(27, 344, 8), // "password"
QT_MOC_LITERAL(28, 353, 13), // "autoReconnect"
QT_MOC_LITERAL(29, 367, 10), // "channelMax"
QT_MOC_LITERAL(30, 378, 8), // "frameMax"
QT_MOC_LITERAL(31, 387, 14) // "heartbeatDelay"

    },
    "QAmqpClient\0connected\0\0disconnected\0"
    "heartbeat\0error\0QAMQP::Error\0socketError\0"
    "QAbstractSocket::SocketError\0"
    "socketStateChanged\0QAbstractSocket::SocketState\0"
    "state\0sslErrors\0QList<QSslError>\0"
    "errors\0ignoreSslErrors\0_q_socketConnected\0"
    "_q_socketDisconnected\0_q_readyRead\0"
    "_q_socketError\0_q_heartbeat\0_q_connect\0"
    "_q_disconnect\0port\0host\0virtualHost\0"
    "user\0password\0autoReconnect\0channelMax\0"
    "frameMax\0heartbeatDelay"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QAmqpClient[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      15,   14, // methods
       9,  116, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       7,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   89,    2, 0x06 /* Public */,
       3,    0,   90,    2, 0x06 /* Public */,
       4,    0,   91,    2, 0x06 /* Public */,
       5,    1,   92,    2, 0x06 /* Public */,
       7,    1,   95,    2, 0x06 /* Public */,
       9,    1,   98,    2, 0x06 /* Public */,
      12,    1,  101,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      15,    1,  104,    2, 0x0a /* Public */,
      16,    0,  107,    2, 0x08 /* Private */,
      17,    0,  108,    2, 0x08 /* Private */,
      18,    0,  109,    2, 0x08 /* Private */,
      19,    1,  110,    2, 0x08 /* Private */,
      20,    0,  113,    2, 0x08 /* Private */,
      21,    0,  114,    2, 0x08 /* Private */,
      22,    0,  115,    2, 0x08 /* Private */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 6,    5,
    QMetaType::Void, 0x80000000 | 8,    5,
    QMetaType::Void, 0x80000000 | 10,   11,
    QMetaType::Void, 0x80000000 | 13,   14,

 // slots: parameters
    QMetaType::Void, 0x80000000 | 13,   14,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 8,    5,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
      23, QMetaType::UInt, 0x00095103,
      24, QMetaType::QString, 0x00095103,
      25, QMetaType::QString, 0x00095103,
      26, QMetaType::QString, 0x00095003,
      27, QMetaType::QString, 0x00095103,
      28, QMetaType::Bool, 0x00095103,
      29, QMetaType::Short, 0x00095103,
      30, QMetaType::Int, 0x00095103,
      31, QMetaType::Short, 0x00095103,

       0        // eod
};

void QAmqpClient::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QAmqpClient *_t = static_cast<QAmqpClient *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->connected(); break;
        case 1: _t->disconnected(); break;
        case 2: _t->heartbeat(); break;
        case 3: _t->error((*reinterpret_cast< QAMQP::Error(*)>(_a[1]))); break;
        case 4: _t->socketError((*reinterpret_cast< QAbstractSocket::SocketError(*)>(_a[1]))); break;
        case 5: _t->socketStateChanged((*reinterpret_cast< QAbstractSocket::SocketState(*)>(_a[1]))); break;
        case 6: _t->sslErrors((*reinterpret_cast< const QList<QSslError>(*)>(_a[1]))); break;
        case 7: _t->ignoreSslErrors((*reinterpret_cast< const QList<QSslError>(*)>(_a[1]))); break;
        case 8: _t->d_func()->_q_socketConnected(); break;
        case 9: _t->d_func()->_q_socketDisconnected(); break;
        case 10: _t->d_func()->_q_readyRead(); break;
        case 11: _t->d_func()->_q_socketError((*reinterpret_cast< QAbstractSocket::SocketError(*)>(_a[1]))); break;
        case 12: _t->d_func()->_q_heartbeat(); break;
        case 13: _t->d_func()->_q_connect(); break;
        case 14: _t->d_func()->_q_disconnect(); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 3:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QAMQP::Error >(); break;
            }
            break;
        case 4:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QAbstractSocket::SocketError >(); break;
            }
            break;
        case 5:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QAbstractSocket::SocketState >(); break;
            }
            break;
        case 6:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<QSslError> >(); break;
            }
            break;
        case 7:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<QSslError> >(); break;
            }
            break;
        case 11:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QAbstractSocket::SocketError >(); break;
            }
            break;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (QAmqpClient::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpClient::connected)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (QAmqpClient::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpClient::disconnected)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (QAmqpClient::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpClient::heartbeat)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (QAmqpClient::*)(QAMQP::Error );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpClient::error)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (QAmqpClient::*)(QAbstractSocket::SocketError );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpClient::socketError)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (QAmqpClient::*)(QAbstractSocket::SocketState );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpClient::socketStateChanged)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (QAmqpClient::*)(const QList<QSslError> & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QAmqpClient::sslErrors)) {
                *result = 6;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        QAmqpClient *_t = static_cast<QAmqpClient *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< quint32*>(_v) = _t->port(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->host(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->virtualHost(); break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->username(); break;
        case 4: *reinterpret_cast< QString*>(_v) = _t->password(); break;
        case 5: *reinterpret_cast< bool*>(_v) = _t->autoReconnect(); break;
        case 6: *reinterpret_cast< qint16*>(_v) = _t->channelMax(); break;
        case 7: *reinterpret_cast< qint32*>(_v) = _t->frameMax(); break;
        case 8: *reinterpret_cast< qint16*>(_v) = _t->heartbeatDelay(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        QAmqpClient *_t = static_cast<QAmqpClient *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setPort(*reinterpret_cast< quint32*>(_v)); break;
        case 1: _t->setHost(*reinterpret_cast< QString*>(_v)); break;
        case 2: _t->setVirtualHost(*reinterpret_cast< QString*>(_v)); break;
        case 3: _t->setUsername(*reinterpret_cast< QString*>(_v)); break;
        case 4: _t->setPassword(*reinterpret_cast< QString*>(_v)); break;
        case 5: _t->setAutoReconnect(*reinterpret_cast< bool*>(_v)); break;
        case 6: _t->setChannelMax(*reinterpret_cast< qint16*>(_v)); break;
        case 7: _t->setFrameMax(*reinterpret_cast< qint32*>(_v)); break;
        case 8: _t->setHeartbeatDelay(*reinterpret_cast< qint16*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject QAmqpClient::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_QAmqpClient.data,
    qt_meta_data_QAmqpClient,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *QAmqpClient::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QAmqpClient::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_QAmqpClient.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int QAmqpClient::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 15)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 15;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 15)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 15;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 9;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void QAmqpClient::connected()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void QAmqpClient::disconnected()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void QAmqpClient::heartbeat()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void QAmqpClient::error(QAMQP::Error _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void QAmqpClient::socketError(QAbstractSocket::SocketError _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void QAmqpClient::socketStateChanged(QAbstractSocket::SocketState _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void QAmqpClient::sslErrors(const QList<QSslError> & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
