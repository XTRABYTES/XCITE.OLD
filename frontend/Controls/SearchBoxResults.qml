import QtQuick 2.7

Rectangle {
    id: searchResultsBox

    width: searchBoxId.width
    height: searchBoxResultsId.implicitHeight
    radius: 5
    color: "#61646a"
    anchors.top: searchBoxId.bottom
    anchors.topMargin: 3
    opacity: 0.9
    visible: false

    property string text: ""

    Column {
        id: searchBoxResultsId
        spacing: 2
        leftPadding: 5

        Rectangle {
            width: searchResultsBox.width
            radius: searchResultsBox.radius
            color: "transparent"
            height: textLabelId.implicitHeight
            Text {
                id: textLabelId
                text: "Hello World!"
                font.family: "Helvetica"
                font.pointSize: 11
                color: "white"
                padding: 5
            }
        }

        Rectangle {
            width: searchResultsBox.width
            color: "transparent"
            radius: searchResultsBox.radius
            height: textLabelId2.implicitHeight
            Text {
                id: textLabelId2
                text: "Hello World 2"
                font.family: "Helvetica"
                font.pointSize: 11
                padding: 5
                color: "white"
            }
        }
    }
}
