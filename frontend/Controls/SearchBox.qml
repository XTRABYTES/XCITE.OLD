/**
 * Filename: SearchBox.qml
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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import "../Controls" as Controls

import "../Theme" 1.0

Item {
    id: searchBoxWithResults

    property alias text: searchField.text
    property alias placeholder: searchField.placeholderText

    z: 50

    Rectangle {
        id: searchBoxId
        anchors.fill: parent
        color: Theme.panelBackground

        signal buttonClicked

        TextField {
            id: searchField
            width: parent.width - searchButtonContainer.width
            topPadding: 16
            leftPadding: 8
            rightPadding: 8
            font.pixelSize: 16
            color: "#7B7D82"
            background: Rectangle {
                color: "transparent"
            }
            selectByMouse: true

            function showSearchResults() {
                var showResults = searchField.text.length > 0
                        && searchField.focus && searchField.activeFocus
                        && searchField.focus

                searchResultsBox.visible = showResults
                searchResultsBox.text = showResults ? searchField.text : ""
            }

            onTextChanged: function () {
                showSearchResults()
            }

            onFocusChanged: {
                showSearchResults()
            }

            onEditingFinished: {
                showSearchResults()
            }
        }

        Item {
            id: searchButtonContainer
            width: 30
            height: parent.height
            anchors.top: parent.top
            anchors.right: parent.right

            Controls.ButtonIcon {
                id: searchButton
                imageSource: "../icons/search.svg"

                size: 20
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                isSelected: false
                changeColorOnClick: false
                onButtonClicked: {
                    searchBoxId.buttonClicked()
                }
            }
        }
    }

    SearchBoxResults {
        id: searchResultsBox
        z: 51
    }
}
