import QtQuick 2.7
import QtQuick.Controls 2.3
import "../Theme" 1.0

ListView {

    property int delegateLeftPadding: 20
    property int delegateRightPadding: 20
    property int delegatePixelSize: 16
    property string delegateColor: "white"
    property string delegateHightlightColor: "#42454D"
    property int delegateFontWeight: Font.Light
    property int leftMargin: 3
    property int rightMargin: 3
    property double delegateLineHeight: 1.5

    id: addressBook
    anchors.fill: parent
    anchors.topMargin: 10
    anchors.bottomMargin: 10
    anchors.leftMargin: leftMargin
    anchors.rightMargin: rightMargin

    highlightMoveDuration: 0
    highlightResizeDuration: 0

    clip: true

    currentIndex: 0

    delegate: Label {
        property variant item: model

        verticalAlignment: Text.AlignVCenter
        width: parent.width

        leftPadding: delegateLeftPadding
        rightPadding: delegateRightPadding
        text: name || "Default"
        font.family: "Roboto"
       /* font.weight: delegateFontWeight
        font.pixelSize: delegatePixelSize
        color: delegateColor
        lineHeight: delegateLineHeight*/
        font.weight: Font.Light
        font.pixelSize: 16
        color: addressBook.currentIndex == index ? "black" : "white"
        lineHeight: 1.5

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: addressBook.currentIndex = index
        }
    }

    highlight: Rectangle {
        color: Theme.primaryHighlight
    }

    function load() {
        model.load()
    }

    function save() {
        model.save()
    }

    function add(name, address) {
        currentIndex = model.append(name, address)
    }

    function update(name, address) {
        if (currentItem) {
            model.update(currentIndex, name, address)
        }
    }

    function getSelectedItem() {
        return model.get(currentIndex)
    }

    function removeSelected() {
        if (currentItem) {
            model.remove(currentIndex)
        }
    }
}
