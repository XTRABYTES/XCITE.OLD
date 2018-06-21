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
        text: qsTr("Create my account")
    }

    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
        color: "white"
        lineHeight: 1.25
        text: qsTr("Setup an account with a new username / password.")
    }

    Controls.DiodeIcon {
        Layout.fillWidth: true
        Layout.minimumWidth: 800
        Layout.preferredWidth: 800
        Layout.maximumWidth: 800
        Layout.minimumHeight: 550
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

            Label {
                text: qsTr("This is your new username. You will need it to log in.")
                color: "#FFF7F7"
                font.pixelSize: 14
            }

            Controls.TextInput {
                id: usernameTextInput
            }

            Label {
                text: qsTr("Password")
                color: "#FFF7F7"
                font.pixelSize: 18
            }

            Label {
                text: qsTr("Must be 10 characters long and include: one upper case, one lower case, one number and one special character.")
                color: "#FFF7F7"
                font.pixelSize: 14
            }

            Controls.TextInput {
                id: passwordTextInput
                echoMode: TextInput.Password
            }

            Label {
                text: qsTr("Verify Password")
                color: "#FFF7F7"
                font.pixelSize: 18
            }

            Controls.TextInput {
                id: verifyPasswordTextInput
                echoMode: TextInput.Password
            }

            RowLayout {
                Layout.topMargin: 40
                spacing: 40

                Controls.ButtonModal {
                    labelText: "I already have an account"
                    buttonHeight: 60
                    Layout.fillWidth: true
                    isTransparent: true
                    onButtonClicked: {
                        mainRoot.push("Login.qml")
                    }
                }

                Controls.ButtonModal {
                    labelText: "CONTINUE"
                    buttonHeight: 60
                    Layout.fillWidth: true
                    isPrimary: true
                    onButtonClicked: {
                        if (usernameTextInput.text.trim().length == 0) {
                            return modalAlert({
                                                  title: qsTr("ERROR!"),
                                                  bodyText: qsTr("Username is required"),
                                                  buttonText: qsTr("OK")
                                              })
                        }

                        if (passwordTextInput.text.trim().length < 10) {
                            return modalAlert({
                                                  title: qsTr("ERROR!"),
                                                  bodyText: qsTr("Password must be at least 10 characters"),
                                                  buttonText: qsTr("OK")
                                              })
                        }

                        if (passwordTextInput.text != verifyPasswordTextInput.text) {
                            return modalAlert({
                                                  title: qsTr("ERROR!"),
                                                  bodyText: qsTr("Passwords don't match"),
                                                  buttonText: qsTr("OK")
                                              })
                        }

                        network.userCreate(usernameTextInput.text,
                                           passwordTextInput.text,
                                           function (err, user) {
                                               if (err) {
                                                   return modalAlert({
                                                                         title: qsTr("ERROR!"),
                                                                         bodyText: qsTr(
                                                                                       err.message),
                                                                         buttonText: qsTr("OK")
                                                                     })
                                               }

                                               mainRoot.push(
                                                           "../DashboardForm.qml")
                                           })
                    }
                }
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
