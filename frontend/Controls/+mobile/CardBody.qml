import QtQuick 2.0
import QtGraphicalEffects 1.0


Rectangle {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    width: parent.width
    height: parent.height
    color: "transparent"

    Rectangle {
        id: cardBody
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height
        color: darktheme == true? "#14161B" : "#FDFDFD"
        opacity: 0.05

        LinearGradient {
            anchors.fill: parent
            source: parent
            start: Qt.point(x, y)
            end: Qt.point(x, parent.height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: darktheme == true? "#FF0ED8D2" : "#000ED8D2"}
                GradientStop { position: 1.0; color: darktheme == true? "#000ED8D2" : "#FF0ED8D2"}
            }
        }
    }

    Rectangle {
        anchors.horizontalCenter: cardBody.horizontalCenter
        anchors.bottom: cardBody.bottom
        width: cardBody.width
        height: 1
        color: darktheme == true? "black" : "white"
        opacity: 0.25
    }
}
