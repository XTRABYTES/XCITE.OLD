import QtQuick 2.4
import QtQuick.Controls 2.2
import "../Theme" 1.0

ListView {
    id: addressBook
    anchors.fill: parent
    anchors.topMargin: 10
    anchors.bottomMargin: 10
    anchors.leftMargin: 3
    anchors.rightMargin: 3

    highlightMoveDuration: 0
    highlightResizeDuration: 0

    clip: true

    currentIndex: 0

    delegate: Label {
        property variant item: model

        verticalAlignment: Text.AlignVCenter
        width: parent.width
        leftPadding: 20
        rightPadding: 20
        text: name || "Default"
        font.family: "Roboto"
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
