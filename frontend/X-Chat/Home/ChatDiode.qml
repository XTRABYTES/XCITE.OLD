/**
 * Filename: ChatDiode.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
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
        anchors.topMargin: 45
        anchors.fill: parent

        RowLayout {
            //Layout.fillHeight: true
            //Layout.fillWidth: true
            ConversationBox {

                id: chat
                // color: "green"
                Layout.fillWidth: true
                Layout.fillHeight: true
                z: 10
                //Layout.preferredHeight: 720
            }
            Rectangle {
                Layout.preferredWidth: 1
                Layout.preferredHeight: 704
                anchors.bottom: parent.bottom
                color: "#4F5152"
            }

            StatusBox {
                id: status
            }
        }

        //Chatbox
        ChatBox {
        }
    }
} //Row Layout//Image//Rectangle -> chat box//Image
