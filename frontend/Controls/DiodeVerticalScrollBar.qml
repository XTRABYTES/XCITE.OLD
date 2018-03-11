import QtQuick 2.7
import QtQuick.Controls 2.3

import "../Theme" 1.0

ScrollBar {
    id: verticalScrollBar
    policy: ScrollBar.AsNeeded
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.right
    anchors.leftMargin: 3

    width: 6

    contentItem: Rectangle {
        radius: 4
        color: Theme.secondaryHighlight
    }
}
