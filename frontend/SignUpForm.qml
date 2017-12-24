import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.0

PolygonalBackground {
    id: root
    anchors.fill: parent
    anchors.centerIn: parent

    Column {
        id: column
        anchors.centerIn: parent
        spacing: 40
        Logo {
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            font.family: "Roboto Thin"
            text: "XCITE"
            font.pointSize: 30
            color: "#10B9C5"
            anchors.horizontalCenter: parent.horizontalCenter
            font.weight: Font.Thin
        }

        BlueTextInput {
          anchors.horizontalCenter: parent.horizontalCenter
          placeholder: "username"
        }

        BlueTextInput {
          anchors.horizontalCenter: parent.horizontalCenter
          placeholder: "e-mail"
        }

        BlueTextInput {
          anchors.horizontalCenter: parent.horizontalCenter
          placeholder: "choose password"
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
            text: "Sign Up"
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
            text: "Already a member? Go Back!"
            opacity: 0.8
            fontPointSize: 10
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.push("LoginForm.qml")
            }
        }
    }
}
