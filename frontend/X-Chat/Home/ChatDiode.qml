import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../../Controls" as Controls

Controls.Diode {
    id: generalDiode
    Layout.preferredHeight: 863
    Layout.preferredWidth: 1046
    Layout.fillHeight: true
    Layout.fillWidth: true
    border.color: "black"
    Controls.DiodeHeader {
        text: "CHAT"
        iconSource: "../icons/menu-settings.svg"
        iconOnly: true
        iconSize: 20
    }

    RowLayout {
        Rectangle {
            id: chat
        }
        Rectangle {
            id: status
        }
    }

    //Chatbox
    ChatBox {
    }
} //Row Layout//Image//Rectangle -> chat box//Image
