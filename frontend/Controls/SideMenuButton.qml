import QtQuick 2.0
import QtQuick.Layouts 1.3

ButtonDiode {
    property var module

    anchors.left: parent.left
    anchors.right: parent.right

    isSelected: selected === module
    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

    onButtonClicked: {
        selected = module;
        xChatPopup.focus();
    }
}
