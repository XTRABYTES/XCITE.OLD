import QtQuick 2.7
import QtQuick.Layouts 1.2

Rectangle {
    // A category section
    id: searchResultsCategory

    property string text: "Category"

    width: parent.width
    height: textLabelId.height + searhResultsCategoryRowLayoutId.height

    color: "transparent"
    visible: true

    // Category name
    Text {
        id: textLabelId

        text: searchResultsCategory.text

        width: parent.width
        topPadding: 5
        leftPadding: 7

        color: "#10B9C5"
        font.family: "Roboto"
        font.pointSize: 13
    }

    // Content of category

    // Results
    GridLayout {
        id: searhResultsCategoryRowLayoutId

        anchors.top: textLabelId.bottom
        width: parent.width
        columns: 1

        // A result item
        Rectangle {
            width: parent.fillWidth
            height: 12
            //height: textLabelaId.implicitHeight
            color: "transparent"
            Text {
                verticalAlignment: parent.verticalCenter
                id: textLabelaId
                text: "Hello World!"
                font.family: "Roboto"
                font.pointSize: 9
                color: "white"
            }
        }

        // Another
        Rectangle {
            width: parent.fillWidth
            //radius: searchResultsBox.radius
            color: "transparent"
            //height: textLabelaId2.implicitHeight
            Text {
                verticalAlignment: parent.verticalCenter
                id: textLabelaId2
                text: "Hello World! 22"
                font.family: "Roboto"
                font.pointSize: 9
                color: "white"
            }
        }
    }
}
