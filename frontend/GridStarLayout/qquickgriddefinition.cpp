#include "qquickgriddefinition.h"

QQuickGridDefinition::QQuickGridDefinition() :
    m_rowSize(0.0f),
    m_columnSize(0.0f),
    m_invRowSize(0.0f),
    m_invColumnSize(0.0f)
{
}

void QQuickGridDefinition::addRowDefinition(qreal weight, qint32 row)
{
    if(row < 0 || row >= rowCount())
    {
        m_rows << QQuickGridCell(weight, m_rowSize);
    }
    else
    {
        m_rows.insert(row, QQuickGridCell(weight, m_rows[row].m_offset));

        for(row = row + 1; row < rowCount(); row++)
        {
            m_rows[row].m_offset += weight;
        }
    }

    m_rowSize += weight;
    m_invRowSize = 1.0f / m_rowSize;
}

void QQuickGridDefinition::addColumnDefinition(qreal weight, qint32 column)
{
    if(column < 0 || column >= columnCount())
    {
        m_columns << QQuickGridCell(weight, m_columnSize);
    }
    else
    {
        m_columns.insert(column, QQuickGridCell(weight, m_columns[column].m_offset));

        for(column = column + 1; column < columnCount(); column++)
        {
            m_columns[column].m_offset += weight;
        }
    }

    m_columnSize += weight;
    m_invColumnSize = 1.0f / m_columnSize;
}

void QQuickGridDefinition::removeRowDefinition(qint32 row)
{
    if(rowCount() == 0)
    {
        return;
    }

    qreal
            weight;

    if(row < 0 || row >= rowCount())
    {
        weight = m_rows[rowCount() - 1].m_weight;

        m_rows.removeLast();
    }
    else
    {
        weight = m_rows[row].m_weight;

        m_rows.removeAt(row);

        for( ; row < rowCount(); row++)
        {
            m_rows[row].m_offset -= weight;
        }
    }

    m_rowSize -= weight;
    m_invRowSize = 1.0f / m_rowSize;
}

void QQuickGridDefinition::removeColumnDefinition(qint32 column)
{
    if(columnCount() == 0)
    {
        return;
    }

    qreal
            weight;

    if(column < 0 || column >= columnCount())
    {
        weight = m_columns[columnCount() - 1].m_weight;

        m_columns.removeLast();
    }
    else
    {
        weight = m_columns[column].m_weight;

        m_columns.removeAt(column);

        for( ; column < columnCount(); column++)
        {
            m_columns[column].m_offset -= weight;
        }
    }

    m_columnSize -= weight;
    m_invColumnSize = 1.0f / m_columnSize;
}

qint32 QQuickGridDefinition::rowCount() const
{
    return m_rows.size();
}

qint32 QQuickGridDefinition::columnCount() const
{
    return m_columns.size();
}

qreal QQuickGridDefinition::rowOffset(qint32 index)
{
    return m_rows[index].m_offset * m_invRowSize;
}

qreal QQuickGridDefinition::columnOffset(qint32 index)
{
    return m_columns[index].m_offset * m_invColumnSize;
}

qreal QQuickGridDefinition::rowWeight(qint32 index)
{
    return m_rows[index].m_weight * m_invRowSize;
}

qreal QQuickGridDefinition::columnWeight(qint32 index)
{
    return m_columns[index].m_weight * m_invColumnSize;
}

QPointF QQuickGridDefinition::cellPoint(QRectF rect, qint32 row, qint32 column)
{
    return QPointF(columnOffset(column) * rect.width() + rect.x(), rowOffset(row) * rect.height() + rect.y());
}

QSizeF QQuickGridDefinition::cellSize(QRectF rect, qint32 row, qint32 column, qint32 rowSpan, qint32 columnSpan)
{
    QSizeF
        size;

    for(qint32 end = qMin(row + rowSpan, rowCount()); row < end; row++)
    {
        size.rheight() += rowWeight(row) * rect.height();
    }

    for(qint32 end = qMin(column + columnSpan, columnCount()); column < end; column++)
    {
        size.rwidth() += columnWeight(column) * rect.width();
    }

    return size;
}

QRectF QQuickGridDefinition::cellRect(QRectF rect, qint32 row, qint32 column, qint32 rowSpan, qint32 columnSpan)
{
    return QRectF(cellPoint(rect, row, column), cellSize(rect, row, column, rowSpan, columnSpan));
}

void QQuickGridDefinition::calculateBounds(qint32 &row, qint32 &column, qint32 &rowSpan, qint32 &columnSpan)
{
    qint32
        rowSize = rowCount(),
        columnSize = columnCount();

    row = qBound(0, row, rowSize - 1);
    column = qBound(0, column, columnSize - 1);

    if(rowSpan <= 0)
    {
        rowSpan = rowSize - row + rowSpan;
    }

    if(columnSpan <= 0)
    {
        columnSpan = columnSize - column + columnSpan;
    }

    rowSpan = qBound(1, rowSpan, rowSize - row);
    columnSpan = qBound(1, columnSpan, columnSize - column);
}
