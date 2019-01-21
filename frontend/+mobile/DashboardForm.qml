/**
* Filename: DashboardForm.qml
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

import "qrc:/Controls" as Controls

Item {

    // shared vars

    property int pageTracker: view.currentIndex == 0 ? 0 : 1
    property var balanceArray: ((totalBalance).toLocaleString(Qt.locale("en_US"), "f", 2)).split('.')
    property string searchCriteria:""

    Rectangle {
        id: backgroundHome
        z: 1
        width: Screen.width
        height: Screen.height
        color: darktheme == false? "#F7F7F7" : "#2A2C31"

        SwipeView {
            id: view
            z: 2
            currentIndex: 0
            anchors.fill: parent
            interactive: (appsTracker == 1 || transferTracker == 1 || addressTracker == 1 || addAddressTracker == 1 || addCoinTracker == 1) ? false : true
            visible: loginTracker == 1

            Item {
                id: dashForm

                Rectangle {
                    id: balanceWindow
                    z: 5
                    height: 70
                    anchors.bottom: homeHeader.bottom
                    anchors.bottomMargin: 15
                    anchors.right: parent.right
                    anchors.rightMargin: 55/2
                    radius: 4
                    color: "#0B0B09"
                    state: coinTracker == 0? "big" : "small"

                    states: [
                        State {
                            name: "big"
                            PropertyChanges { target: balanceWindow; width: (Screen.width - 55)}
                        },
                        State {
                            name: "small"
                            PropertyChanges { target: balanceWindow; width: (Screen.width - 140)}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: balanceWindow; property: "width"; duration: 700; easing.type: Easing.InOutCubic}
                        }
                    ]
                }

                InnerShadow {
                    z: 5
                    anchors.fill: balanceWindow
                    source: balanceWindow
                    radius: 12
                    samples: 17
                    horizontalOffset: 0
                    verticalOffset: 2
                    color: "black"
                }

                DropShadow {
                    id: bigLogoShadow
                    z: 5
                    anchors.fill: bigLogo
                    source: bigLogo
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color:"black"
                    opacity: 0.4
                    transparentBorder: true
                    visible: bigLogo.visible
                }

                Image {
                    id: bigLogo
                    z: 5
                    source: getLogo(getName(coinIndex))
                    height: 70
                    width: 70
                    anchors.verticalCenter: balanceWindow.verticalCenter
                    anchors.right: balanceWindow.left
                    state: coinTracker == 0? "hidden" : "inView"
                    visible: (x + 70) >= 0

                    states: [
                        State {
                            name: "hidden"
                            PropertyChanges { target: bigLogo; anchors.rightMargin: 45}
                        },
                        State {
                            name: "inView"
                            PropertyChanges { target: bigLogo; anchors.rightMargin: 15}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: bigLogo; property: "anchors.rightMargin"; duration: 700; easing.type: Easing.InOutCubic}
                        }
                    ]
                }

                Item {
                    id: totalWalletValue
                    z:5
                    width: valueTicker.implicitWidth + value1.implicitWidth + value2.implicitWidth
                    height: value1.implicitHeight
                    anchors.verticalCenter: balanceWindow.verticalCenter
                    anchors.horizontalCenter: balanceWindow.horizontalCenter
                    visible: balanceWindow.width > Screen.width -110
                    state: (coinTracker == 0 && (balanceWindow.width > Screen.width -110))? "up" : "down"

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: totalWalletValue; opacity: 1}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: totalWalletValue; opacity: 0}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            PropertyAnimation { target: totalWalletValue; property: "opacity"; duration: 700; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Label {
                        id: valueTicker
                        z: 5
                        anchors.left: totalWalletValue.left
                        anchors.bottom: value1.bottom
                        text: "$"
                        font.pixelSize: 50
                        font.family: xciteMobile.name
                        color: "white"
                    }

                    Label {
                        id: value1
                        z: 5
                        anchors.left: valueTicker.right
                        anchors.verticalCenter: totalWalletValue.verticalCenter
                        //anchors.verticalCenterOffset: 105
                        text: balanceArray[0]
                        font.pixelSize: 50
                        font.family: xciteMobile.name
                        color: "white"
                    }

                    Label {
                        id: value2
                        z: 5
                        anchors.left: value1.right
                        anchors.bottom: value1.bottom
                        anchors.bottomMargin: 6
                        text: "." + balanceArray[1]
                        font.pixelSize: 30
                        font.family: xciteMobile.name
                        color: "white"
                    }
                }

                Item {
                    id: coinInfo1
                    z:5
                    width: balanceWindow.width
                    height: balanceWindow.height
                    anchors.verticalCenter: balanceWindow.verticalCenter
                    anchors.horizontalCenter: balanceWindow.horizontalCenter
                    visible: balanceWindow.width < Screen.width -110
                    state: (coinTracker == 0 && (balanceWindow.width < Screen.width -110))? "down" : "up"

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: coinInfo1; opacity: 1}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: coinInfo1; opacity: 0}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            PropertyAnimation { target: coinInfo1; property: "opacity"; duration: 700; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Label {
                        id: totalCoins
                        z: 5
                        anchors.right: parent.right
                        anchors.rightMargin: 14
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        text: getName(coinIndex)
                        font.pixelSize: 20
                        font.family: xciteMobile.name
                        color: "white"
                    }

                    Label {
                        property int decimals: totalCoinsSum <= 1000? 8 : (totalCoinsSum <= 1000000? 4 : 2)
                        property real totalCoinsSum: sumCoinTotal(totalCoins.text)
                        property var totalArray: (totalCoinsSum.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                        id: total1
                        z: 5
                        anchors.right: totalCoins.left
                        anchors.rightMargin: 5
                        anchors.bottom: totalCoins.bottom
                        anchors.bottomMargin: 1
                        text: "." + totalArray[1]
                        font.pixelSize: 16
                        font.family: xciteMobile.name
                        color: "white"
                    }

                    Label {
                        property int decimals: totalCoinsSum <= 1000? 8 : (totalCoinsSum <= 1000000? 4 : 2)
                        property real totalCoinsSum: sumCoinTotal(totalCoins.text)
                        property var totalArray: (totalCoinsSum.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                        id: total2
                        z: 5
                        anchors.right: total1.left
                        anchors.bottom: totalCoins.bottom
                        text: totalArray[0]
                        font.pixelSize: 20
                        font.family: xciteMobile.name
                        color: "white"
                    }
                }

                Item {
                    id: coinInfo2
                    z:5
                    width: balanceWindow.width
                    height: balanceWindow.height
                    anchors.verticalCenter: balanceWindow.verticalCenter
                    anchors.horizontalCenter: balanceWindow.horizontalCenter
                    visible: balanceWindow.width < Screen.width -110
                    state: (coinTracker == 0 && (balanceWindow.width < Screen.width -110))? "down" : "up"

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: coinInfo2; opacity: 1}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: coinInfo2; opacity: 0}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            PropertyAnimation { target: coinInfo2; property: "opacity"; duration: 700; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Label {
                        id: totalUnconfirmed
                        z: 5
                        anchors.right: parent.right
                        anchors.rightMargin: 14
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 8
                        text: getName(coinIndex)
                        font.pixelSize: 12
                        font.family: xciteMobile.name
                        color: "white"
                    }

                    Label {
                        property int decimals: totalUnconfirmedSum <= 1? 8 : (totalUnconfirmedSum <= 1000? 4 : 2)
                        property real totalUnconfirmedSum: sumCoinUnconfirmed(totalUnconfirmed.text)
                        property var totalArray: (totalUnconfirmedSum.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                        id: unconfirmed1
                        z: 5
                        anchors.right: totalUnconfirmed.left
                        anchors.rightMargin: 3
                        anchors.bottom: totalUnconfirmed.bottom
                        text: "." + totalArray[1]
                        font.pixelSize: 12
                        font.family: xciteMobile.name
                        color: "white"
                    }

                    Label {
                        property int decimals: totalUnconfirmedSum <= 1? 8 : (totalUnconfirmedSum <= 1000? 4 : 2)
                        property real totalUnconfirmedSum: sumCoinUnconfirmed(totalUnconfirmed.text)
                        property var totalArray: (totalUnconfirmedSum.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                        id: unconfirmed2
                        z: 5
                        anchors.right: unconfirmed1.left
                        anchors.bottom: totalUnconfirmed.bottom
                        text: totalArray[0]
                        font.pixelSize: 12
                        font.family: xciteMobile.name
                        color: "white"
                    }

                    Label {
                        id: unconfirmedText
                        z: 5
                        anchors.right: parent.right
                        anchors.rightMargin: 135
                        anchors.bottom: totalUnconfirmed.bottom
                        text: "Unconfirmed:"
                        font.pixelSize: 12
                        font.family: xciteMobile.name
                        color: "white"
                    }
                }

                Rectangle {
                    id:scrollAreaCoinList
                    z: 3
                    width: Screen.width
                    height: Screen.height - 240
                    anchors.top: parent.top
                    anchors.topMargin: 190
                    color: "transparent"
                    state: (coinTracker == 0 && scrollAreaWalletList.height == 0)? "down" : "up"

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: scrollAreaCoinList; height: 0}
                            PropertyChanges { target: scrollAreaCoinList; anchors.topMargin: 50}
                            PropertyChanges { target: myCoinCards; cardSpacing: -88}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: scrollAreaCoinList; height: Screen.height - 240}
                            PropertyChanges { target: scrollAreaCoinList; anchors.topMargin: 190}
                            PropertyChanges { target: myCoinCards; cardSpacing: 0}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: scrollAreaCoinList; properties: "height, anchors.topMargin"; duration: 500; easing.type: Easing.InOutCubic}
                            NumberAnimation { target: myCoinCards; property: "cardSpacing"; duration: 500; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Controls.CoinList {
                        id: myCoinCards
                        cardSpacing: 0

                    }

                }

                Rectangle {
                    id:scrollAreaWalletList
                    z: 3
                    width: Screen.width
                    height: Screen.height - 240
                    anchors.top: parent.top
                    anchors.topMargin: 190
                    color: "transparent"
                    state: (coinTracker == 1 && scrollAreaCoinList.height == 0)? "down" : "up"

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: scrollAreaWalletList; height: 0}
                            PropertyChanges { target: scrollAreaWalletList; anchors.topMargin: 50}
                            PropertyChanges { target: myWalletCards; cardSpacing: -88}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: scrollAreaWalletList; height: Screen.height - 240}
                            PropertyChanges { target: scrollAreaWalletList; anchors.topMargin: 190}
                            PropertyChanges { target: myWalletCards; cardSpacing: 0}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: scrollAreaWalletList; properties: "height, anchors.topMargin"; duration: 500; easing.type: Easing.InOutCubic}
                            NumberAnimation { target: myWalletCards; property: "cardSpacing"; duration: 500; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Controls.WalletList {
                        id: myWalletCards

                    }

                }

                Rectangle {
                    id: backButton1
                    z: 3
                    radius: 25
                    anchors.fill: backButton
                    color: darktheme == false? "#2A2C31" : "#14161B"
                    opacity: 0.1
                    visible: backButton.visible

                }

                DropShadow {
                    z: 3
                    anchors.fill: backButton
                    source: backButton
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.4
                    transparentBorder: true
                    visible: backButton.visible
                }

                Rectangle {
                    id: backButton
                    z: 3
                    height: 50
                    width: 50
                    radius: 25
                    anchors.right: parent.right
                    anchors.rightMargin: -110
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 50
                    color: "transparent"
                    border.color: darktheme == false? "#42454F" : "#0ED8D2"
                    border.width: 2
                    visible: anchors.rightMargin > -110
                    state: coinTracker == 1 ? "inView" : "hidden"

                    states: [
                        State {
                            name: "inView"
                            PropertyChanges { target: backButton; anchors.rightMargin: 15}
                        },
                        State {
                            name: "hidden"
                            PropertyChanges { target: backButton; anchors.rightMargin: -110}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: backButton; properties: "anchors.rightMargin "; duration: 300; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: 'qrc:/icons/left-arrow2.svg'
                        width: 28.5
                        height: 20

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: darktheme == false? "#42454F" : "#0ED8D2"
                        }
                    }
                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            backButton1.color = "#0ED8D2"
                            backButton1.opacity = 0.5
                        }

                        onReleased: {
                            backButton1.color = darktheme == false? "#2A2C31" : "#14161B"
                            backButton1.opacity = 0.1
                        }

                        onClicked: {
                            if (coinTracker == 1) {
                                countWallets()
                                coinTracker = 0
                            }
                        }
                    }
                }

                Controls.AddCoinModal{
                    z: 3
                    id: addCoinModal
                    visible: addCoinTracker == 1
                }

                Rectangle {
                    id: homeHeader
                    z: 4.1
                    width: parent.width
                    height: 150
                    anchors.top: parent.top
                    color: "#1B2934"

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                DropShadow {
                    z: 6
                    anchors.fill: iconBar3
                    source: iconBar3
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.4
                    transparentBorder: true
                }

                Rectangle {
                    id: iconBar3
                    z: 6
                    width: Screen.width
                    height: 30
                    anchors.verticalCenter: flipable.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: darktheme == false? "#42454F" : "#2A2B31"
                }

                Flipable {
                    id: flipable
                    z: 6
                    width: Screen.Width
                    height: 30
                    anchors.top: homeHeader.bottom
                    anchors.horizontalCenter: homeHeader.horizontalCenter

                    front:
                        Item {

                        Rectangle {
                            id: iconBar
                            z: 6
                            width: Screen.width
                            height: 30
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: darktheme == false? "#14161B" : "black"
                            Label {
                                id: transfer
                                z: 6
                                text: "TRANSFER"
                                font.pixelSize: 13
                                font.family: xciteMobile.name
                                color: "white"
                                anchors.left: parent.left
                                anchors.leftMargin: 28
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: 2
                                font.bold: true

                                Rectangle {
                                    id: transferButton
                                    anchors.left: transfer.left
                                    anchors.right: transfer2.right
                                    height: iconBar.height
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.verticalCenterOffset: -2
                                    color: "transparent"
                                }

                                Image {
                                    id: transfer2
                                    anchors.verticalCenter: transfer.verticalCenter
                                    anchors.verticalCenterOffset: -2
                                    anchors.left: parent.right
                                    anchors.leftMargin: 8
                                    source: 'qrc:/icons/icon-transfer_01.svg'
                                    width: 15
                                    height: 18
                                    ColorOverlay {
                                        anchors.fill: transfer2
                                        source: transfer2
                                        color: maincolor
                                    }
                                }

                                MouseArea {
                                    anchors.fill: transferButton

                                    onPressed: { click01.play() }

                                    onReleased: {

                                    }

                                    onClicked: {
                                        if (transferTracker == 0 && addCoinTracker == 0) {
                                            switchState = 0
                                            transferTracker = 1
                                        }
                                    }
                                }

                            }

                            Image {
                                id: coins
                                z: 6
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 28
                                source: 'qrc:/icons/icon-coins_01.svg'
                                width: 16
                                height: 16

                                ColorOverlay {
                                    anchors.fill: coins
                                    source: coins
                                    color: maincolor
                                }

                                Label {
                                    id: addCoin
                                    text: "COINS"
                                    font.pixelSize: 13
                                    font.family: xciteMobile.name
                                    color: "white"
                                    anchors.right: parent.left
                                    anchors.rightMargin: 8
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.verticalCenterOffset: 2
                                    font.bold: true
                                }

                                Rectangle {
                                    id: addCoinButton
                                    anchors.right: coins.right
                                    anchors.left: addCoin.left
                                    height: iconBar.height
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: "transparent"

                                    Timer {
                                        id: timer2
                                        interval: 300
                                        repeat: false
                                        running: false

                                        onTriggered: addCoinTracker = 0
                                    }

                                    MouseArea {
                                        anchors.fill: parent

                                        onPressed: { click01.play() }

                                        onReleased: {

                                        }

                                        onClicked: {
                                            if (addCoinTracker == 1) {
                                                addCoinModal.sidebarState = "closed"
                                                timer2.start()
                                            }
                                            if (transferTracker == 0 && addCoinTracker == 0){
                                                addCoinTracker = 1
                                                addCoinModal.sidebarState = "open"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    back:

                        Item {

                        transform: Rotation {
                            //origin.x: flipable.width/2
                            origin.y: flipable.height/2
                            axis.x: 1; axis.y: 0; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                            angle: 180    // the default angle
                        }

                        Rectangle {
                            id: iconBar2
                            z: 6
                            width: Screen.width
                            height: 30
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: darktheme == false? "#14161B" : "black"

                            Label {
                                id: btcValue
                                z: 6
                                text: getValue(getName(coinIndex)) + " BTC"
                                font.pixelSize: 13
                                font.family: xciteMobile.name
                                color: "white"
                                anchors.left: parent.left
                                anchors.leftMargin: 42
                                anchors.verticalCenter: iconBar2.verticalCenter
                                anchors.verticalCenterOffset: 2
                            }

                            Label {
                                property int decimals: (getValue(getName(coinIndex)) * valueBTCUSD) <= 1 ? 4 : 2
                                id: fiatValue
                                z: 6
                                text: "$" + (getValue(getName(coinIndex)) * valueBTCUSD).toLocaleString(Qt.locale("en_US"), "f", decimals)
                                font.pixelSize: 13
                                font.family: xciteMobile.name
                                color: "white"
                                anchors.horizontalCenter: parent.left
                                anchors.horizontalCenterOffset: (btcValue.x + btcValue.implicitWidth) + (((coinPercentage.x) - (btcValue.x + btcValue.implicitWidth))/2)
                                anchors.verticalCenter: iconBar2.verticalCenter
                                anchors.verticalCenterOffset: 2
                            }

                            Label {
                                id: coinPercentage
                                z: 6
                                text: getPercentage(getName(coinIndex)) >= 0? (getPercentage(getName(coinIndex)) + " %") : ("-" + getPercentage(getName(coinIndex)) + " %")
                                font.pixelSize: 13
                                font.family: xciteMobile.name
                                color: getPercentage(getName(coinIndex)) <= 0 ? "#E55541" : "#4BBE2E"
                                anchors.right: parent.right
                                anchors.rightMargin: 42
                                anchors.verticalCenter: iconBar2.verticalCenter
                                anchors.verticalCenterOffset: 2
                                font.bold: true
                            }
                        }
                    }

                    transform: Rotation {
                        id: rotation
                        origin.x: flipable.width/2
                        origin.y: flipable.height/2
                        axis.x: 1; axis.y: 0; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                        angle: 0    // the default angle
                    }

                    states: State {
                        name: "back"
                        PropertyChanges { target: rotation; angle: 180 }
                        when: coinTracker == 1
                    }

                    transitions: Transition {
                        NumberAnimation { target: rotation; property: "angle"; duration: 700 }
                    }
                }

            }

            Item {
                id: addressBookForm

                Item {
                    id: contact
                    z: 5
                    height: lastName.implicitHeight
                    anchors.verticalCenter: bigPhoto.verticalCenter
                    width: homeHeader2.width -140
                    anchors.left: parent.left
                    anchors.leftMargin: homeHeader2.width + 25
                    state: contactTracker == 0? "hidden" : "inView"
                    visible: x < parent.width

                    states: [
                        State {
                            name: "hidden"
                            PropertyChanges { target: contact; anchors.leftMargin: homeHeader2.width + 25}
                        },
                        State {
                            name: "inView"
                            PropertyChanges { target: contact; anchors.leftMargin: bigPhoto.width + 40}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: contact; property: "anchors.leftMargin"; duration: 700; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Label {
                        id: firstName
                        z: 5
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        text: contactTracker == 1? contactList.get(contactIndex).firstName : ""
                        font.pixelSize: 20
                        font.family:  xciteMobile.name
                        color: "#E5E5E5"
                    }

                    Label {
                        id: lastName
                        z: 5
                        anchors.left: firstName.right
                        anchors.leftMargin: firstName.text == ""? 0 : 5
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        text: contactTracker == 1? contactList.get(contactIndex).lastName : ""
                        color: "#E5E5E5"
                        font.pixelSize: 20
                        font.family:  xciteMobile.name
                        font.capitalization: Font.AllUppercase
                        elide: Text.ElideRight
                    }
                }

                DropShadow {
                    id: bigPhotoShadow
                    z: 5
                    anchors.fill: bigPhoto
                    source: bigPhoto
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color:"black"
                    opacity: 0.4
                    transparentBorder: true
                    visible: bigPhoto.visible
                }

                Image {
                    id: bigPhoto
                    z: 5
                    source: contactList.get(contactIndex).photo
                    height: 70
                    width: 70
                    anchors.bottom: homeHeader2.bottom
                    anchors.bottomMargin: 15
                    anchors.left: parent.left
                    anchors.leftMargin: -95
                    state: contactTracker == 0 ? "hidden" : "inView"
                    visible: (x + 70) >= 0

                    states: [
                        State {
                            name: "hidden"
                            PropertyChanges { target: bigPhoto; anchors.leftMargin: -95}
                        },
                        State {
                            name: "inView"
                            PropertyChanges { target: bigPhoto; anchors.leftMargin: 55/2}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: bigPhoto; property: "anchors.leftMargin"; duration: 700; easing.type: Easing.InOutCubic}
                        }
                    ]
                }

                Controls.TextInput {
                    id: searchForAddress
                    z: 5
                    height: 34
                    placeholder: "SEARCH ADDRESS BOOK"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: homeHeader2.bottom
                    anchors.bottomMargin: 25
                    width: Screen.width - 55
                    color: searchForAddress.text != "" ? "#F2F2F2" : "#727272"
                    textBackground: "#0B0B09"
                    font.pixelSize: 14
                    font.capitalization: Font.AllUppercase
                    mobile: 1
                    addressBook: 1
                    onTextChanged: searchCriteria = searchForAddress.text
                    visible: width > 0
                    state: contactTracker == 1? "hidden" : "inView"

                    states: [
                        State {
                            name: "hidden"
                            PropertyChanges { target: searchForAddress; height: 0}
                            PropertyChanges { target: searchForAddress; width: 0}
                            PropertyChanges { target: searchForAddress; anchors.bottomMargin: -30}
                        },
                        State {
                            name: "inView"
                            PropertyChanges { target: searchForAddress; height: 34}
                            PropertyChanges { target: searchForAddress; width: Screen.width - 55}
                            PropertyChanges { target: searchForAddress; anchors.bottomMargin: 25}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: searchForAddress; properties: "height, width, anchors.bottomMargin"; duration: 700; easing.type: Easing.InOutCubic}
                        }
                    ]
                }

                Rectangle {
                    id: scrollAreaContactList
                    z: 3
                    width: Screen.width
                    height: Screen.height - 240
                    anchors.top: parent.top
                    anchors.topMargin: 190
                    color: "transparent"
                    state: (contactTracker == 0 && scrollAreaAddressBook.height == 0)? "down" : "up"

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: scrollAreaContactList; height: 0}
                            PropertyChanges { target: scrollAreaContactList; anchors.topMargin: 50}
                            PropertyChanges { target: myContacts; cardSpacing: -88}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: scrollAreaContactList; height: Screen.height - 240}
                            PropertyChanges { target: scrollAreaContactList; anchors.topMargin: 190}
                            PropertyChanges { target: myContacts; cardSpacing: 0}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: scrollAreaContactList; properties: "height, anchors.topMargin"; duration: 500; easing.type: Easing.InOutCubic}
                            NumberAnimation { target: myContacts; property: "cardSpacing"; duration: 500; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Controls.Contacts {
                        id: myContacts
                        searchFilter: searchCriteria
                        cardSpacing: 0
                    }
                }

                Rectangle {
                    id:scrollAreaAddressBook
                    z: 3
                    width: Screen.width
                    height: Screen.height - 240
                    anchors.top: parent.top
                    anchors.topMargin: 190
                    color: "transparent"
                    state: (contactTracker == 1 && scrollAreaContactList.height == 0)? "down" : "up"

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: scrollAreaAddressBook; height: 0}
                            PropertyChanges { target: scrollAreaAddressBook; anchors.topMargin: 50}
                            PropertyChanges { target: myAddressCards; cardSpacing: -88}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: scrollAreaAddressBook; height: Screen.height - 240}
                            PropertyChanges { target: scrollAreaAddressBook; anchors.topMargin: 190}
                            PropertyChanges { target: myAddressCards; cardSpacing: 0}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: scrollAreaAddressBook; properties: "height, anchors.topMargin"; duration: 500; easing.type: Easing.InOutCubic}
                            NumberAnimation { target: myAddressCards; property: "cardSpacing"; duration: 500; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Controls.AddressBook {
                        id: myAddressCards
                        cardSpacing: 0
                    }
                }

                Rectangle {
                    id: backButton3
                    z: 3.5
                    radius: 25
                    anchors.fill: backButton2
                    color: darktheme == false? "#2A2C31" : "#14161B"
                    opacity: 0.1
                    visible: backButton2.visible

                }

                DropShadow {
                    z: 3.5
                    anchors.fill: backButton2
                    source: backButton2
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.4
                    transparentBorder: true
                    visible: backButton2.visible
                }

                Rectangle {
                    id: backButton2
                    z: 3.5
                    height: 50
                    width: 50
                    radius: 25
                    anchors.right: parent.right
                    anchors.rightMargin: -110
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 50
                    color: "transparent"
                    border.color: darktheme == false? "#42454F" : "#0ED8D2"
                    border.width: 2
                    visible: anchors.rightMargin > -110
                    state: contactTracker == 1 ? "inView" : "hidden"

                    states: [
                        State {
                            name: "inView"
                            PropertyChanges { target: backButton2; anchors.rightMargin: 15}
                        },
                        State {
                            name: "hidden"
                            PropertyChanges { target: backButton2; anchors.rightMargin: -110}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: backButton2; properties: "anchors.rightMargin"; duration: 300; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: 'qrc:/icons/left-arrow2.svg'
                        width: 28.5
                        height: 20

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: darktheme == false? "#42454F" : "#0ED8D2"
                        }
                    }
                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            backButton3.color = "#0ED8D2"
                            backButton3.opacity = 0.5
                        }

                        onReleased: {
                            backButton3.color = darktheme == false? "#2A2C31" : "#14161B"
                            backButton3.opacity = 0.1
                        }

                        onClicked: {
                            if (addressQRTracker == 0) {
                                if (contactTracker == 1) {
                                    contactTracker = 0
                                }
                            }

                            else if (addressQRTracker == 1) {
                                addressQRTracker = 0
                            }
                        }
                    }
                }

                Rectangle {
                    id: addButton3
                    z: 3
                    radius: 25
                    anchors.fill: addButton2
                    color: darktheme == false? "#2A2C31" : "#14161B"
                    opacity: 0.1
                    visible: addButton2.visible

                }

                DropShadow {
                    z: 3
                    anchors.fill: addButton2
                    source: addButton2
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.4
                    transparentBorder: true
                    visible: addButton2.visible
                }

                Rectangle {
                    id: addButton2
                    z: 3
                    height: 50
                    width: 50
                    radius: 25
                    anchors.left: parent.left
                    anchors.leftMargin: -110
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 50
                    color: "transparent"
                    border.color: darktheme == false? "#42454F" : "#0ED8D2"
                    border.width: 2
                    visible: anchors.leftMargin > -110
                    state: (contactTracker == 1 && addressQRTracker == 0)? "inView" : "hidden"

                    states: [
                        State {
                            name: "inView"
                            PropertyChanges { target: addButton2; anchors.leftMargin: 15}
                        },
                        State {
                            name: "hidden"
                            PropertyChanges { target: addButton2; anchors.leftMargin: -110}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: addButton2; properties: "anchors.leftMargin"; duration: 300; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: 'qrc:/icons/icon-plus_01.svg'
                        width: 30
                        height: 30

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: darktheme == false? "#42454F" : "#0ED8D2"
                        }
                    }
                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            addButton3.color = "#0ED8D2"
                            addButton3.opacity = 0.5
                        }

                        onReleased: {
                            addButton3.color = darktheme == false? "#2A2C31" : "#14161B"
                            addButton3.opacity = 0.1
                        }

                        onClicked: {
                            addAddressTracker = 1
                        }
                    }
                }

                Controls.QrCode{
                    id: addressDetails
                    z: 3
                    width: Screen.width
                    height: Screen.height - 180
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: iconBar6.bottom
                    anchors.topMargin: - (Screen.height - 180)
                    visible: anchors.topMargin > - (Screen.height - 180)
                    state: addressQRTracker == 1 ? "inView" : "hidden"

                    states: [
                        State {
                            name: "inView"
                            PropertyChanges { target: addressDetails; anchors.topMargin: 0}
                        },
                        State {
                            name: "hidden"
                            PropertyChanges { target: addressDetails; anchors.topMargin: -(Screen.height - 180)}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: addressDetails; properties: "anchors.topMargin"; duration: 500; easing.type: Easing.InOutCubic}
                        }
                    ]
                }



                Rectangle {
                    id: homeHeader2
                    z: 4.1
                    width: parent.width
                    height: 150
                    anchors.top: parent.top
                    color: "#1B2934"
                    MouseArea {
                        anchors.fill: parent
                    }
                }

                DropShadow {
                    z: 6
                    anchors.fill: iconBar6
                    source: iconBar6
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.4
                    transparentBorder: true
                }

                Rectangle {
                    id: iconBar6
                    z: 6
                    width: Screen.width
                    height: 30
                    anchors.verticalCenter: flipable2.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: darktheme == false? "#42454F" : "#2A2B31"
                }

                Flipable {
                    id: flipable2
                    z: 6
                    width: Screen.Width
                    height: 30
                    anchors.top: homeHeader2.bottom
                    anchors.horizontalCenter: homeHeader2.horizontalCenter

                    front:
                        Item {

                        Rectangle {
                            id: iconBar4
                            z: 6
                            width: Screen.width
                            height: 30
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: darktheme == false? "#14161B" : "black"
                            Label {
                                id: transfer3
                                z: 6
                                text: "TRANSFER"
                                font.pixelSize: 13
                                font.family: xciteMobile.name
                                color: "white"
                                anchors.left: parent.left
                                anchors.leftMargin: 28
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: 2
                                font.bold: true

                                Image {
                                    id: transfer4
                                    anchors.verticalCenter: transfer3.verticalCenter
                                    anchors.verticalCenterOffset: -2
                                    anchors.left: parent.right
                                    anchors.leftMargin: 8
                                    source: 'qrc:/icons/icon-transfer_01.svg'
                                    width: 15
                                    height: 18
                                    ColorOverlay {
                                        anchors.fill: transfer4
                                        source: transfer4
                                        color: maincolor
                                    }
                                }

                                Rectangle {
                                    id: transferButton2
                                    anchors.left: transfer3.left
                                    anchors.right: transfer4.right
                                    height: iconBar4.height
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.verticalCenterOffset: -2
                                    color: "transparent"
                                }

                                MouseArea {
                                    anchors.fill: transferButton2

                                    onPressed: { click01.play() }

                                    onClicked: {
                                        if (transferTracker == 0 && addAddressTracker == 0) {
                                            switchState = 0
                                            transferTracker = 1
                                        }
                                    }
                                }

                            }

                            Image {
                                id: plus
                                z: 6
                                anchors.verticalCenter: iconBar4.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 28
                                source: 'qrc:/icons/add_address.svg'
                                width: 16
                                height: 16
                                visible: pageTracker == 1

                                ColorOverlay {
                                    anchors.fill: plus
                                    source: plus
                                    color: maincolor
                                }

                                Label {
                                    id: addContact
                                    text: "ADD CONTACT"
                                    font.pixelSize: 13
                                    font.family: xciteMobile.name
                                    color: "white"
                                    anchors.right: parent.left
                                    anchors.rightMargin: 8
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.verticalCenterOffset: 2
                                    font.bold: true
                                }

                                Rectangle {
                                    id: addContactButton
                                    anchors.left: addContact.left
                                    anchors.right: plus.right
                                    height: iconBar4.height
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: "transparent"

                                    MouseArea {
                                        anchors.fill: addContactButton

                                        onPressed: { click01.play() }

                                        onReleased: {

                                        }

                                        onClicked: {
                                            if (transferTracker == 0 && addContactTracker == 0) {
                                                addContactTracker = 1
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    back:

                        Item {

                        transform: Rotation {
                            origin.y: flipable2.height/2
                            axis.x: 1; axis.y: 0; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                            angle: 180    // the default angle
                        }

                        Rectangle {
                            id: iconBar5
                            z: 6
                            width: Screen.width
                            height: 30
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: darktheme == false? "#14161B" : "black"

                            MouseArea {
                                anchors.fill: parent
                            }

                            Image {
                                id: chatIcon
                                source: "qrc:/icons/icon-chat_01.svg"
                                width: 19
                                height: 17
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.right
                                anchors.horizontalCenterOffset: -38

                                ColorOverlay {
                                    anchors.fill: parent
                                    source: parent
                                    color: contactList.get(contactIndex).chatID !== ""? maincolor : "#535353"
                                }
                            }

                            Image {
                                id: mailIcon
                                source: "qrc:/icons/icon-mail_01.svg"
                                width: 19
                                height: 12
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.right
                                anchors.horizontalCenterOffset: -98

                                ColorOverlay {
                                    anchors.fill: parent
                                    source: parent
                                    color: contactList.get(contactIndex).mailAddress !== ""? maincolor : "#535353"
                                }

                                MouseArea {
                                    width: 30
                                    height: 30
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter

                                    onPressed: { click01.play() }

                                    onClicked: {
                                        if(contactList.get(contactIndex).mailAddress !== "") {
                                            Qt.openUrlExternally('mailto:' + contactList.get(contactIndex).mailAddress)
                                        }
                                    }
                                }
                            }

                            Image {
                                id: cellIcon
                                source: "qrc:/icons/icon-cell_01.svg"
                                width: 12
                                height: 20
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.right
                                anchors.horizontalCenterOffset: -158

                                ColorOverlay {
                                    anchors.fill: parent
                                    source: parent
                                    color: contactList.get(contactIndex).cellNR !== ""? maincolor : "#535353"
                                }

                                MouseArea {
                                    width: 30
                                    height: 30
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter

                                    onPressed: { click01.play() }

                                    onClicked: {
                                        if(contactList.get(contactIndex).cellNR !== "") {
                                            cellTracker = 1
                                        }
                                    }
                                }
                            }

                            Image {
                                id: phoneIcon
                                source: "qrc:/icons/icon-phone_02.svg"
                                width: 20
                                height: 16
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.right
                                anchors.horizontalCenterOffset: -218

                                ColorOverlay {
                                    anchors.fill: parent
                                    source: parent
                                    color: contactList.get(contactIndex).telNR !== ""? maincolor : "#535353"
                                }


                                MouseArea {
                                    width: 30
                                    height: 30
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter

                                    onPressed: { click01.play() }

                                    onClicked: {
                                        if(contactList.get(contactIndex).telNR !== "") {
                                            Qt.openUrlExternally('tel:' + contactList.get(contactIndex).telNR)
                                        }
                                    }
                                }
                            }

                        }
                    }

                    transform: Rotation {
                        id: rotation2
                        origin.x: flipable2.width/2
                        origin.y: flipable2.height/2
                        axis.x: 1; axis.y: 0; axis.z: 0
                        angle: 0
                    }

                    states: State {
                        name: "back"
                        PropertyChanges { target: rotation2; angle: 180 }
                        when: contactTracker == 1
                    }

                    transitions: Transition {
                        NumberAnimation { target: rotation2; property: "angle"; duration: 700 }
                    }
                }
            }
        }

        Item {
            id: callText
            z: 7
            width: Screen.width
            height: Screen.height
            anchors.horizontalCenter: Screen.horizontalCenter
            anchors.verticalCenter: Screen.verticalCenter
            visible: cellTracker == 1 && callTextModal.height > 0

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent

                    onClicked:{
                        cellTracker = 0
                    }
                }

                DropShadow {
                    anchors.fill: callTextModal
                    source: callTextModal
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color: "black"
                    opacity: 0.4
                    transparentBorder: true
                }

                Rectangle {
                    id: callTextModal
                    width: 140
                    height: 50
                    radius: 4
                    color: "#34363D"
                    anchors.verticalCenter: parent.top
                    anchors.verticalCenterOffset: 165
                    anchors.horizontalCenter: parent.right
                    anchors.horizontalCenterOffset: - 158
                    state: cellTracker == 1? "inView" : "hidden"

                    states: [
                        State {
                            name: "inView"
                            PropertyChanges { target: callTextModal; width: 140}
                            PropertyChanges { target: callTextModal; height: 50}
                        },
                        State {
                            name: "hidden"
                            PropertyChanges { target: callTextModal; width: 0}
                            PropertyChanges { target: callTextModal; height: 0}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: callTextModal; properties: "width, height"; duration: 150; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Image {
                        id: callIcon
                        source: "qrc:/icons/icon-phone_01.svg"
                        width: 30
                        height: 30
                        anchors.verticalCenter: parent.top
                        anchors.verticalCenterOffset: 25
                        anchors.horizontalCenter: parent.left
                        anchors.horizontalCenterOffset: 35
                        visible: callTextModal.height == 50

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: maincolor
                        }


                        MouseArea {
                            width: 30
                            height: 30
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            onPressed: { click01.play() }

                            onClicked: {
                                Qt.openUrlExternally('tel:' + contactList.get(contactIndex).cellNR)
                                cellTracker = 0
                            }
                        }
                    }

                    Image {
                        id: textIcon
                        source: "qrc:/icons/icon-pen_01.svg"
                        width: 30
                        height: 30
                        anchors.verticalCenter: parent.top
                        anchors.verticalCenterOffset: 25
                        anchors.horizontalCenter: parent.right
                        anchors.horizontalCenterOffset: -35
                        visible: callTextModal.height == 50

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: maincolor
                        }


                        MouseArea {
                            width: 30
                            height: 30
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            onPressed: { click01.play() }

                            onClicked: {
                                Qt.openUrlExternally('sms:' + contactList.get(contactIndex).cellNR)
                                cellTracker = 0
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: homeHeader3
            z: 6
            width: parent.width
            height: 150
            anchors.top: parent.top
            color: "transparent"
            visible: loginTracker == 1

            Image {
                id: apps
                source: '../icons/mobile-menu.svg'
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: headingLayout.verticalCenter
                width: 22
                height: 17

                ColorOverlay {
                    anchors.fill: apps
                    source: apps
                    color: maincolor
                }

                MouseArea {
                    anchors.fill: parent

                    onPressed: { click01.play() }

                    onClicked: {
                        if (transferTracker == 0 && coinTracker == 0 && addressTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0) {
                            appsTracker = 1
                        }
                    }
                }
            }

            Image {
                id: darklight
                anchors.right: parent.right
                anchors.rightMargin: 30
                anchors.verticalCenter: headingLayout.verticalCenter
                source: 'qrc:/icons/icon-darklight.svg'
                width: 25
                height: 25

                ColorOverlay {
                    anchors.fill: darklight
                    source: darklight
                    color: darktheme == true? "#757575" : maincolor
                }

                Rectangle {
                    width: darklight.width
                    height: darklight.height
                    anchors.right: parent.right
                    anchors.verticalCenter: darklight.verticalCenter
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressed: { click01.play() }

                        onClicked: {
                            if (transferTracker == 0 && addressTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0 && darktheme == true) {
                                darktheme = false
                            }
                            else if (transferTracker == 0 && addressTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0 && darktheme == false) {
                                darktheme = true
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: topBar
                width: Screen.width
                height: 50
                color: "transparent"
            }

            Rectangle {
                id: headingSquare
                height: 30
                width: 210
                radius: 4
                anchors.verticalCenter: topBar.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: darktheme == false? "#14161B" : "black"
            }

            RowLayout {
                id: headingLayout
                anchors.verticalCenter: topBar.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                visible: transferTracker == 0 && addAddressTracker == 0 && addressTracker == 0

                Label {
                    id: overview
                    z: 6
                    text: "OVERVIEW"
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    font.bold: true
                    color: pageTracker == 0 ? maincolor : "#757575"

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            view.currentIndex = 0
                        }
                    }
                }

                Label {
                    id: add5
                    z: 6
                    text: "ADDRESS BOOK"
                    font.pixelSize: 12
                    font.family: xciteMobile.name
                    color: pageTracker == 0 ? "#757575" : maincolor
                    font.bold: true

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            if (addCoinTracker == 0)
                                view.currentIndex = 1
                        }
                    }
                }
            }


        }

        Rectangle {
            id: darkOverlay
            color: "black"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            height: parent.height
            width: parent.width
            z: 6
            state: (walletTracker == 1 || historyTracker == 1 || transferTracker == 1 || addressTracker == 1 || addAddressTracker == 1 || addContactTracker == 1 || editContactTracker == 1) ? "dark" : ((appsTracker == 1)? "medium" : "clear")

            MouseArea {
                anchors.fill: parent
                visible: walletTracker == 1 || historyTracker == 1 || transferTracker == 1 || addressTracker == 1 || addAddressTracker == 1 || addContactTracker == 1 || editContactTracker == 1
            }

            states: [
                State {
                    name: "dark"
                    PropertyChanges { target: darkOverlay; opacity: 0.95}
                },
                State {
                    name: "medium"
                    PropertyChanges { target: darkOverlay; opacity: 0.5}
                },
                State {
                    name: "clear"
                    PropertyChanges { target: darkOverlay; opacity: 0}
                }
            ]

            transitions: [
                Transition {
                    from: "*"
                    to: "*"
                    NumberAnimation { target: darkOverlay; property: "opacity"; duration: 300}
                }
            ]
        }

        Controls.HistoryModal {
            id: historyModal
            z: 10
        }

        Controls.AddContact {
            id: contactModal
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
        }

        Controls.ContactModal {
            id: editContactModal
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
        }

        Controls.TransferModal{
            id: transferModal
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
        }

        Controls.AddressModal{
            id: addressModal
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
        }

        Controls.AddAddressModal{
            id: addAddressModal
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
        }

        Controls.QrScanner{
            id: qrScanner
            z: 10
            anchors.horizontalCenter: backgroundHome.horizontalCenter
            anchors.top: backgroundHome.top
            anchors.topMargin: 50
        }

        Controls.Sidebar{
            z: 100
            anchors.left: parent.left
            anchors.top: parent.top
        }
    }
}
