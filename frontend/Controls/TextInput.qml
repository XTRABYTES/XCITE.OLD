import QtQuick 2.7
import QtQuick.Controls 2.3
import "../Theme" 1.0

TextField {
    id: component
    color: "white"
    font.weight: Font.Light
    font.pixelSize: 24
    leftPadding: 18
    rightPadding: 18
    topPadding: 10
    bottomPadding: 10
    verticalAlignment: Text.AlignVCenter
    selectByMouse: true

    background: Rectangle {
        color: "#2A2C31"
        radius: 4
        border.width: parent.activeFocus ? 2 : 0
        border.color: Theme.secondaryHighlight
    }

    onActiveFocusChanged: {
        if (component.focus) {
            EventFilter.focus(this)
        }
    }
}
