/**
 * Filename: SearchBoxResultsCategoryItem.qml
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
import "../Theme" 1.0

Item {
    id: searchResultCategoryId

    implicitHeight: textLabelId.height
    implicitWidth: parent.width

    property string defaultColor: "white"
    property string hoveringColor: Theme.primaryHighlight

    function filterResult(textToSearch) {
        var isVisible = text.toLowerCase().indexOf(textToSearch) !== -1
                || tags.indexOf(textToSearch) !== -1

        searchResultCategoryId.visible = isVisible
        return isVisible
    }

    // Intended to be overwritten
    property string text
    // text can be any case, search is indiferent
    property string tags
    // tags must be lower case, divided by space
    function onSearchResultClicked() {}

    Text {
        id: textLabelId

        topPadding: 6
        leftPadding: 20
        bottomPadding: 6

        text: searchResultCategoryId.text
        font.family: "Roboto bold"
        font.pointSize: 11
        color: defaultColor
    }

    state: "default"

    MouseArea {
        anchors.fill: searchResultCategoryId
        onClicked: {
            searchResultCategoryId.onSearchResultClicked()
        }

        hoverEnabled: true
        onHoveredChanged: containsMouse ? searchResultCategoryId.state
                                          = "Hovering" : searchResultCategoryId.state = "Default"
    }

    // Hovering animations
    Behavior on scale {
        NumberAnimation {
            duration: 150
            easing.type: Easing.InOutQuad
        }
    }

    states: [
        State {
            name: "Hovering"
            PropertyChanges {
                target: textLabelId
                color: hoveringColor
            }
        },
        State {
            name: "Default"
            PropertyChanges {
                target: textLabelId
                color: defaultColor
            }
        }
    ]

    transitions: [
        Transition {
            from: "Default"
            to: "Hovering"
            ColorAnimation {
                duration: 150
            }
        },
        Transition {
            from: "Hovering"
            to: "Default"
            ColorAnimation {
                duration: 300
            }
        }
    ]
}
