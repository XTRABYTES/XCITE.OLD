/**
* Filename: HistoryList.qml
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
import SortFilterProxyModel 0.2
import QtGraphicalEffects 1.0

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: allHistoryCards
    width: parent.width
    height: parent.height
    anchors.top: parent.top
    color: "transparent"
    clip :true

    Label {
        id: noResultLabel
        text: "No transactions."
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: xciteMobile.name
        font.pixelSize: appHeight/45
        color: themecolor
        visible: historyList.count === 0
    }

    Component {
        id: historyLine

        Rectangle {
            id: historyRow
            color: "transparent"
            width: allHistoryCards.width
            height: appHeight/9
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: square
                width: parent.width
                height: parent.height
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                clip: true

                Rectangle {
                    id: selectionIndicator
                    width: parent.width
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                Rectangle {
                    id: cardBorder
                    width: parent.width*0.95
                    height: 1
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: themecolor
                    border.width: 1
                    opacity: 0.1
                }

                MouseArea {
                    anchors.fill: selectionIndicator
                    hoverEnabled: true

                    onEntered: {
                        selectionIndicator.visible = true
                    }

                    onExited: {
                        selectionIndicator.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        transactionTimestamp = ""
                        transactionAmount = (Number.fromLocaleString(Qt.locale("en_US"),value) )/ 100000000
                        transactionNR = txid
                        transactionDirection = direction
                        if (explorerBusy == false) {
                            transactionDetailsCollected = false
                            transactionDetailTracker = 1
                            getDetails(amountTicker.text, txid)
                        }
                        else {
                            explorerPopup = 1
                        }
                    }
                }

                Label {
                    id: transactionID
                    text: txid
                    anchors.left: parent.left
                    anchors.leftMargin: font.pixelSize
                    anchors.right: clipBoard1.left
                    anchors.rightMargin: font.pixelSize
                    anchors.top: parent.top
                    anchors.topMargin: font.pixelSize/2
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/5
                    color: darktheme == true? "#F2F2F2" : "#2A2C31"
                    elide: Text.ElideRight
                }

                Image {
                    id: clipBoard1
                    source: darktheme == true? "qrc:/icons/clipboard_icon_light01.png" : "qrc:/icons/clipboard_icon_dark01.png"
                    height: parent.height/5
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: transactionID.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: height

                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"

                        MouseArea {
                            anchors.fill: parent

                            onPressed: {
                                click01.play()
                                detectInteraction()
                            }

                            onClicked: {
                                if(copy2clipboard == 0) {
                                    txid2Copy = txid
                                    copyText2Clipboard(txid)
                                    copy2clipboard = 1
                                    historyClipboard = 1
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: confirmationIndicator
                    height: transactionID.height/2
                    width: height
                    radius: height/2
                    anchors.left: transactionID.left
                    anchors.verticalCenter: confirmationAmount.verticalCenter
                    color: confirmations < 4? "#E55541" : (confirmations < 6? "#FF8400" : "#4BBE2E")
                }

                Label {
                    id: confirmationLabel
                    text: "confirmations"
                    anchors.left: transactionID.left
                    anchors.top: transactionID.bottom
                    anchors.topMargin: font.pixelSize/2
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/5
                    color: themecolor
                }

                Label {
                    id: confirmationAmount
                    text: confirmations
                    anchors.left: confirmationIndicator.right
                    anchors.leftMargin: font.pixelSize
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: font.pixelSize/2
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/5
                    color: themecolor
                }

                Label {
                    id: amountTicker
                    text: walletList.get(walletIndex).name
                    anchors.right: clipBoard1.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: font.pixelSize/2
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/5
                    color: direction == false? "#E55541" : "#4BBE2E"
                }

                Label {
                    property real amount: (Number.fromLocaleString(Qt.locale("en_US"),value) )/ 100000000
                    property int decimals: amount == 0? 2 : (amount <= 1000 ? 8 : (amount <= 1000000 ? 4 : 2))
                    property var amountArray: (amount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountValue1
                    text: "." + amountArray[1]
                    anchors.right: amountTicker.left
                    anchors.rightMargin: font.pixelSize/4
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: font.pixelSize/2
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/5
                    color: direction == false? "#E55541" : "#4BBE2E"
                }

                Label {
                    property real amount: (Number.fromLocaleString(Qt.locale("en_US"),value))/ 100000000
                    property int decimals: amount == 0? 2 : (amount <= 1000 ? 8 : (amount <= 1000000 ? 4 : 2))
                    property var amountArray: (amount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountValue2
                    text: direction == false? ("- " + amountArray[0]) : ("+ " + amountArray[0])
                    anchors.right: amountValue1.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: font.pixelSize/2
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/5
                    color: direction == false? "#E55541" : "#4BBE2E"
                }
            }
        }
    }

    ListView {
        anchors.fill: parent
        id: picklist
        model: historyList
        delegate: historyLine
        onDraggingChanged: detectInteraction()
        contentHeight: historyList.count * appHeight/9
        interactive: walletListTracker == 0

        ScrollBar.vertical: ScrollBar {
            parent: picklist.parent
            anchors.top: picklist.top
            anchors.right: picklist.right
            anchors.bottom: picklist.bottom
            width: 5
            opacity: 1
            policy: picklist.contentHeight > allHistoryCards.height? ScrollBar.AsNeeded : ScrollBar.AlwaysOff

            contentItem: Rectangle {
                implicitWidth: 5
                implicitHeight: appWidth/24
                color: maincolor
            }
        }
    }

    DropShadow {
        anchors.fill: textPopup
        source: textPopup
        horizontalOffset: 0
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.4
        transparentBorder: true
        visible: copy2clipboard == 1 && historyClipboard == 1
    }

    Rectangle {
        id: textPopup
        height: popupClipboardText1.font.pixelSize*3.5
        width: parent.width*0.9
        color: "#34363D"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: copy2clipboard == 1 && historyClipboard == 1

        Label {
            id: popupClipboardText1
            width: parent.width
            text: txid2Copy
            font.family: xciteMobile.name
            font.pixelSize: appHeight/54
            color: "#F2F2F2"
            horizontalAlignment: Text.AlignHCenter
            leftPadding: font.pixelSize
            rightPadding: font.pixelSize
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: font.pixelSize/2
            elide: Text.ElideRight
        }

        Label {
            id: popupClipboardText2
            text: "Txid copied!"
            font.family: xciteMobile.name
            font.pixelSize: appHeight/54
            color: "#F2F2F2"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: font.pixelSize/2
        }
    }

    DropShadow {
        anchors.fill: explorerPopUp
        source: explorerPopUp
        horizontalOffset: 0
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.4
        transparentBorder: true
        visible: explorerBusy == true && explorerPopup == 1
    }

    Rectangle {
        id: explorerPopUp
        width: popupExplorerBusy.width
        height: popupExplorerText.font.pixelSize*1.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: explorerBusy == true && explorerPopup == 1

        Label {
            id: popupExplorerText
            text: "Explorer is busy. Try again"
            font.family: xciteMobile.name
            font.pixelSize: appHeight/54
            color: "#F2F2F2"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Timer {
            repeat: false
            running: explorerPopup == 1
            interval: 2000

            onTriggered: explorerPopup = 0
        }
    }
}
