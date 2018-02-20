import QtQuick 2.7
import QtQuick.Layouts 1.2

Rectangle {
    // Containing gray rectangle
    id: searchResultsBox

    width: parent.width
    height: searchBoxResultsId.implicitHeight //searchBoxResultsId.implicitHeight

    radius: 5
    color: "#3A3E46"

    border.color: "#4010B9C5"
    border.width: 3

    anchors.top: searchBoxId.bottom
    anchors.topMargin: 3

    opacity: 0.9
    visible: false

    property string text: ""

    onTextChanged: {
        console.log("text of search changed")
    }

    Column {
        // Box containing categories
        id: searchBoxResultsId
        spacing: 2
        leftPadding: 5
        visible: true
        width: parent.width
        height: searchResultsCategory.height

        Rectangle {
            // A category
            id: searchResultsCategory

            property string text: "Category"

            width: parent.width
            height: textLabelId.height
                    + searhResultsCategoryRowLayoutId.implicitHeight //implicitHeight

            color: "transparent"
            visible: true

            Text {
                id: textLabelId
                text: searchResultsCategory.text

                width: parent.width

                font.family: "Roboto"
                font.pointSize: 13
                color: "#10B9C5"
                padding: 3
            }

            // Content of category

            // Results
            GridLayout {
                id: searhResultsCategoryRowLayoutId
                width: parent.width

                anchors.top: textLabelId.bottom
                columns: 1

                // A result item
                Rectangle {
                    width: parent.width
                    height: textLabelaId.implicitHeight

                    color: "transparent"
                    Text {
                        id: textLabelaId
                        text: "Hello World!"
                        font.family: "Roboto"
                        font.pointSize: 11
                        color: "white"
                        topPadding: 5
                        bottomPadding: 10
                        leftPadding: 20
                    }
                }

                // Another
                Rectangle {
                    width: parent.width
                    //radius: searchResultsBox.radius
                    color: "transparent"
                    height: textLabelaId2.implicitHeight
                    Text {
                        id: textLabelaId2
                        text: "Hello World! 22"
                        font.family: "Roboto"
                        font.pointSize: 11
                        color: "white"
                        topPadding: 5
                        bottomPadding: 10
                        leftPadding: 20
                    }
                }
            }
            /*
                Rectangle {
                    width: searchResultsBox.width
                    color: "transparent"
                    radius: searchResultsBox.radius
                    height: textLabelIda2.implicitHeight
                    Text {
                        id: textLabelIda2
                        text: "Hello World 2"
                        font.family: "Helvetica"
                        font.pointSize: 11
                        padding: 5
                        color: "white"
                    }
                }
            }*/
        }
    }
}
