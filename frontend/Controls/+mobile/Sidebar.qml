import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2

Rectangle {
    id: sidebar
    height: parent.height
    width: 100
    color: "#2A2C31"
    visible: appsTracker == 1
    z: 100

    Image {
        id: settings
        anchors.bottom: sidebar.bottom
        anchors.bottomMargin: 25
        anchors.horizontalCenter: sidebar.horizontalCenter
        source: '../icons/icon-settings.svg'
        width: 35
        height: 35
        z: 100
        visible: appsTracker == 1
        MouseArea {
            anchors.fill: settings
            onClicked: {
                mainRoot.push("Settings.qml")
                appsTracker = 0
            }
        }
        ColorOverlay {
            anchors.fill: settings
            source: settings
            color: "#5E8BFF"
        }
    }

    Rectangle{
        width: xchangeText.width + 5
        height: 2
        color: "#7F7F7F"
        anchors.bottom: settings.top
        anchors.bottomMargin: 25
        anchors.horizontalCenter: xchangeLink.horizontalCenter
        visible: appsTracker == 1
        z: 100
    }

    Image {
        id: xchangeLink
        source: '../icons/XCHANGE_02.svg'
        anchors.bottom: settings.top
        anchors.bottomMargin: 75
        anchors.horizontalCenter: sidebar.horizontalCenter
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        ColorOverlay {
            anchors.fill: xchangeLink
            source: xchangeLink
            color: "#5E8BFF" // make image like it lays under grey glass
        }
        Text {
            id: xchangeText
            text: "X-CHANGE"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }
        Rectangle {
            id: xchangeButtonArea
            width: xchangeLink.width
            height: xchangeLink.height
            anchors.left: xchangeLink.left
            anchors.bottom: xchangeLink.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: xchangeButtonArea
                onClicked: mainRoot.push("../xchange.qml")
            }
        }
    }

    Image {
        id: xvaultLink
        source: '../icons/XVAULT_02.svg'
        anchors.bottom: xchangeLink.top
        anchors.bottomMargin: 50
        anchors.horizontalCenter: sidebar.horizontalCenter
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        ColorOverlay {
            anchors.fill: xvaultLink
            source: xvaultLink
            color: "#5E8BFF"
        }
        Text {
            text: "X-VAULT"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }
    }

    Image {
        id: xchatLink
        source: '../icons/XCHAT_02.svg'
        anchors.bottom: xvaultLink.top
        anchors.bottomMargin: 50
        anchors.horizontalCenter: sidebar.horizontalCenter
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        ColorOverlay {
            anchors.fill: xchatLink
            source: xchatLink
            color: "#5E8BFF"
        }
        Text {
            text: "X-CHAT"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }
    }
    Rectangle {
        anchors.left: parent.right
        width: appsTracker == 1 ? (Screen.width - parent.width) : 0
        height: parent.height
        color: "transparent"

        MouseArea {
            anchors.fill: parent

            onClicked: {
                appsTracker = 0
            }
        }
    }
}
