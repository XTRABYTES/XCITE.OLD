import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.1
import EmbeddedAuto 1.0
import QuickGridStar 1.0

// TODO: Currently this is a low-performance proof of concept demonstrating scalability.
// For production, this should be refactored to make proper use of Loaders, limit the use of JavaScript functions, etc.
// More information: http://doc.qt.io/qt-5/scalability.html

GridStar {
    id: grid
    anchors.fill: parent
    // Define 3 rows, with the middle row being twice as tall as the other 2
    RowDefinition { weight: 0.25 }
    RowDefinition { weight: 0.5 }
    RowDefinition { weight: 0.25 }

    // Define 5 columns of equal width
    ColumnDefinition { weight: 0.2 }
    ColumnDefinition { weight: 0.2 }
    ColumnDefinition { weight: 0.2 }
    ColumnDefinition { weight: 0.2 }
    ColumnDefinition { weight: 0.2 }

    // Whenever the grid is resized, recalculate rows, columns and blocks
    onWidthChanged: {

        //rectangle4.visible = grid.width > 768 ? true : (grid.width > grid.height ? true : false)
        rectangle4.visible = grid.width > 768 ? true : false
        rectangle5.visible = grid.width > 768 ? true : false
        rectangle7.visible = grid.width > 768 ? true : false
        rectangle8.visible = grid.width > 768 ? true : (grid.width < grid.height ? true : false)
        rectangle9.visible = grid.width > 768 ? true : false
        rectangle10.visible = grid.width > 768 ? true : false
        rectangle11.visible = grid.width > 768 ? true : false

        // For now, use an assumed mobile width of 768 but this should likely be changed
        if (grid.width < 768) {
            // Since resizing will fire this for each resize "tick", check the column count before changing column definitions
            if (grid.columnCount() === 5) {
                // Remove the extra columns
                grid.removeColumnDefinition(4)
                grid.removeColumnDefinition(5)
                rectangle8.GridStar.row = 2
                rectangle8.GridStar.columnSpan = 2
            }
            if (grid.width > grid.height) {
                // In landscape mode, remove the last row if it exists
                if (grid.rowCount() === 3)
                    grid.removeRowDefinition(2)
            } else {
                // In portrait mode, add the last row if it doesn't yet exist
                if (grid.rowCount() === 2) {
                    grid.addRowDefinition(0.25, 2)
                    rectangle8.GridStar.row = 2
                }
            }
        }
        else {
            // For non-mobile devices, make all columns visible
            if (grid.columnCount() === 3) {
                grid.addColumnDefinition(0.2, 3)
                grid.addColumnDefinition(0.2, 4)
                rectangle4.GridStar.column = 3
                rectangle5.GridStar.column = 4
                rectangle7.GridStar.column = 3
                rectangle8.GridStar.columnSpan = 1
                rectangle10.GridStar.column = 3
                rectangle11.GridStar.column = 4
            }
            // For non-mobile devices, make all rows visible
            if (grid.rowCount() === 2) {
                grid.addRowDefinition(0.25, 2)
                rectangle8.GridStar.row = 2
                rectangle9.GridStar.row = 2
                rectangle10.GridStar.row = 2
                rectangle11.GridStar.row = 2
            }
        }
    }

    Rectangle {
        id: rectangle1
        // GridStar row and column positioning is 0-index based
        GridStar.row: 0
        GridStar.column: 0
        GridStar.rowSpan: 3
        color: "#5CD106"

        Text {
            id: text1
            text: qsTr("BLOCK 1 MENU")
            font.pixelSize: 12
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rectangle2
        GridStar.row: 0
        GridStar.column: 1
        color: "#F6B6B6"

        Text {
            text: qsTr("BLOCK 2")
            font.pixelSize: 12
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rectangle3
        GridStar.row: 0
        GridStar.column: 2
        color: "#F09091"

        Text {
            text: qsTr("BLOCK 3")
            font.pixelSize: 12
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rectangle4
        GridStar.row: 0
        GridStar.column: 3
        color: "#F15757"

        Text {
            text: qsTr("BLOCK 4")
            font.pixelSize: 12
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rectangle5
        GridStar.row: 0
        GridStar.column: 4
        color: "#FE0000"

        Text {
            text: qsTr("BLOCK 5")
            font.pixelSize: 12
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rectangle6
        GridStar.row: 1
        GridStar.column: 1
        GridStar.columnSpan: 2
        color: "#617FEF"

        Text {
            text: qsTr("BLOCK 6")
            font.pixelSize: 12
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rectangle7
        GridStar.row: 1
        GridStar.column: 3
        GridStar.columnSpan: 2
        color: "#8581CD"

        Text {
            text: qsTr("BLOCK 7")
            font.pixelSize: 12
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rectangle8
        GridStar.row: 2
        GridStar.column: 1
        // This block should span 2 columns when in mobile landscape mode - otherwise it should span 1 column
        GridStar.columnSpan: grid.width < 768 && grid.width > grid.height ? 2 : 1
        color: "#FBF49A"

        Text {
            text: qsTr("BLOCK 8")
            font.pixelSize: 12
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rectangle9
        GridStar.row: 2
        GridStar.column: 2
        color: "#EBE166"

        Text {
            text: qsTr("BLOCK 9")
            font.pixelSize: 12
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rectangle10
        GridStar.row: 2
        GridStar.column: 3
        color: "#EFE233"

        Text {
            text: qsTr("BLOCK 10")
            font.pixelSize: 12
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rectangle11
        GridStar.row: 2
        GridStar.column: 4
        color: "#C2B300"

        Text {
            text: qsTr("BLOCK 11")
            font.pixelSize: 12
            anchors.centerIn: parent
        }
    }
}
