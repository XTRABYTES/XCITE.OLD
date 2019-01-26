/****************************************************************************
** Meta object code from reading C++ file 'qqmlsortfilterproxymodel.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../frontend/support/SortFilterProxyModel/qqmlsortfilterproxymodel.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#include <QtCore/QVector>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qqmlsortfilterproxymodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_qqsfpm__QQmlSortFilterProxyModel_t {
    QByteArrayData data[54];
    char stringdata0[788];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_qqsfpm__QQmlSortFilterProxyModel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_qqsfpm__QQmlSortFilterProxyModel_t qt_meta_stringdata_qqsfpm__QQmlSortFilterProxyModel = {
    {
QT_MOC_LITERAL(0, 0, 32), // "qqsfpm::QQmlSortFilterProxyModel"
QT_MOC_LITERAL(1, 33, 12), // "countChanged"
QT_MOC_LITERAL(2, 46, 0), // ""
QT_MOC_LITERAL(3, 47, 21), // "filterRoleNameChanged"
QT_MOC_LITERAL(4, 69, 26), // "filterPatternSyntaxChanged"
QT_MOC_LITERAL(5, 96, 20), // "filterPatternChanged"
QT_MOC_LITERAL(6, 117, 18), // "filterValueChanged"
QT_MOC_LITERAL(7, 136, 19), // "sortRoleNameChanged"
QT_MOC_LITERAL(8, 156, 25), // "ascendingSortOrderChanged"
QT_MOC_LITERAL(9, 182, 17), // "resetInternalData"
QT_MOC_LITERAL(10, 200, 16), // "invalidateFilter"
QT_MOC_LITERAL(11, 217, 10), // "invalidate"
QT_MOC_LITERAL(12, 228, 15), // "updateRoleNames"
QT_MOC_LITERAL(13, 244, 16), // "updateFilterRole"
QT_MOC_LITERAL(14, 261, 14), // "updateSortRole"
QT_MOC_LITERAL(15, 276, 11), // "updateRoles"
QT_MOC_LITERAL(16, 288, 9), // "initRoles"
QT_MOC_LITERAL(17, 298, 13), // "onDataChanged"
QT_MOC_LITERAL(18, 312, 11), // "QModelIndex"
QT_MOC_LITERAL(19, 324, 7), // "topLeft"
QT_MOC_LITERAL(20, 332, 11), // "bottomRight"
QT_MOC_LITERAL(21, 344, 12), // "QVector<int>"
QT_MOC_LITERAL(22, 357, 5), // "roles"
QT_MOC_LITERAL(23, 363, 21), // "emitProxyRolesChanged"
QT_MOC_LITERAL(24, 385, 11), // "roleForName"
QT_MOC_LITERAL(25, 397, 8), // "roleName"
QT_MOC_LITERAL(26, 406, 3), // "get"
QT_MOC_LITERAL(27, 410, 3), // "row"
QT_MOC_LITERAL(28, 414, 11), // "mapToSource"
QT_MOC_LITERAL(29, 426, 10), // "proxyIndex"
QT_MOC_LITERAL(30, 437, 8), // "proxyRow"
QT_MOC_LITERAL(31, 446, 13), // "mapFromSource"
QT_MOC_LITERAL(32, 460, 11), // "sourceIndex"
QT_MOC_LITERAL(33, 472, 9), // "sourceRow"
QT_MOC_LITERAL(34, 482, 5), // "count"
QT_MOC_LITERAL(35, 488, 14), // "filterRoleName"
QT_MOC_LITERAL(36, 503, 13), // "filterPattern"
QT_MOC_LITERAL(37, 517, 19), // "filterPatternSyntax"
QT_MOC_LITERAL(38, 537, 13), // "PatternSyntax"
QT_MOC_LITERAL(39, 551, 11), // "filterValue"
QT_MOC_LITERAL(40, 563, 12), // "sortRoleName"
QT_MOC_LITERAL(41, 576, 18), // "ascendingSortOrder"
QT_MOC_LITERAL(42, 595, 7), // "filters"
QT_MOC_LITERAL(43, 603, 32), // "QQmlListProperty<qqsfpm::Filter>"
QT_MOC_LITERAL(44, 636, 7), // "sorters"
QT_MOC_LITERAL(45, 644, 32), // "QQmlListProperty<qqsfpm::Sorter>"
QT_MOC_LITERAL(46, 677, 10), // "proxyRoles"
QT_MOC_LITERAL(47, 688, 35), // "QQmlListProperty<qqsfpm::Prox..."
QT_MOC_LITERAL(48, 724, 6), // "RegExp"
QT_MOC_LITERAL(49, 731, 8), // "Wildcard"
QT_MOC_LITERAL(50, 740, 11), // "FixedString"
QT_MOC_LITERAL(51, 752, 7), // "RegExp2"
QT_MOC_LITERAL(52, 760, 12), // "WildcardUnix"
QT_MOC_LITERAL(53, 773, 14) // "W3CXmlSchema11"

    },
    "qqsfpm::QQmlSortFilterProxyModel\0"
    "countChanged\0\0filterRoleNameChanged\0"
    "filterPatternSyntaxChanged\0"
    "filterPatternChanged\0filterValueChanged\0"
    "sortRoleNameChanged\0ascendingSortOrderChanged\0"
    "resetInternalData\0invalidateFilter\0"
    "invalidate\0updateRoleNames\0updateFilterRole\0"
    "updateSortRole\0updateRoles\0initRoles\0"
    "onDataChanged\0QModelIndex\0topLeft\0"
    "bottomRight\0QVector<int>\0roles\0"
    "emitProxyRolesChanged\0roleForName\0"
    "roleName\0get\0row\0mapToSource\0proxyIndex\0"
    "proxyRow\0mapFromSource\0sourceIndex\0"
    "sourceRow\0count\0filterRoleName\0"
    "filterPattern\0filterPatternSyntax\0"
    "PatternSyntax\0filterValue\0sortRoleName\0"
    "ascendingSortOrder\0filters\0"
    "QQmlListProperty<qqsfpm::Filter>\0"
    "sorters\0QQmlListProperty<qqsfpm::Sorter>\0"
    "proxyRoles\0QQmlListProperty<qqsfpm::ProxyRole>\0"
    "RegExp\0Wildcard\0FixedString\0RegExp2\0"
    "WildcardUnix\0W3CXmlSchema11"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_qqsfpm__QQmlSortFilterProxyModel[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      24,   14, // methods
      10,  180, // properties
       1,  220, // enums/sets
       0,    0, // constructors
       0,       // flags
       7,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,  134,    2, 0x06 /* Public */,
       3,    0,  135,    2, 0x06 /* Public */,
       4,    0,  136,    2, 0x06 /* Public */,
       5,    0,  137,    2, 0x06 /* Public */,
       6,    0,  138,    2, 0x06 /* Public */,
       7,    0,  139,    2, 0x06 /* Public */,
       8,    0,  140,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       9,    0,  141,    2, 0x09 /* Protected */,
      10,    0,  142,    2, 0x08 /* Private */,
      11,    0,  143,    2, 0x08 /* Private */,
      12,    0,  144,    2, 0x08 /* Private */,
      13,    0,  145,    2, 0x08 /* Private */,
      14,    0,  146,    2, 0x08 /* Private */,
      15,    0,  147,    2, 0x08 /* Private */,
      16,    0,  148,    2, 0x08 /* Private */,
      17,    3,  149,    2, 0x08 /* Private */,
      23,    0,  156,    2, 0x08 /* Private */,

 // methods: name, argc, parameters, tag, flags
      24,    1,  157,    2, 0x02 /* Public */,
      26,    1,  160,    2, 0x02 /* Public */,
      26,    2,  163,    2, 0x02 /* Public */,
      28,    1,  168,    2, 0x02 /* Public */,
      28,    1,  171,    2, 0x02 /* Public */,
      31,    1,  174,    2, 0x02 /* Public */,
      31,    1,  177,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 18, 0x80000000 | 18, 0x80000000 | 21,   19,   20,   22,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Int, QMetaType::QString,   25,
    QMetaType::QVariantMap, QMetaType::Int,   27,
    QMetaType::QVariant, QMetaType::Int, QMetaType::QString,   27,   25,
    0x80000000 | 18, 0x80000000 | 18,   29,
    QMetaType::Int, QMetaType::Int,   30,
    0x80000000 | 18, 0x80000000 | 18,   32,
    QMetaType::Int, QMetaType::Int,   33,

 // properties: name, type, flags
      34, QMetaType::Int, 0x00495001,
      35, QMetaType::QString, 0x00495103,
      36, QMetaType::QString, 0x00495103,
      37, 0x80000000 | 38, 0x0049510b,
      39, QMetaType::QVariant, 0x00495103,
      40, QMetaType::QString, 0x00495103,
      41, QMetaType::Bool, 0x00495103,
      42, 0x80000000 | 43, 0x00095009,
      44, 0x80000000 | 45, 0x00095009,
      46, 0x80000000 | 47, 0x00095009,

 // properties: notify_signal_id
       0,
       1,
       3,
       2,
       4,
       5,
       6,
       0,
       0,
       0,

 // enums: name, flags, count, data
      38, 0x0,    6,  224,

 // enum data: key, value
      48, uint(qqsfpm::QQmlSortFilterProxyModel::RegExp),
      49, uint(qqsfpm::QQmlSortFilterProxyModel::Wildcard),
      50, uint(qqsfpm::QQmlSortFilterProxyModel::FixedString),
      51, uint(qqsfpm::QQmlSortFilterProxyModel::RegExp2),
      52, uint(qqsfpm::QQmlSortFilterProxyModel::WildcardUnix),
      53, uint(qqsfpm::QQmlSortFilterProxyModel::W3CXmlSchema11),

       0        // eod
};

void qqsfpm::QQmlSortFilterProxyModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QQmlSortFilterProxyModel *_t = static_cast<QQmlSortFilterProxyModel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->countChanged(); break;
        case 1: _t->filterRoleNameChanged(); break;
        case 2: _t->filterPatternSyntaxChanged(); break;
        case 3: _t->filterPatternChanged(); break;
        case 4: _t->filterValueChanged(); break;
        case 5: _t->sortRoleNameChanged(); break;
        case 6: _t->ascendingSortOrderChanged(); break;
        case 7: _t->resetInternalData(); break;
        case 8: _t->invalidateFilter(); break;
        case 9: _t->invalidate(); break;
        case 10: _t->updateRoleNames(); break;
        case 11: _t->updateFilterRole(); break;
        case 12: _t->updateSortRole(); break;
        case 13: _t->updateRoles(); break;
        case 14: _t->initRoles(); break;
        case 15: _t->onDataChanged((*reinterpret_cast< const QModelIndex(*)>(_a[1])),(*reinterpret_cast< const QModelIndex(*)>(_a[2])),(*reinterpret_cast< const QVector<int>(*)>(_a[3]))); break;
        case 16: _t->emitProxyRolesChanged(); break;
        case 17: { int _r = _t->roleForName((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 18: { QVariantMap _r = _t->get((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantMap*>(_a[0]) = std::move(_r); }  break;
        case 19: { QVariant _r = _t->get((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = std::move(_r); }  break;
        case 20: { QModelIndex _r = _t->mapToSource((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QModelIndex*>(_a[0]) = std::move(_r); }  break;
        case 21: { int _r = _t->mapToSource((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 22: { QModelIndex _r = _t->mapFromSource((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QModelIndex*>(_a[0]) = std::move(_r); }  break;
        case 23: { int _r = _t->mapFromSource((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 15:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 2:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QVector<int> >(); break;
            }
            break;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (QQmlSortFilterProxyModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QQmlSortFilterProxyModel::countChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (QQmlSortFilterProxyModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QQmlSortFilterProxyModel::filterRoleNameChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (QQmlSortFilterProxyModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QQmlSortFilterProxyModel::filterPatternSyntaxChanged)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (QQmlSortFilterProxyModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QQmlSortFilterProxyModel::filterPatternChanged)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (QQmlSortFilterProxyModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QQmlSortFilterProxyModel::filterValueChanged)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (QQmlSortFilterProxyModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QQmlSortFilterProxyModel::sortRoleNameChanged)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (QQmlSortFilterProxyModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QQmlSortFilterProxyModel::ascendingSortOrderChanged)) {
                *result = 6;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        QQmlSortFilterProxyModel *_t = static_cast<QQmlSortFilterProxyModel *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = _t->count(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->filterRoleName(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->filterPattern(); break;
        case 3: *reinterpret_cast< PatternSyntax*>(_v) = _t->filterPatternSyntax(); break;
        case 4: *reinterpret_cast< QVariant*>(_v) = _t->filterValue(); break;
        case 5: *reinterpret_cast< QString*>(_v) = _t->sortRoleName(); break;
        case 6: *reinterpret_cast< bool*>(_v) = _t->ascendingSortOrder(); break;
        case 7: *reinterpret_cast< QQmlListProperty<qqsfpm::Filter>*>(_v) = _t->filtersListProperty(); break;
        case 8: *reinterpret_cast< QQmlListProperty<qqsfpm::Sorter>*>(_v) = _t->sortersListProperty(); break;
        case 9: *reinterpret_cast< QQmlListProperty<qqsfpm::ProxyRole>*>(_v) = _t->proxyRolesListProperty(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        QQmlSortFilterProxyModel *_t = static_cast<QQmlSortFilterProxyModel *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 1: _t->setFilterRoleName(*reinterpret_cast< QString*>(_v)); break;
        case 2: _t->setFilterPattern(*reinterpret_cast< QString*>(_v)); break;
        case 3: _t->setFilterPatternSyntax(*reinterpret_cast< PatternSyntax*>(_v)); break;
        case 4: _t->setFilterValue(*reinterpret_cast< QVariant*>(_v)); break;
        case 5: _t->setSortRoleName(*reinterpret_cast< QString*>(_v)); break;
        case 6: _t->setAscendingSortOrder(*reinterpret_cast< bool*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject qqsfpm::QQmlSortFilterProxyModel::staticMetaObject = {
    { &QSortFilterProxyModel::staticMetaObject, qt_meta_stringdata_qqsfpm__QQmlSortFilterProxyModel.data,
      qt_meta_data_qqsfpm__QQmlSortFilterProxyModel,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *qqsfpm::QQmlSortFilterProxyModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *qqsfpm::QQmlSortFilterProxyModel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_qqsfpm__QQmlSortFilterProxyModel.stringdata0))
        return static_cast<void*>(this);
    if (!strcmp(_clname, "QQmlParserStatus"))
        return static_cast< QQmlParserStatus*>(this);
    if (!strcmp(_clname, "FilterContainer"))
        return static_cast< FilterContainer*>(this);
    if (!strcmp(_clname, "SorterContainer"))
        return static_cast< SorterContainer*>(this);
    if (!strcmp(_clname, "ProxyRoleContainer"))
        return static_cast< ProxyRoleContainer*>(this);
    if (!strcmp(_clname, "org.qt-project.Qt.QQmlParserStatus"))
        return static_cast< QQmlParserStatus*>(this);
    if (!strcmp(_clname, "fr.grecko.SortFilterProxyModel.FilterContainer"))
        return static_cast< qqsfpm::FilterContainer*>(this);
    if (!strcmp(_clname, "fr.grecko.SortFilterProxyModel.SorterContainer"))
        return static_cast< qqsfpm::SorterContainer*>(this);
    if (!strcmp(_clname, "fr.grecko.SortFilterProxyModel.ProxyRoleContainer"))
        return static_cast< qqsfpm::ProxyRoleContainer*>(this);
    return QSortFilterProxyModel::qt_metacast(_clname);
}

int qqsfpm::QQmlSortFilterProxyModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QSortFilterProxyModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 24)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 24;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 24)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 24;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 10;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 10;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 10;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 10;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 10;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void qqsfpm::QQmlSortFilterProxyModel::countChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void qqsfpm::QQmlSortFilterProxyModel::filterRoleNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void qqsfpm::QQmlSortFilterProxyModel::filterPatternSyntaxChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void qqsfpm::QQmlSortFilterProxyModel::filterPatternChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void qqsfpm::QQmlSortFilterProxyModel::filterValueChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void qqsfpm::QQmlSortFilterProxyModel::sortRoleNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void qqsfpm::QQmlSortFilterProxyModel::ascendingSortOrderChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
