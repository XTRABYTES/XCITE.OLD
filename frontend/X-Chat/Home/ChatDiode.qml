import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../../Controls" as Controls

Controls.Diode {
    id: generalDiode
    Layout.minimumHeight: 863
    Layout.minimumWidth: 1046
    Layout.fillHeight: true
    Layout.fillWidth: true
    Controls.DiodeHeader {
        id: chatDiodeHeader
        text: "CHAT"
        iconSource: "../icons/menu-settings.svg"
        iconOnly: true
        iconSize: 20
    }
    ColumnLayout {
        spacing: 0
        anchors.top: chatDiodeHeader.bottom
        anchors.topMargin: 40
        anchors.fill: parent

        RowLayout {
            //Layout.fillHeight: true
            //Layout.fillWidth: true
            Rectangle {

                id: chat
                color: "green"
                Layout.fillWidth: true
                Layout.preferredHeight: 730
            }
            Rectangle {
                //Layout.preferredWidth:
                id: status
                Layout.preferredWidth: 259
                Layout.preferredHeight: 730
            }
        }

        //Chatbox
        ChatBox {
        }
    }
} //Row Layout//Image//Rectangle -> chat box//Image
