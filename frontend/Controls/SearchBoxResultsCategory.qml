import QtQuick 2.7
import QtQuick.Layouts 1.2

Rectangle {
    // A category section
    id: searchResultsCategory

    property string text: "Category"

    width: parent.width
    implicitHeight: textLabelId.implicitHeight + searhResultsCategoryRowLayoutId.implicitHeight

    color: "transparent"
    visible: false

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

    function filterResult(textToSearch) {
        //traverse results and set to visible
        var isAnyChildVisible = false
        for (var i = 0; i < searhResultsCategoryRowLayoutId.children.length; i++) {
            var visibleChild = searhResultsCategoryRowLayoutId.children[i].filterResult(
                        textToSearch)

            if (visibleChild) {
                isAnyChildVisible = true
            }
        }

        // show category only if at least an item is visible
        visible = isAnyChildVisible
        return visible
    }

    // Results is content of category (can be added as children)
    default property alias children: searhResultsCategoryRowLayoutId.children

    Column {
        id: searhResultsCategoryRowLayoutId

        anchors.top: textLabelId.bottom
        width: parent.width
        height: Column.height

        spacing: 1
    }
}
