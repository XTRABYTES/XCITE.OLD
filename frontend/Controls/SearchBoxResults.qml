import QtQuick 2.7

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

        SearchBoxResultsCategory {
            text: "A category text"
        }

        SearchBoxResultsCategory {
            text: "Another beautiful category"
        }
    }
}
