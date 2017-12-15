#ifndef QQUICKGRIDDEFINITION_H
#define QQUICKGRIDDEFINITION_H

#include <QObject>
#include <QList>

class QQuickGridDefinition
{
    struct QQuickGridCell
    {
        qreal
            m_weight,
            m_offset;

        QQuickGridCell(qreal weight, qreal offset) :
            m_weight(weight),
            m_offset(offset)
        {
        }
    };

    QList<QQuickGridCell>
        m_rows,
        m_columns;

    qreal
        m_rowSize,
        m_columnSize,
        m_invRowSize,
        m_invColumnSize;

public:
    QQuickGridDefinition();

    void addRowDefinition(qreal weight = 1.0f, qint32 row = -1);
    void addColumnDefinition(qreal weight = 1.0f, qint32 column = -1);

    void removeRowDefinition(qint32 row = -1);
    void removeColumnDefinition(qint32 column = -1);

    qint32 rowCount() const;
    qint32 columnCount() const;

    qreal rowOffset(qint32 index);
    qreal columnOffset(qint32 index);

    qreal rowWeight(qint32 index);
    qreal columnWeight(qint32 index);

    QPointF cellPoint(QRectF rect, qint32 row, qint32 column);
    QSizeF cellSize(QRectF rect, qint32 row, qint32 column, qint32 rowSpan, qint32 columnSpan);
    QRectF cellRect(QRectF rect, qint32 row, qint32 column, qint32 rowSpan = 1, qint32 columnSpan = 1);

    void calculateBounds(qint32 &row, qint32 &column, qint32 &rowSpan, qint32 &columnSpan);
};

#endif // QQUICKGRIDDEFINITION_H
