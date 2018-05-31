/**
 * Filename: SearchBoxResultsCategory.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
import QtQuick 2.7
import QtQuick.Layouts 1.2

Rectangle {
    // A category section
    id: searchResultsCategory

    property string text: "Category"

    width: parent.width
    implicitHeight: textLabelId.implicitHeight + searchResultsCategoryRowLayoutId.implicitHeight

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
        font.pointSize: 13
    }

    function filterResult(textToSearch) {
        // traverse results and set to visible
        var isAnyChildVisible = false
        var visibleChildrenCount = 0
        for (var i = 0; i < searchResultsCategoryRowLayoutId.children.length; i++) {
            var visibleChild = searchResultsCategoryRowLayoutId.children[i].filterResult(
                        textToSearch)

            if (visibleChild) {
                isAnyChildVisible = true
                visibleChildrenCount += 1
            }
        }

        // show category only if at least an item is visible
        visible = isAnyChildVisible
        return visibleChildrenCount
    }

    // Results is content of category (can be added as children)
    default property alias children: searchResultsCategoryRowLayoutId.children

    Column {
        id: searchResultsCategoryRowLayoutId

        anchors.top: textLabelId.bottom
        width: parent.width
        height: Column.height

        spacing: 1
    }
}
