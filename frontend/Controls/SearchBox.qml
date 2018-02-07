import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "../Controls" as Controls

Rectangle {
    id: root
    anchors.verticalCenter: parent.Center
    Layout.fillWidth: true
    Layout.maximumWidth: 367
    Layout.minimumWidth: 367
    Layout.preferredWidth: 367
    height: 44
    color: "#3A3E46"
    radius: 5

    property alias text: searchField.text
    property alias placeholder: searchField.placeholderText
    signal buttonClicked

    Rectangle {
        id: searchFieldContainer
        Layout.fillWidth: true
        height: 44
        width:367
        color: "transparent"
        anchors.top: parent.top
        anchors.left: parent.left
        radius: 5

        TextField {
            id: searchField
            height: parent.height
            width: 220
            y:0

            font.pointSize: 14
            font.family: "Roboto"
            placeholderText: placeholder
            anchors.left: parent.left
            anchors.leftMargin:15
            style: TextFieldStyle {
                textColor: "#7B7D82"
                placeholderTextColor: "#7B7D82"
                background: Rectangle {
                    color: "transparent"
                }
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

        Controls.ButtonDiode {
            id: searchButton
            imageSource: "../icons/search.svg"

            size: 20
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            isSelected: false
            changeColorOnClick: false
            onButtonClicked: {
                root.buttonClicked()
            }
        }
    }
}
