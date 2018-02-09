import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../Controls" as Controls
import "../Login" as LoginComponents

Controls.ImagePolygonal {
    id: root

    Column {
        id: column
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 40
        spacing: 40

        Controls.ImageLogo {
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

        Text {
            font.family: "Roboto Thin"
            text: qsTr("Enter your verification code")
            font.pointSize: 10
            color: "#FFFFFF"
            opacity: 0.9
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Controls.TextInputBlue {
          anchors.horizontalCenter: parent.horizontalCenter
          placeholder: "******"
          echoMode: TextInput.Password
        }

        Controls.ButtonSimple {
            text: qsTr("Verify")
            backgroundColor: "transparent"
            hoverBackgroundColor: "#1A10B9C5"
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                rootLoader.source = "../DashboardForm.qml"
            }
        }

        Controls.ButtonPlainText {
            anchors.horizontalCenter: parent.horizontalCenter
            width: (anotherAccountText.width + goBackText.width)
            onButtonClicked: {
                rootLoader.source = "LoginForm.qml"
            }

            RowLayout {
                anchors.centerIn: parent

                Text {
                    id: anotherAccountText
                    text: qsTr("Use another account?")
                    font.family: "Roboto Thin"
                    font.pointSize: 10
                    color: "#FFFFFF"
                    opacity: 0.8
                }

                Text {
                    id: goBackText
                    text: qsTr("Go Back!")
                    font.family: "Roboto Thin"
                    font.pointSize: 10
                    color: "#28D4E0"
                    opacity: 0.8
                }
            }
        }
    }
}
