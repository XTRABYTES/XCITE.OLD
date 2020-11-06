/**
* Filename: CoinWallets.qml
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
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtCharts 2.0

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop

Rectangle {
    id: backgroundWallet
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: parent.right
    anchors.top: parent.top
    color: bgcolor
    state: coinTracker == 1? "up" : "down"
    clip: true

    states: [
        State {
            name: "up"
            PropertyChanges { target: backgroundWallet; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: backgroundWallet; anchors.topMargin: appHeight}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: backgroundWallet; properties: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    property int decimals: totalCoinsSum == 0? 2 : (totalCoinsSum <= 1000? 8 : (totalCoinsSum <= 1000000? 4 : 2))
    property real totalCoinsSum: valueTicker.text === "XBY"? totalXBY :
                                                            (valueTicker.text === "XFUEL"? totalXFUEL:
                                                                                          (valueTicker.text === "XTEST"? totalXFUELTest :
                                                                                                                        (valueTicker.text === "BTC"? totalBTC :
                                                                                                                                                    (valueTicker.text === "ETH"? totalETH : 0))))
    property var totalArray: (totalCoinsSum.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
    property bool myTheme: darktheme

    onMyThemeChanged: {
        addAddressButton.border.color = themecolor
    }

    MouseArea {
        anchors.fill: parent
    }

    Label {
        id: walletLabel
        text: "WALLET - " + getFullName(coinIndex)
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        font.capitalization: Font.AllUppercase
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
    }

    Item {
        id: totalWalletValue
        width: valueTicker.implicitWidth + value1.implicitWidth + value2.implicitWidth
        height: value1.implicitHeight
        anchors.top: walletLabel.bottom
        anchors.topMargin: appWidth/72
        anchors.right: walletLabel.right

        Label {
            id: valueTicker
            anchors.left: value2.right
            anchors.bottom: value1.bottom
            leftPadding: appHeight/54
            text: getName(coinIndex)
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            color: themecolor
            visible: userSettings.showBalance === true
        }

        Label {
            id: value1
            anchors.left: parent.left
            anchors.verticalCenter: totalWalletValue.verticalCenter
            text: totalArray[0]
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            color: themecolor
        }

        Label {
            id: value2
            anchors.left: value1.right
            anchors.bottom: value1.bottom
            text: "." + totalArray[1]
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            color: themecolor
        }
    }

    Rectangle {
        id: infoBar
        width: parent.width
        height: appHeight/18
        anchors.top: totalWalletValue.bottom
        anchors.topMargin: appWidth/24
        anchors.horizontalCenter: parent.horizontalCenter
        color: darktheme == true? "#0B0B09" : "#F2F2F2"

        Label {
            property int decimals: getValue(getName(coinIndex)) >= 1? 4 : 8
            id: btcValue
            z: 6
            text: (getValue(getName(coinIndex)).toLocaleString(Qt.locale("en_US"), "f", decimals)) + " BTC"
            font.pixelSize: parent.height/2
            font.family: xciteMobile.name
            color: themecolor
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            property int decimals: (getValue(getName(coinIndex)) * valueBTC) <= 1 ? 4 : 2
            id: fiatValue
            z: 6
            text: fiatTicker + (getValue(getName(coinIndex)) * valueBTC).toLocaleString(Qt.locale("en_US"), "f", decimals)
            font.pixelSize: parent.height/2
            font.family: xciteMobile.name
            color: themecolor
            anchors.right: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: coinPercentage
            z: 6
            text: getPercentage(getName(coinIndex)) >= 0? ("+" + getPercentage(getName(coinIndex)) + " %") : (getPercentage(getName(coinIndex)) + " %")
            font.pixelSize: parent.height/2
            font.family: xciteMobile.name
            color: getPercentage(getName(coinIndex)) < 0 ? "#E55541" : "#4BBE2E"
            anchors.right: parent.right
            anchors.rightMargin: appWidth/12
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: walletArea
        width: parent.width
        anchors.top: infoBar.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        color: "transparent"
        clip: true

        Desktop.WalletList {
            id: myWalletlist
            anchors.top: parent.top
        }
    }

    Item {
        id: addAddress
        width: addAddressButton.width + addAddressLabel.width
        height: addAddressButton.height
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height + 6
            width: parent.width + 6
            radius: height/2
            color: bgcolor
            opacity: 0.9
        }

        Rectangle {
            id: addAddressButton
            height: appWidth/48
            width: height
            radius: height/2
            color: "transparent"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            border.width: 2
            border.color: themecolor

            Rectangle {
               height: 2
               width: parent.width*0.6
               radius: height/2
               color: parent.border.color
               anchors.verticalCenter: parent.verticalCenter
               anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                width: 2
                height: parent.height*0.6
                radius: width/2
                color: parent.border.color
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Label {
            id: addAddressLabel
            text: "ADD ADDRESS"
            leftPadding: addAddressButton.height/2
            font.pixelSize: addAddressButton.height/2
            font.family: xciteMobile.name
            color: addAddressButton.border.color
            anchors.left: addAddressButton.right
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                addAddressButton.border.color = maincolor
            }

            onExited: {
                addAddressButton.border.color = themecolor
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                addWalletTracker = 1
                selectedPage = "wallet"
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
