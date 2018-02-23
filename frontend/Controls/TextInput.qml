import QtQuick 2.0
import QtQuick.Controls 2.2

TextField {
    color: "white"
    font.family: "Roboto"
    font.weight: Font.Light
    font.pixelSize: 36
    leftPadding: 18
    topPadding: 0
    bottomPadding: 0
    verticalAlignment: Text.AlignVCenter
    selectByMouse: true

    background: Rectangle {
        color: "#2A2C31"
        radius: 4
    }
}
