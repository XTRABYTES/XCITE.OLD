import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "../Controls" as Controls

Item {
    id: searchBoxWithResults

    property alias text: searchField.text
    property alias placeholder: searchField.placeholderText

    anchors.verticalCenter: parent.Center
    Layout.fillWidth: true
    Layout.maximumWidth: 367
    Layout.minimumWidth: 367
    Layout.preferredWidth: 367

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.topMargin: 13

    z: 50

    Rectangle {
        id: searchBoxId

        width: parent.width
        height: 44
        radius: 5

        color: "#3A3E46"

        signal buttonClicked

        Rectangle {
            id: searchFieldContainer
            Layout.fillWidth: true
            height: 44
            width: 367
            color: "transparent"
            anchors.top: parent.top
            anchors.left: parent.left
            radius: 5

            TextField {
                id: searchField
                height: parent.height
                width: 220
                y: 0

                font.pointSize: 14
                font.family: "Roboto"
                placeholderText: placeholder
                anchors.left: parent.left
                anchors.leftMargin: 15
                style: TextFieldStyle {
                    textColor: "#7B7D82"
                    placeholderTextColor: "#7B7D82"
                    background: Rectangle {
                        color: "transparent"
                    }
                }

                function showSearchResults() {
                    return searchField.text.length > 0 && searchField.focus
                            && searchField.activeFocus && searchField.focus
                }

                onTextChanged: function () {
                    searchResultsBox.visible = showSearchResults()
                }

                onFocusChanged: {
                    searchResultsBox.visible = showSearchResults()
                }

                onEditingFinished: {
                    searchResultsBox.visible = false
                }
            }

            /*
        MouseArea {
            id: searchFieldMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: {
                if (containsMouse) {
                    root.color= "#454951"
                }
                else {
                    root.color= "#3A3E46"
                }
            }
        }
        */
        }

        Rectangle {
            id: searchButtonContainer
            width: 30
            height: parent.height
            color: "transparent"
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
    }
}
