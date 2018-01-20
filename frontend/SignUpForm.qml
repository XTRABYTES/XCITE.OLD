import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.3

PolygonalBackground {
    id: root

    Column {
        id: column
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 40
        spacing: 40
        Logo {
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            font.family: "Roboto Thin"
            text: qsTr("XCITE")
            font.pointSize: 30
            color: "#10B9C5"
            anchors.horizontalCenter: parent.horizontalCenter
            font.weight: Font.Thin
        }

        BlueTextInput {
          anchors.horizontalCenter: parent.horizontalCenter
          placeholder: qsTr("username")
        }

        BlueTextInput {
          anchors.horizontalCenter: parent.horizontalCenter
          placeholder: qsTr("e-mail")
        }

        BlueTextInput {
          anchors.horizontalCenter: parent.horizontalCenter
          placeholder: qsTr("choose password")
          echoMode: TextInput.Password
        }

        CheckBox {
            style: CheckBoxStyle {
                        label: Text {
                            color: "white"
                            text: qsTr("I agree to the terms and conditions")
                        }
                    }
        }

        SimpleButton {
            text: qsTr("Sign Up")
            backgroundColor: "#10B9C4"
            hoverBackgroundColor: "#31d3de"
            foregroundColor: "#273A3B"
            hoverForegroundColor: "#273A3B"
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.replace("DashboardForm.qml")
            }
        }

        PlainTextButton {
            anchors.horizontalCenter: parent.horizontalCenter
            width: (alreadyMemberText.width + loginText.width)
            onButtonClicked: {
                mainRoot.push("LoginForm.qml")
            }

            RowLayout {
                anchors.centerIn: parent

                Text {
                    id: alreadyMemberText
                    text: qsTr("Already a member?")
                    font.family: "Roboto Thin"
                    font.pointSize: 10
                    color: "#FFFFFF"
                    opacity: 0.8
                }

                Text {
                    id: loginText
                    text: qsTr("Login!")
                    font.family: "Roboto Thin"
                    font.pointSize: 10
                    color: "#28D4E0"
                    opacity: 0.8
                }
            }
        }
    }
}
