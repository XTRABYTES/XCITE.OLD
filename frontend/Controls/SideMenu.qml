import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Rectangle {
    property var selected: xBoardHome

    id: menu
    color: "#3A3E47"

    Layout.fillHeight: true
    Layout.minimumWidth: sideMenuWidth
    Layout.preferredWidth: sideMenuWidth
    Layout.maximumWidth: sideMenuWidth

    ColumnLayout {
        Layout.fillHeight: true
        anchors.left: parent.left
        anchors.right: parent.right

        spacing: 25

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
            Layout.topMargin: 10
            module: xBoardHome
            imageSource: "../icons/menu-home.svg"
            labelText: qsTr("HOME")
            size: 32
        }

        SideMenuButton {
            module: xBoardSendCoins
            imageSource: "../icons/menu-sendcoins.svg"
            labelText: qsTr("SEND COINS")
            imageOffsetX: -6
            size: 25

            // Force the label to wrap
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            // ButtonDiode height uses childrenRect.height to size itself, but this seems incorrect if the text wraps, adjust to compensate
            height: 65
        }

        SideMenuButton {
            module: xBoardReceiveCoins
            imageSource: "../icons/menu-receivecoins.svg"
            labelText: qsTr("RECEIVE COINS")
            imageOffsetX: 5
            size: 25

            // Force the label to wrap
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            // ButtonDiode height uses childrenRect.height to size itself, but this seems incorrect if the text wraps, adjust to compensate
            height: 65
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
            size: 30
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
