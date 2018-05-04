import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

import "../Theme" 1.0

TextField {
    id: component
    color: "black"
    font.weight: Font.Light
    font.pixelSize: 24
    leftPadding: 18
    rightPadding: 18
    topPadding: 10
    bottomPadding: 10
    verticalAlignment: Text.AlignVCenter
    selectByMouse: true

    background: Rectangle {
        color: "white"
        radius: 4
        border.width: parent.activeFocus ? 2 : 0
        border.color: Theme.secondaryHighlight
        implicitWidth: Screen.width - 20
    }

    onActiveFocusChanged: {
        if (component.focus) {
            EventFilter.focus(this)
        }
    }
}
