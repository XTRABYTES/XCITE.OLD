import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

ModalPopup {
    property alias buttonText: btnClose.labelText

    signal cancelled

    ModalHeader {
        id: header
        text: title
    }

    ColumnLayout {
        anchors.margins: modalPadding
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Text {
            id: prompt
            text: bodyText
            Layout.fillWidth: true
            color: "#FFF7F7"
            font.pixelSize: 18
            wrapMode: Text.WordWrap
        }

        RowLayout {
            spacing: 16

            ButtonModal {
                id: btnClose
                isPrimary: true
                onButtonClicked: {
                    cancelled()
                }
            }
        }
    }
}
