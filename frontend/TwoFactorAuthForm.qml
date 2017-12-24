import QtQuick 2.0

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

        Text {
            font.family: "Roboto Thin"
            text: "Enter your verification code"
            font.pointSize: 10
            color: "#FFFFFF"
            opacity: 0.9
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BlueTextInput {
          anchors.horizontalCenter: parent.horizontalCenter
          placeholder: "******"
          echoMode: TextInput.Password
        }

        SimpleButton {
            text: "Verify"
            backgroundColor: "transparent"
            hoverBackgroundColor: "#1A10B9C5"
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.replace("DashboardForm.qml")
            }
        }

        PlainTextButton {
            text: "Use another account? Go Back!"
            opacity: 0.8
            fontPointSize: 10
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.push("LoginForm.qml")
            }
        }
    }
}
