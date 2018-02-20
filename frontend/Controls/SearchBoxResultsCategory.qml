import QtQuick 2.7
import QtQuick.Layouts 1.2

Rectangle {
    // A category section
    id: searchResultsCategory

    property string text: "Category"

    width: parent.width
    implicitHeight: textLabelId.implicitHeight + searhResultsCategoryRowLayoutId.implicitHeight

    color: "transparent"
    visible: true

    // Category name
    Text {
        id: textLabelId
        text: searchResultsCategory.text

        width: parent.width

        topPadding: 2
        leftPadding: 7

        color: "#10B9C5"
        font.family: "Roboto"
        font.pointSize: 13
    }

    // Content of category

    // Results
    Column {
        id: searhResultsCategoryRowLayoutId

        anchors.top: textLabelId.bottom
        width: parent.width
        height: Column.height

        spacing: 1

        //children: [
        SearchBoxResultsCategoryItem {
            //height: 12
            text: "First item - click here for log"
            function onSearchResultClicked() {
                console.log("overwritten function onSearchResultClicked called!!")
            }
        }

        SearchBoxResultsCategoryItem {
            //height: 12
            text: "Second item"
        }

        SearchBoxResultsCategoryItem {
            //height: 12
            text: "Third item"
        }
    }
}
