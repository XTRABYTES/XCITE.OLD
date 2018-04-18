import QtQuick 2.7
import QtQuick.Controls 2.3

Text {
    text: "v" + AppVersion
    color: "white"
    font.pixelSize: 12
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    anchors.bottomMargin: 10
    anchors.rightMargin: 10
}
