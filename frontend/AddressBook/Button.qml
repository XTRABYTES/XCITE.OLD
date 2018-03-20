import QtQuick 2.7
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import "../Theme" 1.0

Label {
    id: root

    property alias icon: icon
    property color hoverTextColor: Theme.primaryHighlight
    property color textColor: "#A9ADAA"

    signal buttonClicked

    wrapMode: Text.WordWrap
    color: textColor

    horizontalAlignment: Text.AlignHCenter
    font.pixelSize: 12
    topPadding: 26
    leftPadding: 10
    rightPadding: 10

    Image {
        id: icon
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ColorOverlay {
        anchors.fill: icon
        source: icon
        color: root.color
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onClicked: {
            root.buttonClicked()
        }

        onHoveredChanged: {
            if (containsMouse) {
                root.color = hoverTextColor
            } else {
                root.color = textColor
            }
        }
    }
}
