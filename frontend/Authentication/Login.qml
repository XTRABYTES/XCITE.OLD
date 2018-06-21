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

    Component.onCompleted: {
        usernameTextInput.forceActiveFocus()
    }

    function submitForm() {
        network.userLogin(usernameTextInput.text, passwordTextInput.text,
                          function (err, user) {
                              if (err) {
                                  return modalAlert({
                                                        title: qsTr("ERROR!"),
                                                        bodyText: qsTr(err.message),
                                                        buttonText: qsTr("OK")
                                                    })
                              }

                              mainRoot.push("../DashboardForm.qml")
                          })
    }

    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.topMargin: 50
        font.pixelSize: 28
        font.weight: Font.Medium
        color: "white"
        text: qsTr("Login to your account")
    }

    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
        color: "white"
        lineHeight: 1.25
        text: qsTr("Use your username/password to login.")
    }

    Controls.DiodeIcon {
        Layout.fillWidth: true
        Layout.minimumWidth: 800
        Layout.preferredWidth: 800
        Layout.maximumWidth: 800
        Layout.minimumHeight: 400
        anchors.horizontalCenter: parent.horizontalCenter
        imageSource: "../icons/icon-padlock-locked.svg"

        ColumnLayout {
            anchors.top: parent.top
            anchors.topMargin: 100
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            spacing: 10

            Label {
                text: qsTr("Username")
                color: "#FFF7F7"
                font.pixelSize: 18
            }

            Controls.TextInput {
                id: usernameTextInput
                Layout.fillWidth: true
                onAccepted: submitForm()
            }

            Label {
                text: qsTr("Password")
                color: "#FFF7F7"
                font.pixelSize: 18
            }

            Controls.TextInput {
                id: passwordTextInput
                echoMode: TextInput.Password
                Layout.fillWidth: true
                onAccepted: submitForm()
            }

            Controls.ButtonModal {
                labelText: "CONTINUE"
                Layout.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                buttonHeight: 60
                Layout.fillWidth: true
                Layout.maximumWidth: 330
                isPrimary: true
                onButtonClicked: submitForm()
            }
        }
    }

    // Row with 2 action buttons
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
