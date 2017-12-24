import QtQuick 2.0

PolygonalBackground {
    id: loginFormRoot
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
          placeholder: "john@email.com"
        }

        BlueTextInput {
          anchors.horizontalCenter: parent.horizontalCenter
          placeholder: "**********"
          echoMode: TextInput.Password
        }

        SimpleButton {
            text: "Login"
            backgroundColor: "transparent"
            hoverBackgroundColor: "#1A10B9C5"
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.push("TwoFactorAuthForm.qml")
            }
        }

        PlainTextButton {
            text: "Forgot password?"
            opacity: 0.9
            fontPointSize: 10
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.push("ForgotPasswordForm.qml")
            }
        }

        PlainTextButton {
            text: "Don't have an account? Sign Up!"
            opacity: 0.8
            fontPointSize: 10
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.push("SignUpForm.qml")
            }
        }
    }
}
