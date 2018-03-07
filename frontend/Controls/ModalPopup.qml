import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Popup {
    id: popup

    property int modalPadding: 20
    property bool showInput: false
    property string inputValue
    property string bodyText
    property string title

    Overlay.modal: Rectangle {
        color: "#c92a2c31"
    }

    parent: Overlay.overlay

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    modal: true
    focus: true
    dim: true
    closePolicy: Popup.CloseOnEscape
    padding: 0

    background: Rectangle {
        color: "#3A3E46"
        radius: 4
    }
}
