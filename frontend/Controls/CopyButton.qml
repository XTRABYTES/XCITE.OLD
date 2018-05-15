import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Label {
    id: copyPasteButton

    readonly property string defaultText: qsTr("Copy to clipboard")
    readonly property string altText: qsTr("Address copied!")
    readonly property string defaultIcon: "../../icons/copy-clipboard.svg"
    readonly property string altIcon: "../../icons/circle-cross.svg"
    property bool isActive: false
    property int copyTracker: 1
    font.pixelSize: 12
    font.weight: isActive ? Font.Bold : Font.Normal
    text: {
        if (isActive == true && copyTracker == 1)
            altText
        if (isActive == false && copyTracker == 1)
            defaultText
        if (copyTracker == 0)
            ""
    }
    color: isActive ? "#ffffff" : "#E3E3E3"
    leftPadding: 24

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            copyTextTimer.start()
            clipboard.text = formAddress.text
            parent.isActive = true
        }
    }

    Image {
        id: copyImage
        fillMode: Image.PreserveAspectFit
        source: parent.isActive ? parent.altIcon : parent.defaultIcon
        width: 25
        sourceSize.width: 15
        sourceSize.height: 13
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: parent.Center
        anchors.rightMargin: 5

        Timer {
            id: copyTextTimer
            interval: 1500
            running: false
            repeat: false
            onTriggered: copyPasteButton.isActive = false
        }
    }
}
