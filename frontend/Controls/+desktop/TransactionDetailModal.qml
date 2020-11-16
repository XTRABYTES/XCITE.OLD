/**
 * Filename: TransactionDetailModal.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick.Controls 2.3
import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtMultimedia 5.8
import QZXing 2.3

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: transactionModal
    width: appWidth/6 * 5
    height: appHeight
    state: transactionDetailTracker == 1? "up" : "down"
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: bgcolor
        opacity: 0.9
    }

    MouseArea {
        anchors.fill: parent
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: transactionModal; anchors.topMargin: 0}
            PropertyChanges { target: transactionModal; opacity: 1}
        },
        State {
            name: "down"
            PropertyChanges { target: transactionModal; anchors.topMargin: transactionModal.height}
            PropertyChanges { target: transactionModal; opacity: 0}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: transactionModal; properties: "anchors.topMargin, opacity"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]


    Rectangle {
        anchors.fill: parent
        color: bgcolor
        opacity: 0.9
    }

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        id: closeTransactiondetails
        width: appWidth/48
        height: width
        radius: height/2
        color: "transparent"
        border.width: 1
        border.color: themecolor
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.bottom: transactionDetailModal.top
        anchors.bottomMargin: height/2

        Item {
            width: parent.width*0.6
            height: width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: 45

            Rectangle {
                width: parent.width
                height: 1
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                height: parent.height
                width: 1
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            id: closeSelect
            anchors.fill: parent
            radius: height/2
            color: maincolor
            opacity: 0.3
            visible: false
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                closeSelect.visible = true
            }

            onExited: {
                closeSelect.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                transactionDetailTracker = 0
            }
        }
    }

    DropShadow {
        anchors.fill: transactionDetailModal
        source: transactionDetailModal
        horizontalOffset: 4
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.3
        transparentBorder: true
    }

    Rectangle {
        id: transactionDetailModal
        width: parent.width - appWidth*3/24
        height: parent.height - appWidth*5/24
        color: bgcolor
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/12
        border.color: themecolor
        border.width: 1
        clip: true

        Label {
            id: detailModalLabel
            text: "TRANSACTION DETAILS"
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.top: parent.top
            anchors.topMargin: appWidth/27
            horizontalAlignment: Text.AlignRight
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            font.capitalization: Font.AllUppercase
            color: themecolor
            font.letterSpacing: 2
            elide: Text.ElideRight
        }

        Label {
            id: txidLabel
            text: "Transaction ID:"
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.top: detailModalLabel.bottom
            anchors.topMargin: font.pixelSize
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            color: themecolor
        }

        Label {
            id: txid
            text: transactionNR
            anchors.left: txidLabel.right
            anchors.leftMargin: font.pixelSize
            anchors.right: clipBoard1.left
            anchors.rightMargin: font.pixelSize
            horizontalAlignment: Text.AlignRight
            anchors.top: txidLabel.top
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            color: themecolor
            elide: Text.ElideRight
        }

        Image {
            id: clipBoard1
            source: darktheme == true? "qrc:/icons/clipboard_icon_light01.png" : "qrc:/icons/clipboard_icon_dark01.png"
            width: appHeight/54
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: txid.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24

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
                            txid2Copy = transactionNR
                            copyText2Clipboard(transactionNR)
                            copy2clipboard = 1
                            historyDetailClipboard = 1
                        }
                    }
                }
            }
        }

        Label {
            id: timestampLabel
            text: "Date & Time:"
            anchors.left: txidLabel.left
            anchors.top: txidLabel.bottom
            anchors.topMargin: font.pixelSize
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            color: themecolor
        }

        Label {
            id: timestamp
            text: transactionTimestamp
            anchors.left: timestampLabel.right
            anchors.leftMargin: font.pixelSize
            anchors.top: timestampLabel.top
            font.family: xciteMobile.name
            font.pixelSize: appHeight/54
            color: themecolor
            visible: transactionDetailsCollected === true
        }

        Label {
            id: confirmationLabel
            text: "Confirmations"
            anchors.left: timestampLabel.right
            anchors.leftMargin: appWidth*1.25/6
            anchors.top: timestampLabel.top
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            color: themecolor
        }

        Label {
            id: confirmationAmount
            text: transactionConfirmations
            anchors.left: confirmationLabel.right
            anchors.leftMargin: font.pixelSize
            anchors.top: confirmationLabel.top
            font.family: xciteMobile.name
            font.pixelSize: appHeight/54
            color: themecolor
            visible: transactionDetailsCollected === true
        }

        Label {
            id: amountTicker
            text: walletList.get(walletIndex).name
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24
            anchors.top: confirmationAmount.top
            font.family: xciteMobile.name
            font.pixelSize: appHeight/54
            color: themecolor
        }

        Label {
            property int decimals: transactionAmount == 0? 2 : (transactionAmount <= 1000 ? 8 : (transactionAmount <= 1000000 ? 4 : 2))
            property var amountArray: (transactionAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
            id: amountValue1
            text: "." + amountArray[1]
            anchors.right: amountTicker.left
            anchors.rightMargin: font.pixelSize/4
            anchors.bottom: amountTicker.bottom
            font.family: xciteMobile.name
            font.pixelSize: appHeight/54
            color: themecolor
        }

        Label {
            property int decimals: transactionAmount == 0? 2 : (transactionAmount <= 1000 ? 8 : (transactionAmount <= 1000000 ? 4 : 2))
            property var amountArray: (transactionAmount.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
            id: amountValue2
            text: amountArray[0]
            anchors.right: amountValue1.left
            anchors.bottom: amountTicker.bottom
            font.family: xciteMobile.name
            font.pixelSize: appHeight/54
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
        }

        Item {
            id: inputs
            width: (parent.width - appWidth/12)/2 - appWidth/48
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: appWidth/48
            anchors.top: amountTicker.bottom
            anchors.topMargin: amountTicker.font.pixelSize
            anchors.bottom: parent.bottom
            anchors.bottomMargin: appWidth/24

            Label {
                id: inputLabel
                text: "INPUTS"
                anchors.top: parent.top
                anchors.horizontalCenter: inputArea.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: appHeight/54
                color: themecolor
            }

            Rectangle {
                id: inputArea
                width: parent.width
                anchors.top: inputLabel.bottom
                anchors.topMargin: inputLabel.font.pixelSize/2
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                color: "transparent"
                clip: true

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.width: 1
                    border.color: themecolor
                    opacity: 0.1
                }

                Desktop.TransactionAddressList {
                    id: inputList
                    anchors.top: parent.top
                    transactionAddresses: "input"
                }
            }
        }

        Item {
            id: outputs
            width: (parent.width - appWidth/12)/2 - appWidth/48
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: appWidth/48
            anchors.top: amountTicker.bottom
            anchors.topMargin: amountTicker.font.pixelSize
            anchors.bottom: parent.bottom
            anchors.bottomMargin: appWidth/24

            Label {
                id: outputLabel
                text: "OUTPUTS"
                anchors.top: parent.top
                anchors.horizontalCenter: outputArea.horizontalCenter
                font.family: xciteMobile.name
                font.pixelSize: appHeight/54
                color: themecolor
            }

            Rectangle {
                id: outputArea
                width: parent.width
                anchors.top: outputLabel.bottom
                anchors.topMargin: outputLabel.font.pixelSize/2
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                color: "transparent"
                clip: true

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.width: 1
                    border.color: themecolor
                    opacity: 0.1
                }

                Desktop.TransactionAddressList {
                    id: outputList
                    anchors.top: parent.top
                    transactionAddresses: "output"
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
            visible: copy2clipboard == 1 && historyDetailClipboard == 1
        }

        Rectangle {
            id: textPopup
            height: popupClipboardText1.font.pixelSize*3.5
            width: parent.width/2
            color: "#34363D"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            visible: copy2clipboard == 1 && historyDetailClipboard == 1

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
            anchors.fill: addressPopUp
            source: addressPopUp
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            spread: 0
            color: "black"
            opacity: 0.4
            transparentBorder: true
            visible: copy2clipboard == 1 && historyAddressClipboard == 1
        }

        Rectangle {
            id: addressPopUp
            width: popupaddressText.width + popupaddressText.font.pixelSize*2
            height: popupaddressText.font.pixelSize*2
            color: "#34363D"
            anchors.horizontalCenter: selectedList == "input"? inputs.horizontalCenter : outputs.horizontalCenter
            anchors.verticalCenter: selectedList == "input"? inputs.verticalCenter : outputs.verticalCenter
            visible: copy2clipboard == 1 && historyAddressClipboard == 1

            Label {
                id: popupaddressText
                text: "Address copied!"
                font.family: xciteMobile.name
                font.pixelSize: appHeight/54
                color: "#F2F2F2"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Rectangle {
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }
}
