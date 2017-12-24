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
            text: "Enter your email and we'll send you a reset link."
            font.pointSize: 10
            color: "#FFFFFF"
            opacity: 0.9
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BlueTextInput {
          anchors.horizontalCenter: parent.horizontalCenter
          placeholder: "john@email.com"
        }

        SimpleButton {
            text: "Send Link"
            backgroundColor: "transparent"
            hoverBackgroundColor: "#1A10B9C5"
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.replace("LoginForm.qml")
            }
        }

        PlainTextButton {
            text: "Remembered your password? Go Back!"
            opacity: 0.8
            fontPointSize: 10
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                mainRoot.push("LoginForm.qml")
            }
        }
    }
}
