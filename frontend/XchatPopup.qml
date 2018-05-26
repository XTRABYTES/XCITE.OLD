/**
 * Filename: XchatPopup.qml
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
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import XChatConversationModel 0.1

import "X-Chat" as XChat
import "Theme" 1.0

import "Controls" as Controls

Item {
    readonly property color cBackground: "#3a3e47"
    readonly property real viewMargin: 10
    property string activeTab: xChatSettings.activeTab

    property var consoleCommandBuffer: []
    property var consoleCommandCompletion: ['addmultisigaddress', 'addnode', 'backupwallet', 'createmultisig', 'createrawtransaction', 'decoderawtransaction', 'dumpprivkey', 'encryptwallet', 'getaccount', 'getaccountaddress', 'getaddednodeinfo', 'getaddressesbyaccount', 'getbalance', 'getbestblockhash', 'getblock', 'getblockcount', 'getblockhash', 'getconnectioncount', 'getinfo', 'getnewaddress', 'getpeerinfo', 'getrawmempool', 'getrawtransaction', 'getreceivedbyaccount', 'getreceivedbyaddress', 'gettransaction', 'gettxout', 'gettxoutsetinfo', 'help', 'importprivkey', 'keypoolrefill', 'listaccounts', 'listaddressgroupings', 'listlockunspent', 'listreceivedbyaccount', 'listreceivedbyaddress', 'listsinceblock', 'listtransactions', 'listunspent', 'lockunspent', 'makekeypair', 'move', 'sendalert', 'sendfrom', 'sendmany', 'sendrawtransaction', 'sendtoaddress', 'setaccount', 'setmininput', 'settxfee', 'signmessage', 'signrawtransaction', 'stop', 'validateaddress', 'verifychain', 'verifymessage']

    property int consoleCommandBufferIdx: -1

    id: xChatPopup
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    width: 318
    smooth: true
    z: 100

    MouseArea {
        propagateComposedEvents: false
        anchors.fill: parent
        hoverEnabled: true
    }

    Connections {
        target: header
        onTabChanged: {
            xChatSettings.activeTab = newActiveTab
            xChatTextInput.forceActiveFocus()
        }
    }

    Component.onCompleted: {
        xChatTextInput.forceActiveFocus()
    }

    state: xChatSettings.sizeState

    states: [
        State {
            name: "minimal"
            PropertyChanges {
                target: xChatPopup
                height: 48
            }
        },

        State {
            name: "full"
            PropertyChanges {
                target: xChatPopup
                height: xcite.height < 700 ? xcite.height - 50 : 639
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            properties: "height"
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }

    function toggle() {
        state = state === 'full' ? 'minimal' : 'full'
        xChatSettings.sizeState = state
    }

    function focus(e) {
        xChatTextInput.forceActiveFocus()
    }

    function onSubmitUserInput(e) {
        var text = xChatTextInput.text.trim()

        if (text.length > 0) {
            var isRobot = activeTab === 'robot'
            var activeConversation = isRobot ? robot : conversation

            activeConversation.add(text, isRobot ? null : new Date(), true)
            activeConversation.submit(text)

            xChatTextInput.text = ''
        }

        xChatTextInput.forceActiveFocus()
    }

    Rectangle {
        id: innerPopupContainer
        anchors.fill: parent
        anchors.rightMargin: 15

        color: cBackground
        radius: 4

        ColumnLayout {
            anchors.fill: parent

            XChat.Header {
                id: header
                Layout.fillWidth: true
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                XChat.Conversation {
                    id: conversation

                    model: XChatConversationModel {
                        id: conversationModel
                    }

                    function submit(input) {
                        XChatRobot.SubmitMsgCall(input, '')
                    }

                    Connections {
                        target: XChatRobot
                        onXchatResponseSignal: {
                            conversation.add(text, new Date(), false)
                        }
                    }

                    visible: (activeTab == 'friends')

                    // TODO: Temporary placeholder content
                    Component.onCompleted: {
                        var now = Date.now()

                        conversation.add("Heading downtown?",
                                         new Date(now - 180000), true)
                        conversation.add("Absolutely, catching a show.",
                                         new Date(now - 120000), false)
                        conversation.add("We'll catch up later!",
                                         new Date(now), true)
                    }
                }

                XChat.Conversation {
                    id: robot

                    localTextColor: '#fff'
                    localBackgroundColor: 'transparent'
                    localBorderColor: 'transparent'
                    remoteTextColor: Theme.primaryHighlight
                    remoteBackgroundColor: 'transparent'
                    remoteBorderColor: 'transparent'
                    messageSpacing: 6
                    timestampSpacing: 0
                    simpleLayout: true

                    model: XChatConversationModel {
                        id: robotModel
                    }

                    Connections {
                        target: wallet
                        onConsoleResponse: {
                            var text = response.error ? (response.error.message + ': '
                                                         + response.error.code) : response.result

                            if (typeof text === 'object') {
                                text = JSON.stringify(text, null, 2)
                            }

                            robot.add(text)
                        }
                    }

                    Component.onCompleted: {
                        robot.add("XCITE ready", null, false)
                    }

                    function submit(input) {
                        consoleCommandBuffer.unshift(input)
                        consoleCommandBufferIdx = -1

                        var args = input.split(' ').filter(function (x) {
                            return x.length > 0
                        })

                        wallet.request("console", args[0], args.slice(1))
                    }

                    visible: (activeTab == 'robot')
                }
            }

            // Bottom controls
            Item {
                id: xChatUserInput
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: viewMargin
                anchors.rightMargin: viewMargin
                height: 61

                Rectangle {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    height: 1
                    color: "#727989"
                }

                RowLayout {
                    width: xChatUserInput.width
                    spacing: 10

                    anchors.verticalCenter: parent.verticalCenter

                    Controls.IconButton {
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                        Layout.preferredWidth: 40

                        img.source: "../icons/plus-button.svg"
                        img.sourceSize.width: 28
                        img.sourceSize.height: 29
                    }

                    Rectangle {
                        // User input
                        Layout.fillWidth: true
                        height: 32
                        radius: 4

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.IBeamCursor
                            onClicked: xChatTextInput.forceActiveFocus()
                        }

                        color: "#505a67"

                        TextInput {
                            id: xChatTextInput

                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.right: parent.right

                            anchors.leftMargin: 10.69
                            anchors.rightMargin: 10.69

                            clip: true

                            font.pixelSize: 11
                            color: "#ffffff"

                            Keys.onReturnPressed: onSubmitUserInput()
                            Keys.onTabPressed: {
                                // TODO: Poor man's tab completion, make better later
                                var input = xChatTextInput.text
                                var parts = input.split(' ')
                                var matches = []

                                for (var i = 0; i < consoleCommandCompletion.length; i++) {
                                    var cmd = consoleCommandCompletion[i]

                                    if (cmd.indexOf(parts[0]) === 0) {
                                        matches.push(cmd)
                                    }
                                }

                                if (matches.length === 1) {
                                    xChatTextInput.text = input.replace(
                                                parts[0], matches[0])
                                } else if (matches.length > 1) {
                                    robot.add('Commands:\n' + matches.join(
                                                  '\n'))
                                }
                            }

                            Keys.onUpPressed: {
                                if (consoleCommandBuffer.length === 0) {
                                    return
                                }

                                if (consoleCommandBufferIdx < consoleCommandBuffer.length - 1) {
                                    consoleCommandBufferIdx++

                                    xChatTextInput.text
                                            = consoleCommandBuffer[consoleCommandBufferIdx]
                                }
                            }
                            Keys.onDownPressed: {
                                if (consoleCommandBuffer.length === 0) {
                                    return
                                }

                                if (consoleCommandBufferIdx > 0) {
                                    consoleCommandBufferIdx--

                                    xChatTextInput.text
                                            = consoleCommandBuffer[consoleCommandBufferIdx]
                                } else {
                                    consoleCommandBufferIdx = -1
                                    xChatTextInput.text = ''
                                }
                            }
                        }
                    }

                    Button {
                        id: xChatBtnSend
                        text: qsTr("Send")
                        enabled: xChatTextInput.length > 0

                        onClicked: onSubmitUserInput()

                        // TODO: We'll likely want to make a reusable component for buttons
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onPressed: mouse.accepted = false
                        }

                        contentItem: Text {
                            text: xChatBtnSend.text
                            color: xChatBtnSend.enabled ? (xChatBtnSend.down ? "#ffffff" : "#24B9C3") : "#777"
                            font.pixelSize: 12
                        }

                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
        }
    }

    DropShadow {
        anchors.fill: innerPopupContainer
        horizontalOffset: -5
        verticalOffset: -5
        cached: true
        radius: 10
        samples: 20
        source: innerPopupContainer
        color: "#32373d"
    }
}
