/**
 * Filename: Conversation.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import "../Theme" 1.0

ColumnLayout {
    property alias model: view.model
    property alias view: view

    property color localTextColor: '#fff'
    property color localBorderColor: '#727989'
    property color localBackgroundColor: 'transparent'
    property color remoteTextColor: '#000'
    property color remoteBackgroundColor: Theme.primaryHighlight
    property color remoteBorderColor: 'transparent'
    property int messageSpacing: 12
    property int timestampSpacing: 4
    property bool simpleLayout: false

    anchors.fill: parent

    function add(message, datetime, isMine) {
        if (model) {
            model.addMessage(message, datetime, isMine)
        }
    }

    ListView {
        id: view
        spacing: messageSpacing

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.leftMargin: viewMargin
        Layout.rightMargin: viewMargin
        Layout.topMargin: 5
        Layout.bottomMargin: 5
        verticalLayoutDirection: ListView.BottomToTop
        clip: true

        delegate: Column {
            spacing: timestampSpacing

            anchors.left: simpleLayout ? undefined : (model.isMine ? undefined : parent.left)
            anchors.right: simpleLayout ? undefined : (model.isMine ? parent.right : undefined)

            Row {
                TextArea {
                    text: model.message
                    readOnly: true
                    persistentSelection: true
                    selectByMouse: true
                    color: model.isMine ? localTextColor : remoteTextColor
                    wrapMode: TextEdit.Wrap
                    font.pixelSize: 11
                    selectionColor: Theme.primaryHighlight
                    selectedTextColor: '#000'

                    topPadding: simpleLayout ? 0 : 7.3
                    bottomPadding: simpleLayout ? 0 : 6
                    leftPadding: simpleLayout ? 0 : 7.05
                    rightPadding: simpleLayout ? 0 : 8.05

                    background: Rectangle {
                        anchors.fill: parent
                        color: model.isMine ? localBackgroundColor : remoteBackgroundColor
                        border.color: model.isMine ? localBorderColor : remoteBorderColor
                        radius: 2
                    }

                    Component.onCompleted: {
                        if (width > view.width) {
                            width = view.width
                        }
                    }
                }
            }

            Label {
                visible: model.datetime
                font.pixelSize: 10
                anchors.left: model.isMine ? undefined : parent.left
                anchors.right: model.isMine ? parent.right : undefined
                text: Qt.formatDateTime(model.datetime, 'h:mm ap')
                color: "white"
            }
        }

        ScrollBar.vertical: ScrollBar {
        }
    }
}
