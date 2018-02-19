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
                            && searchField.activeFocus
                }

                onTextChanged: function () {
                    searchResultsBox.visible = showSearchResults()
                }

                onFocusChanged: {
                    searchResultsBox.visible = showSearchResults()
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
}
