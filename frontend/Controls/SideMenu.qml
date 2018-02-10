import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Rectangle {
    property string selectedView
    property string selectedModule

    Connections {
        target: dashboard
        onSelectView: {
            var parts = path.split('.')

            selectedModule = parts[0]
            selectedView = path
        }
    }

    Layout.fillHeight: true
    Layout.minimumWidth: sideMenuWidth
    Layout.preferredWidth: sideMenuWidth
    Layout.maximumWidth: sideMenuWidth
    color: "#3A3E47"

    ColumnLayout {
        Layout.fillHeight: true
        anchors.left: parent.left
        anchors.right: parent.right

        spacing: 25

        ButtonIcon {
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
            name: "xBoard.home"
            visible: selectedModule === 'xBoard'
            Layout.topMargin: 10
            imageSource: "../icons/menu-home.svg"
            labelText: qsTr("HOME")
            size: 32
        }

        SideMenuButton {
            name: "xBoard.sendCoins"
            visible: selectedModule === 'xBoard'
            imageSource: "../icons/menu-sendcoins.svg"
            labelText: qsTr("SEND COINS")
            imageOffsetX: -6
            size: 25

            // Force the label to wrap
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            // ButtonIcon height uses childrenRect.height to size itself, but this seems incorrect if the text wraps, adjust to compensate
            height: 65
        }

        SideMenuButton {
            name: "xBoard.receiveCoins"
            visible: selectedModule === 'xBoard'
            imageSource: "../icons/menu-receivecoins.svg"
            labelText: qsTr("RECEIVE COINS")
            imageOffsetX: 5
            size: 25

            // Force the label to wrap
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            // ButtonIcon height uses childrenRect.height to size itself, but this seems incorrect if the text wraps, adjust to compensate
            height: 65
        }

        SideMenuButton {
            name: "xBoard.history"
            visible: selectedModule === 'xBoard'
            imageSource: "../icons/menu-history.svg"
            labelText: qsTr("HISTORY")
            size: 28
        }

        SideMenuButton {
            name: "xBoard.nodes"
            visible: selectedModule === 'xBoard'
            imageSource: "../icons/share.svg"
            labelText: qsTr("NODES")
            size: 30
        }

        SideMenuButton {
            name: "xChange.home"
            visible: selectedModule === 'xChange'
            Layout.topMargin: 10
            imageSource: "../icons/menu-home.svg"
            labelText: qsTr("HOME")
            size: 32
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
            name: "xBoard.settings"
            imageSource: "../icons/menu-settings.svg"
            labelText: qsTr("SETTINGS")
            size: 32
        }

        ButtonIcon {
            id: wifiButton
            imageSource: "../icons/wifi.svg"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            isSelected: xcite.isNetworkActive
            labelText: xcite.isNetworkActive ? qsTr("ONLINE") : qsTr("OFFLINE")
            onButtonClicked: {
                xcite.isNetworkActive = !xcite.isNetworkActive
            }
        }

        Switch {
            id: killSwitch
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            checked: true
            padding: 0
            onClicked: {
                var title = killSwitch.checked ? qsTr("ACTIVATE?") : qsTr(
                                                     "DEACTIVATE?")
                confirmationModal({
                                      title: title,
                                      text: qsTr("Are you sure?"),
                                      confirmText: qsTr("YES"),
                                      cancelText: qsTr("NO")
                                  }, null, function (modal) {
                                      killSwitch.checked = !killSwitch.checked
                                  })
            }
        }
    }
}
