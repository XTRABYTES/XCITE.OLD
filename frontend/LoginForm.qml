import QtQuick 2.0

PolygonalBackground {
    id: loginFormRoot

    Column {
        id: column
        anchors.centerIn: parent
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
          placeholder: qsTr("john@email.com")
        }

        BlueTextInput {
          anchors.horizontalCenter: parent.horizontalCenter
          placeholder: "**********"
          echoMode: TextInput.Password
        }

        SimpleButton {
            text: qsTr("Login")
            backgroundColor: "transparent"
            hoverBackgroundColor: "#1A10B9C5"
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.push("TwoFactorAuthForm.qml")
            }
        }

        PlainTextButton {
            text: qsTr("Forgot password?")
            opacity: 0.9
            fontPointSize: 10
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.push("ForgotPasswordForm.qml")
            }
        }

        PlainTextButton {
            text: qsTr("Don't have an account? Sign Up!")
            opacity: 0.8
            fontPointSize: 10
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.push("SignUpForm.qml")
            }
        }
    }
}
