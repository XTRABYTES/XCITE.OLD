import QtQuick 2.0
import QtQuick.Controls 2.2

Label {
    font.pixelSize: 19
    font.family: "Roboto"
    font.weight: Font.Light
    text: qsTr("Amount")
    color: "#E3E3E3"
    height: 45

    //Blue Rectangle located underneath the text
    Rectangle {
        x: 0
        y: 30.29
        height: 1
        width: parent.width
        color: "#24B9C3"
    }
}
