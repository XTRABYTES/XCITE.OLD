import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "../Controls" as Controls
import "../Theme" 1.0

ColumnLayout {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    spacing: 40

    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.topMargin: 50
        font.pixelSize: 28
        font.weight: Font.Medium
        color: "white"
        text: qsTr("Getting Started")
    }

    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
        color: "white"
        lineHeight: 1.25
        text: qsTr("In order to protect your personal information, XCITE is only accessible via username/password.\nWe DO NOT connect any email accounts to the information in your account. ")
    }

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 40

        Controls.DiodeIcon {
            title: qsTr("Create my account")
            Layout.fillWidth: true
            Layout.minimumWidth: 450
            Layout.preferredWidth: 450
            Layout.maximumWidth: 450
            Layout.minimumHeight: 250
            imageSource: "../icons/icon-padlock-locked.svg"
            isButton: true
            onButtonClicked: {
                mainRoot.push("CreateAccount.qml")
            }

            Label {
                font.pixelSize: 16
                color: "white"
                Layout.maximumWidth: (parent.width - 10)
                width: parent.width
                wrapMode: Text.WordWrap
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                lineHeight: 1.25
                text: qsTr("Setup an account with a new username / password.")
            }
        }

        Controls.DiodeIcon {
            title: qsTr("I already have an account")
            Layout.fillWidth: true
            Layout.minimumWidth: 450
            Layout.preferredWidth: 450
            Layout.maximumWidth: 450
            Layout.minimumHeight: 250
            imageSource: "../icons/icon-padlock-unlocked.svg"
            isButton: true
            onButtonClicked: {
                mainRoot.push("Login.qml")
            }

            Label {
                font.pixelSize: 16
                color: "white"
                Layout.maximumWidth: (parent.width - 10)
                wrapMode: Text.WordWrap
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                lineHeight: 1.25
                text: qsTr("Log in if you have already created an account.")
            }
        }
    }

    Transition {
        id: fadeInTransition
        PropertyAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 200
        }
    }

    Transition {
        id: fadeOutTransition
        PropertyAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: 200
        }
    }
}
