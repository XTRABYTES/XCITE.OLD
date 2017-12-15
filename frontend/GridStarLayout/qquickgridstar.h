#ifndef QQUICKGRIDSTAR_H
#define QQUICKGRIDSTAR_H

#include <QQuickItem>
#include <QQuickWindow>

#include "qquickgriddefinition.h"

class QQuickGridStar;

class QQuickRowDefinition : public QQuickItem
{
    friend class QQuickGridStar;

    Q_OBJECT

    Q_PROPERTY(qreal weight MEMBER m_weight)

public:
    QQuickRowDefinition(QQuickItem *parent = nullptr);

protected:
    qreal
        m_weight;
};

class QQuickColumnDefinition : public QQuickItem
{
    friend class QQuickGridStar;

    Q_OBJECT

    Q_PROPERTY(qreal weight MEMBER m_weight)

public:
    QQuickColumnDefinition(QQuickItem *parent = nullptr);

protected:
    qreal
        m_weight;
};

class QQuickGridStarAttached : public QObject
{
    friend class QQuickGridStar;

    Q_OBJECT

    Q_PROPERTY(bool ignore READ getIgnore WRITE setIgnore)
    Q_PROPERTY(qint32 row READ getRow WRITE setRow)
    Q_PROPERTY(qint32 column READ getColumn WRITE setColumn)
    Q_PROPERTY(qint32 rowSpan READ getRowSpan WRITE setRowSpan)
    Q_PROPERTY(qint32 columnSpan READ getColumnSpan WRITE setColumnSpan)

public:
    QQuickGridStarAttached(QObject *object);

    bool getIgnore();
    qint32 getRow();
    qint32 getColumn();
    qint32 getRowSpan();
    qint32 getColumnSpan();

    void setIgnore(bool ignore);
    void setRow(qint32 row);
    void setColumn(qint32 column);
    void setRowSpan(qint32 rowSpan);
    void setColumnSpan(qint32 columnSpan);

protected:
    bool
        m_ignore,
        m_dirty;
    qint32
        m_row,
        m_column,
        m_rowSpan,
        m_columnSpan,
        m_rowSpanActual,
        m_columnSpanActual;
};

class QQuickGridStar : public QQuickItem
{
    Q_OBJECT

    QList<QQuickItem *>
        m_items;

    QQuickGridDefinition
        m_gridDefinition;

public:
    QQuickGridStar(QQuickItem *parent = nullptr);
    ~QQuickGridStar();

    Q_INVOKABLE qint32 rowCount();
    Q_INVOKABLE qint32 columnCount();

    Q_INVOKABLE QVariant itemsAt(qint32 row, qint32 column);

    Q_INVOKABLE void addRowDefinition(qreal weight = 1.0f, qint32 row = -1);
    Q_INVOKABLE void addColumnDefinition(qreal weight = 1.0f, qint32 column = -1);

    Q_INVOKABLE void removeRowDefinition(qint32 row = -1);
    Q_INVOKABLE void removeColumnDefinition(qint32 column = -1);

    static QQuickGridStarAttached *qmlAttachedProperties(QObject *object);

protected:
    void componentComplete() Q_DECL_OVERRIDE;
    void itemChange(ItemChange change, const ItemChangeData &value) Q_DECL_OVERRIDE;
    void geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry) Q_DECL_OVERRIDE;
    void updatePolish() Q_DECL_OVERRIDE;
};

QML_DECLARE_TYPEINFO(QQuickGridStar, QML_HAS_ATTACHED_PROPERTIES)
QML_DECLARE_TYPE(QQuickRowDefinition)
QML_DECLARE_TYPE(QQuickColumnDefinition)

void registerQuickGridStarTypes();

#endif // QQUICKGRIDSTAR_H
