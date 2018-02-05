import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Rectangle {
    property var selected: xBoardHome

    id: menu
    color: "#3A3E47"

    Layout.fillHeight: true
    Layout.minimumWidth: 90
    Layout.preferredWidth: 90
    Layout.maximumWidth: 90

    ColumnLayout {
        Layout.fillHeight: true
        anchors.left: parent.left
        anchors.right: parent.right

        spacing: 40

        ButtonDiode {
            id: logobutton
            imageSource: "../logos/xby_logo.svg"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.topMargin: 15
            isSelected: true
            cursorShape: Qt.ArrowCursor
            hoverEnabled: false
            size: 40
        }

        SideMenuButton {
            module: xBoardHome
            imageSource: "../icons/menu-home.svg"
            labelText: qsTr("HOME")
            size: 38
        }

        SideMenuButton {
            module: xBoardSendCoins
            // TODO: Waiting on new icon for this
            imageSource: "../icons/menu-transfers.svg"
            labelText: qsTr("SEND COINS")
            size: 35

            // Force the label to wrap
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            // ButtonDiode height uses childrenRect.height to size itself, but this seems incorrect if the text wraps, adjust to compensate
            height: 75
        }

        SideMenuButton {
            module: xBoardReceiveCoins
            // TODO: Waiting on new icon for this
            imageSource: "../icons/menu-transfers.svg"
            labelText: qsTr("RECEIVE COINS")
            size: 35

            // Force the label to wrap
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            // ButtonDiode height uses childrenRect.height to size itself, but this seems incorrect if the text wraps, adjust to compensate
            height: 75
        }

        SideMenuButton {
            imageSource: "../icons/menu-history.svg"
            module: xBoardHistory
            labelText: qsTr("HISTORY")
            size: 28
        }

        SideMenuButton {
            imageSource: "../icons/share.svg"
            module: xBoardNodes
            labelText: qsTr("NODES")
            size: 35
        }
    }

    ColumnLayout {
        width: parent.width
        Layout.fillHeight: true
        Layout.minimumHeight: 200
        Layout.preferredHeight: 200
        anchors.bottomMargin: 32.5
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        spacing: 25

        SideMenuButton {
            imageSource: "../icons/menu-settings.svg"
            module: moduleSettings
            labelText: qsTr("SETTINGS")
            size: 32
        }

        ButtonDiode {
            id: wifiButton
            imageSource: "../icons/wifi.svg"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            isSelected: xcite.isNetworkActive
            labelText: xcite.isNetworkActive ? qsTr("ONLINE") : qsTr("OFFLINE")
            onButtonClicked: {
                xcite.isNetworkActive = !xcite.isNetworkActive;
            }
        }

        Switch {
            id: killSwitch
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            checked: true
            padding: 0
        }
    }
}
