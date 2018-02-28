import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Popup {
    id: popup

    property int modalPadding: 20
    property bool showInput: false
    property string inputValue
    property string bodyText
    property string title

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    modal: true
    focus: true
    dim: true
    closePolicy: Popup.CloseOnEscape
    padding: 0

    background: Rectangle {
        color: "#3A3E46"
        radius: 5
        border.color: "#4010B9C5"
        border.width: 3
    }
}
