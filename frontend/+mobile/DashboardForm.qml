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

    onPageTrackerChanged: detectInteraction()

    Rectangle {
        id: backgroundHome
        z: 1
        width: Screen.width
        height: Screen.height
        color: darktheme == true? "#14161B" : "#FDFDFD"

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(0, parent.height)
            opacity: 0.05
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#00162124"}
                GradientStop { position: 1.0; color: "#FF162124"}
            }
        }
    }

    Rectangle {
        id: homeView
        z: 1
        width: Screen.width
        height: Screen.height
        color: "transparent"
        state: (walletTracker == 1 || historyTracker == 1 || transferTracker == 1 || addressTracker == 1 || addAddressTracker == 1 || addContactTracker == 1 || editContactTracker == 1) ? "dark" : ((appsTracker == 1)? "medium" : "clear")
        clip: true

        states: [
            State {
                name: "dark"
                PropertyChanges { target: homeView; opacity: 0.5}
            },
            State {
                name: "medium"
                PropertyChanges { target: homeView; opacity: 0.75}
            },
            State {
                name: "clear"
                PropertyChanges { target: homeView; opacity: 1}
            }
        ]



        SwipeView {
            id: view
            z: 2
            currentIndex: 0
            anchors.fill: parent
            interactive: (appsTracker == 1 || transferTracker == 1 || addressTracker == 1 || addAddressTracker == 1 || addCoinTracker == 1) ? false : true
            clip: true

            Item {
                id: dashForm

                Image {
                    id: bigLogo
                    z: 5
                    source: getLogoBig(getName(coinIndex))
                    height: 139
                    width: 160
                    fillMode: Image.PreserveAspectFit
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    anchors.left: parent.left
                    state: coinTracker == 0? "hidden" : "inView"

                    LinearGradient {
                        width: parent.width
                        height: 55
                        start: Qt.point(x, y)
                        end: Qt.point(x, y + 55)
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: darktheme == true? "#FF14161B" : "#FFFDFDFD" }
                            GradientStop { position: 1.0; color: "transparent" }
                        }
                    }

                    states: [
                        State {
                            name: "hidden"
                            PropertyChanges { target: bigLogo; anchors.leftMargin: -160}
                        },
                        State {
                            name: "inView"
                            PropertyChanges { target: bigLogo; anchors.leftMargin: -40}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: bigLogo; property: "anchors.leftMargin"; duration: 700; easing.type: Easing.InOutCubic}
                        }
                    ]
                }

                Item {
                    id: totalWalletValue
                    z:5
                    width: valueTicker.implicitWidth + value1.implicitWidth + value2.implicitWidth
                    height: value1.implicitHeight
                    anchors.verticalCenter: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenterOffset: 95
                    state: (coinTracker == 0)? "up" : "down"
                    onStateChanged: detectInteraction()

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            detectInteraction()
                        }

                        onClicked: {
                            sumBalance()
                        }

                        onDoubleClicked: {

                        }
                    }

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: totalWalletValue; anchors.horizontalCenterOffset: 0}
                            PropertyChanges { target: portfolio; opacity:1}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: totalWalletValue; anchors.horizontalCenterOffset: Screen.width * 1.5}
                            PropertyChanges { target: portfolio; opacity:0}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            PropertyAnimation { target: totalWalletValue; property: "anchors.horizontalCenterOffset"; duration: 700; easing.type: Easing.InOutCubic}
                            PropertyAnimation { target: portfolio; property: "opacity"; duration: 700; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Label {
                        id: valueTicker
                        z: 5
                        anchors.left: totalWalletValue.left
                        anchors.bottom: value1.bottom
                        text: fiatTicker
                        font.pixelSize: totalBalance < 1000000? 60 : 40
                        font.family: xciteMobile.name
                        color: darktheme == true? "#F2F2F2" : "#14161B"
                    }

                    Label {
                        id: value1
                        z: 5
                        anchors.left: valueTicker.right
                        anchors.verticalCenter: totalWalletValue.verticalCenter
                        text: balanceArray[0]
                        font.pixelSize: totalBalance < 1000000? 60 : 40
                        font.family: xciteMobile.name
                        color: darktheme == true? "#F2F2F2" : "#14161B"
                    }

                    Label {
                        id: value2
                        z: 5
                        anchors.left: value1.right
                        anchors.bottom: value1.bottom
                        anchors.bottomMargin: 6
                        text: "." + balanceArray[1]
                        font.pixelSize: totalBalance < 1000000? 40 : 25
                        font.family: xciteMobile.name
                        color: darktheme == true? "#F2F2F2" : "#14161B"
                    }
                }

                Image {
                    id: portfolio
                    z: 5
                    source: darktheme == true? 'qrc:/icons/mobile/portfolio-icon_02_light.svg' : 'qrc:/icons/mobile/portfolio-icon_02_dark.svg'
                    width: 15
                    fillMode: Image.PreserveAspectFit
                    anchors.top: totalWalletValue.bottom
                    anchors.topMargin: totalBalance > 1000000? -5 : -15
                    anchors.left: parent.left
                    anchors.leftMargin: 28
                    visible: portfolio.opacity > 0

                    Rectangle {
                        width: 30
                        height: 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        color: "transparent"

                        MouseArea {
                            anchors.fill: parent

                            onPressed: {
                                detectInteraction()
                            }

                            onClicked: {
                                portfolioTracker = 1
                            }
                        }
                    }
                }

                Item {
                    id: coinInfo1
                    z:5
                    width: Screen.width - 56
                    height: fullName.height
                    anchors.top: parent.top
                    anchors.topMargin: 60
                    anchors.right: parent.right
                    state: (coinTracker == 0)? "down" : "up"

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: coinInfo1; anchors.rightMargin: 28}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: coinInfo1; anchors.rightMargin: Screen.width +20}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            PropertyAnimation { target: coinInfo1; property: "anchors.rightMargin"; duration: 700; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Label {
                        id: fullName
                        z: 5
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        text: getFullName(coinIndex)
                        horizontalAlignment: Text.AlignRight
                        font.pixelSize: 36
                        font.family: xciteMobile.name
                        font.letterSpacing: 2
                        font.capitalization: Font.AllUppercase
                        color: darktheme == true? "#F2F2F2" : "#14161B"
                        elide: Text.ElideRight
                    }
                }

                Label {
                    id: testnetLabel
                    z: 5
                    text: "TESTNET"
                    anchors.horizontalCenter: coinInfo1.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    font.pixelSize: 16
                    font.family: "Brandon Grotesque"
                    color: "#E55541"
                    font.letterSpacing: 2
                    visible: coinList.get(coinIndex).testnet
                }

                Item {
                    id: coinInfo2
                    z: 5
                    height: totalCoins.implicitHeight
                    anchors.top: coinInfo1.bottom
                    anchors.right: coinInfo1.right


                    Label {
                        id: totalCoins
                        z: 5
                        anchors.right: parent.right
                        anchors.top: parent.top
                        text: getName(coinIndex)
                        font.pixelSize: 20
                        font.family: xciteMobile.name
                        color: darktheme == true? "#F2F2F2" : "#14161B"

                    }

                    Label {
                        property int decimals: totalCoinsSum == 0? 2 : (totalCoinsSum <= 1000? 8 : (totalCoinsSum <= 1000000? 4 : 2))
                        property real totalCoinsSum: totalCoins.text === "XBY"? totalXBY :
                                                                                (totalCoins.text === "XFUEL"? totalXFUEL:
                                                                                                              (totalCoins.text === "XTEST"? totalXFUELTest :
                                                                                                                                            (totalCoins.text === "BTC"? totalBTC :
                                                                                                                                                                        (totalCoins.text === "ETH"? totalETH : 0))))
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
                        color: darktheme == true? "#F2F2F2" : "#14161B"
                    }

                    Label {
                        property int decimals: totalCoinsSum == 0? 2 : (totalCoinsSum <= 1000? 8 : (totalCoinsSum <= 1000000? 4 : 2))
                        property real totalCoinsSum:  totalCoins.text === "XBY"? totalXBY :
                                                                                 (totalCoins.text === "XFUEL"? totalXFUEL:
                                                                                                               (totalCoins.text === "XTEST"? totalXFUELTest :
                                                                                                                                             (totalCoins.text === "BTC"? totalBTC :
                                                                                                                                                                         (totalCoins.text === "ETH"? totalETH : 0))))
                        property var totalArray: (totalCoinsSum.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                        id: total2
                        z: 5
                        anchors.right: total1.left
                        anchors.bottom: totalCoins.bottom
                        text: totalArray[0]
                        font.pixelSize: 20
                        font.family: xciteMobile.name
                        color: darktheme == true? "#F2F2F2" : "#14161B"
                    }
                }

                Rectangle {
                    id:scrollAreaCoinList
                    z: 3
                    width: Screen.width
                    anchors.top: parent.top
                    color: "transparent"
                    state: (coinTracker == 0 && scrollAreaWalletList.height == 0)? "down" : "up"

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: scrollAreaCoinList; height: 0}
                            PropertyChanges { target: scrollAreaCoinList; anchors.topMargin: 0}
                            PropertyChanges { target: myCoinCards; cardSpacing: -100}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: scrollAreaCoinList; height: Screen.height - 180}
                            PropertyChanges { target: scrollAreaCoinList; anchors.topMargin: 180}
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
                    }

                }

                Rectangle {
                    id:scrollAreaWalletList
                    z: 3
                    width: Screen.width
                    anchors.top: parent.top
                    color: "transparent"
                    state: (coinTracker == 1 && scrollAreaCoinList.height == 0)? "down" : "up"

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: scrollAreaWalletList; height: 0}
                            PropertyChanges { target: scrollAreaWalletList; anchors.topMargin: 0}
                            PropertyChanges { target: myWalletCards; cardSpacing: -100}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: scrollAreaWalletList; height: Screen.height - 180}
                            PropertyChanges { target: scrollAreaWalletList; anchors.topMargin: 180}
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

                Item {
                    z: 3
                    width: Screen.width
                    height: coinTracker == 0? 50 : 125
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    LinearGradient {
                        anchors.fill: parent
                        start: Qt.point(x, y)
                        end: Qt.point(x, y + height)
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "transparent" }
                            GradientStop { position: 0.5; color: darktheme == true? "#14161B" : "#FDFDFD" }
                            GradientStop { position: 1.0; color: darktheme == true? "#14161B" : "#FDFDFD" }
                        }
                    }
                }

                Rectangle {
                    id: backButton1
                    z: 3
                    radius: 25
                    anchors.fill: backButton
                    color: darktheme == true? "#14161B" : "#FDFDFD"
                    opacity: 0.1
                    visible: backButton.visible

                }

                Rectangle {
                    id: backButton
                    z: 3
                    height: 50
                    width: 50
                    radius: 25
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 50
                    color: "transparent"
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
                        source: 'qrc:/icons/mobile/back-icon_01.svg'
                        width: 50
                        height: 50
                    }

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            backButton1.opacity = 0.5
                            detectInteraction()
                        }

                        onReleased: {
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

                Rectangle {
                    id: addButton5
                    z: 3
                    radius: 25
                    anchors.fill: addButton4
                    color: darktheme == true? "#14161B" : "#FDFDFD"
                    opacity: 0.1
                    visible: addButton4.visible

                }

                Rectangle {
                    id: addButton4
                    z: 3
                    height: 50
                    width: 50
                    radius: 25
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 50
                    color: "transparent"
                    visible: anchors.leftMargin > -110
                    state: coinTracker == 1 ? "inView" : "hidden"

                    states: [
                        State {
                            name: "inView"
                            PropertyChanges { target: addButton4; anchors.leftMargin: 15}
                        },
                        State {
                            name: "hidden"
                            PropertyChanges { target: addButton4; anchors.leftMargin: -110}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            NumberAnimation { target: addButton4; properties: "anchors.leftMargin"; duration: 300; easing.type: Easing.InOutCubic}
                        }
                    ]

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: 'qrc:/icons/mobile/add-icon_01.svg'
                        width: 50
                        height: 50

                    }

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            addButton5.opacity = 0.5
                            detectInteraction()
                        }

                        onReleased: {
                            addButton5.opacity = 0.1
                        }

                        onClicked: {
                            addWalletTracker = 1
                            walletAdded = false
                            selectedPage = "wallet"
                            mainRoot.push("qrc:/Controls/+mobile/AddWallet.qml")
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
                    color: darktheme == true? "#14161B" : "#FDFDFD"

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                Rectangle {
                    id: iconBar3
                    z: 6
                    width: Screen.width
                    height: 30
                    anchors.verticalCenter: flipable.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: darktheme == true? "#14161B" : "#FDFDFD"
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
                            color: "black"

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
                                    source: 'qrc:/icons/mobile/transfer-icon_01.svg'
                                    fillMode: Image.PreserveAspectFit
                                    height: 18
                                }

                                MouseArea {
                                    anchors.fill: transferButton

                                    onPressed: {
                                        click01.play()
                                        detectInteraction()
                                    }

                                    onReleased: {

                                    }

                                    onClicked: {
                                        if (transferTracker == 0 && addCoinTracker == 0) {
                                            selectedCoin = "XFUEL"
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
                                source: 'qrc:/icons/mobile/coin-icon_01.svg'
                                fillMode: Image.PreserveAspectFit
                                height: 18

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

                                        onPressed: {
                                            click01.play()
                                            detectInteraction()
                                        }

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
                            origin.y: flipable.height/2
                            axis.x: 1; axis.y: 0; axis.z: 0
                            angle: 180
                        }

                        Rectangle {
                            id: iconBar2
                            z: 6
                            width: Screen.width
                            height: 30
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "black"

                            Label {
                                property int decimals: getValue(getName(coinIndex)) >= 1? 4 : 8
                                id: btcValue
                                z: 6
                                text: (getValue(getName(coinIndex)).toLocaleString(Qt.locale("en_US"), "f", decimals)) + " BTC"
                                font.pixelSize: 13
                                font.family: xciteMobile.name
                                color: "white"
                                anchors.left: parent.left
                                anchors.leftMargin: 28
                                anchors.verticalCenter: iconBar2.verticalCenter
                                anchors.verticalCenterOffset: 2
                            }

                            Label {
                                property int decimals: (getValue(getName(coinIndex)) * valueBTC) <= 1 ? 4 : 2
                                id: fiatValue
                                z: 6
                                text: fiatTicker + (getValue(getName(coinIndex)) * valueBTC).toLocaleString(Qt.locale("en_US"), "f", decimals)
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
                                text: getPercentage(getName(coinIndex)) >= 0? ("+" + getPercentage(getName(coinIndex)) + " %") : (getPercentage(getName(coinIndex)) + " %")
                                font.pixelSize: 13
                                font.family: xciteMobile.name
                                color: getPercentage(getName(coinIndex)) < 0 ? "#E55541" : "#4BBE2E"
                                anchors.right: parent.right
                                anchors.rightMargin: 28
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
                        axis.x: 1; axis.y: 0; axis.z: 0
                        angle: 0
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
                    height: firstName.implicitHeight +  lastName.implicitHeight + 5
                    anchors.verticalCenter: bigPhoto.verticalCenter
                    width: homeHeader2.width -140
                    anchors.left: parent.left
                    state: contactTracker == 0? "hidden" : "inView"
                    visible: x < parent.width
                    onStateChanged: detectInteraction()

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
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.left: parent.left
                        text: contactTracker == 1? contactList.get(contactIndex).firstName : ""
                        horizontalAlignment: Text.AlignRight
                        color: darktheme == true? "#F2F2F2" : "#2A2C31"
                        font.pixelSize: 30
                        font.family:  xciteMobile.name
                        font.letterSpacing: 2
                        font.capitalization: Font.SmallCaps
                        elide: Text.ElideRight
                    }

                    Label {
                        id: lastName
                        z: 5
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        text: contactTracker == 1? contactList.get(contactIndex).lastName : ""
                        horizontalAlignment: Text.AlignRight
                        color: darktheme == true? "#F2F2F2" : "#2A2C31"
                        font.pixelSize: 30
                        font.family:  xciteMobile.name
                        font.letterSpacing: 2
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
                    placeholder: "SEARCH ADDRESS BOOK"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: homeHeader2.bottom
                    color: "#2A2C31"
                    textBackground: "#F2F2F2"
                    font.pixelSize: 14
                    font.capitalization: Font.AllUppercase
                    mobile: 1
                    addressBook: 1
                    deleteImg: 'qrc:/icons/mobile/delete-icon_01_dark.svg'

                    onTextChanged: {
                        detectInteraction()
                        searchCriteria = searchForAddress.text
                    }
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
                            PropertyChanges { target: searchForAddress; width: Screen.width - 56}
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
                    anchors.top: parent.top
                    color: "transparent"
                    state: (contactTracker == 0 && scrollAreaAddressBook.height == 0)? "down" : "up"

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: scrollAreaContactList; height: 0}
                            PropertyChanges { target: scrollAreaContactList; anchors.topMargin: 0}
                            PropertyChanges { target: myContacts; cardSpacing: -100}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: scrollAreaContactList; height: Screen.height - 180}
                            PropertyChanges { target: scrollAreaContactList; anchors.topMargin: 180}
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
                    }
                }

                Rectangle {
                    id:scrollAreaAddressBook
                    z: 3
                    width: Screen.width
                    anchors.top: parent.top
                    color: "transparent"
                    state: (contactTracker == 1 && scrollAreaContactList.height == 0)? "down" : "up"

                    states: [
                        State {
                            name: "up"
                            PropertyChanges { target: scrollAreaAddressBook; height: 0}
                            PropertyChanges { target: scrollAreaAddressBook; anchors.topMargin: 0}
                            PropertyChanges { target: myAddressCards; cardSpacing: -100}
                        },
                        State {
                            name: "down"
                            PropertyChanges { target: scrollAreaAddressBook; height: Screen.height - 180}
                            PropertyChanges { target: scrollAreaAddressBook; anchors.topMargin: 180}
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
                    }
                }

                Item {
                    z: 3
                    width: Screen.width
                    height: contactTracker == 0? 50 : 125
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    LinearGradient {
                        anchors.fill: parent
                        start: Qt.point(x, y)
                        end: Qt.point(x, y + height)
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "transparent" }
                            GradientStop { position: 0.5; color: darktheme == true? "#14161B" : "#FDFDFD" }
                            GradientStop { position: 1.0; color: darktheme == true? "#14161B" : "#FDFDFD" }
                        }
                    }
                }

                Rectangle {
                    id: backButton3
                    z: 3.5
                    radius: 25
                    anchors.fill: backButton2
                    color: darktheme == true? "#14161B" : "#FDFDFD"
                    opacity: 0.1
                    visible: backButton2.visible

                }

                Rectangle {
                    id: backButton2
                    z: 3.5
                    height: 50
                    width: 50
                    radius: 25
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 50
                    color: "transparent"
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
                        source: 'qrc:/icons/mobile/back-icon_01.svg'
                        width: 50
                        height: 50
                    }

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            backButton3.opacity = 0.5
                            detectInteraction()
                        }

                        onReleased: {
                            backButton3.opacity = 0.1
                        }

                        onClicked: {
                            if (addressQRTracker == 0) {
                                if (contactTracker == 1) {
                                    contactTracker = 0
                                    //contactIndex = 0
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
                    color: darktheme == true? "#14161B" : "#FDFDFD"
                    opacity: 0.1
                    visible: addButton2.visible

                }

                Rectangle {
                    id: addButton2
                    z: 3
                    height: 50
                    width: 50
                    radius: 25
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 50
                    color: "transparent"
                    visible: (anchors.leftMargin > -110) && contactIndex != 0
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
                        source: 'qrc:/icons/mobile/add-icon_01.svg'
                        width: 50
                        height: 50

                    }

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            addButton3.opacity = 0.5
                            detectInteraction()
                        }

                        onReleased: {
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
                    color: darktheme == true? "#14161B" : "#FDFDFD"

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                Rectangle {
                    id: iconBar6
                    z: 6
                    width: Screen.width
                    height: 30
                    anchors.verticalCenter: flipable2.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: darktheme == true? "#14161B" : "#FDFDFD"
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
                            color: "black"
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
                                    source: 'qrc:/icons/mobile/transfer-icon_01.svg'
                                    fillMode: Image.PreserveAspectFit
                                    height: 18
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

                                    onPressed: {
                                        click01.play()
                                        detectInteraction()
                                    }

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
                                source: 'qrc:/icons/mobile/contact-icon_01.svg'
                                fillMode: Image.PreserveAspectFit
                                height: 18
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

                                        onPressed: {
                                            click01.play()
                                            detectInteraction()
                                        }

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
                            axis.x: 1; axis.y: 0; axis.z: 0
                            angle: 180
                        }

                        Rectangle {
                            id: iconBar5
                            z: 6
                            width: Screen.width
                            height: 30
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "black"

                            MouseArea {
                                anchors.fill: parent
                            }

                            Image {
                                id: chatIcon
                                source: contactList.get(contactIndex).chatID !== ""? 'qrc:/icons/mobile/chat-icon_01_dark.svg' : 'qrc:/icons/mobile/chat-icon_01_light.svg'
                                width: 19
                                height: 17
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.right
                                anchors.horizontalCenterOffset: -38
                            }

                            Image {
                                id: mailIcon
                                source: contactList.get(contactIndex).mailAddress !== ""? 'qrc:/icons/mobile/mail-icon_01_dark.svg' : 'qrc:/icons/mobile/mail-icon_01_light.svg'
                                width: 19
                                height: 12
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.right
                                anchors.horizontalCenterOffset: -98

                                MouseArea {
                                    width: 30
                                    height: 30
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter

                                    onPressed: {
                                        click01.play()
                                        detectInteraction()
                                    }

                                    onClicked: {
                                        if(contactList.get(contactIndex).mailAddress !== "") {
                                            Qt.openUrlExternally('mailto:' + contactList.get(contactIndex).mailAddress)
                                        }
                                    }
                                }
                            }

                            Image {
                                id: cellIcon
                                source: contactList.get(contactIndex).cellNR !== ""? 'qrc:/icons/mobile/cell-icon_01_dark.svg' : 'qrc:/icons/mobile/cell-icon_01_light.svg'
                                width: 12
                                height: 20
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.right
                                anchors.horizontalCenterOffset: -158

                                MouseArea {
                                    width: 30
                                    height: 30
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter

                                    onPressed: {
                                        click01.play()
                                        detectInteraction()
                                    }

                                    onClicked: {
                                        if(contactList.get(contactIndex).cellNR !== "") {
                                            cellTracker = 1
                                        }
                                    }
                                }
                            }

                            Image {
                                id: phoneIcon
                                source: contactList.get(contactIndex).telNR !== ""? 'qrc:/icons/mobile/phone-icon_01_dark.svg' : 'qrc:/icons/mobile/phone-icon_01_light.svg'
                                width: 20
                                height: 16
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.right
                                anchors.horizontalCenterOffset: -218

                                MouseArea {
                                    width: 30
                                    height: 30
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter

                                    onPressed: {
                                        click01.play()
                                        detectInteraction()
                                    }

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

                    onPressed: {
                        detectInteraction()
                    }

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
                        source: 'qrc:/icons/mobile/call-icon_01.svg'
                        width: 30
                        height: 30
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.top
                        anchors.verticalCenterOffset: 25
                        anchors.horizontalCenter: parent.left
                        anchors.horizontalCenterOffset: 35
                        visible: callTextModal.height == 50

                        MouseArea {
                            width: 30
                            height: 30
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            onPressed: {
                                click01.play()
                                detectInteraction()
                            }

                            onClicked: {
                                Qt.openUrlExternally('tel:' + contactList.get(contactIndex).cellNR)
                                cellTracker = 0
                            }
                        }
                    }

                    Image {
                        id: textIcon
                        source: 'qrc:/icons/mobile/text-icon_01.svg'
                        width: 30
                        height: 30
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.top
                        anchors.verticalCenterOffset: 25
                        anchors.horizontalCenter: parent.right
                        anchors.horizontalCenterOffset: -35
                        visible: callTextModal.height == 50

                        MouseArea {
                            width: 30
                            height: 30
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            onPressed: {
                                click01.play()
                                detectInteraction()
                            }

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

            Image {
                id: apps
                source: 'qrc:/icons/mobile/menu-icon_01.svg'
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: headingLayout.verticalCenter
                width: 22
                height: 17

                Rectangle {
                    id: appsButton
                    width: 25
                    height: 25
                    color: "transparent"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    id: notifIndicator
                    width: 8
                    height: 8
                    radius: 4
                    color: "#E55541"
                    anchors.horizontalCenter: parent.right
                    anchors.verticalCenter: parent.top
                    visible: alertList.count > 1
                }

                MouseArea {
                    anchors.fill: appsButton

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if (transferTracker == 0 && addressTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0) {
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
                source: darktheme == true? 'qrc:/icons/mobile/theme_switch-icon_01_off.svg' : 'qrc:/icons/mobile/theme_switch-icon_01_on.svg'
                width: 25
                height: 25

                Rectangle {
                    width: darklight.width
                    height: darklight.height
                    anchors.right: parent.right
                    anchors.verticalCenter: darklight.verticalCenter
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            console.log("theme switch pushed")
                            if (transferTracker == 0 && addressTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0 && darktheme == true) {
                                userSettings.theme = "light"
                            }
                            else if (transferTracker == 0 && addressTracker == 0 && addAddressTracker == 0 && addCoinTracker == 0 && darktheme == false) {
                                userSettings.theme = "dark"
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
                            swipe.play()
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
                            swipe.play()
                            if (addCoinTracker == 0)
                                view.currentIndex = 1
                        }
                    }
                }
            }
        }
    }

    GaussianBlur {
        id: blurOverlay
        z:6
        anchors.fill: homeView
        source: homeView
        state: (appsTracker == 1)? "medium" : "clear"

        MouseArea {
            anchors.fill: parent
            visible: appsTracker == 1
        }

        states: [
            State {
                name: "medium"
                PropertyChanges { target: blurOverlay; opacity: 1}
                PropertyChanges { target: blurOverlay; radius: 8}
                PropertyChanges { target: blurOverlay; samples: 16}
                PropertyChanges { target: blurOverlay; deviation: 4}
            },
            State {
                name: "clear"
                PropertyChanges { target: blurOverlay; opacity: 0}
                PropertyChanges { target: blurOverlay; radius: 0}
                PropertyChanges { target: blurOverlay; samples: 0}
                PropertyChanges { target: blurOverlay; deviation: 0}
            }
        ]
    }

    Rectangle {
        id: darkOverlay
        color: darktheme == false? "#F7F7F7" : "#14161B"
        anchors.fill: homeView
        height: homeView.height
        width: homeView.width
        z: 6
        state: (walletTracker == 1 || historyTracker == 1 || transferTracker == 1 || addressTracker == 1 || addAddressTracker == 1 || addContactTracker == 1 || editContactTracker == 1) ? "dark" : ((appsTracker == 1)? "medium" : "clear")

        MouseArea {
            anchors.fill: parent
            visible: walletTracker == 1 || historyTracker == 1 || transferTracker == 1 || addressTracker == 1 || addAddressTracker == 1 || addContactTracker == 1 || editContactTracker == 1
        }

        LinearGradient {
            anchors.fill: parent
            source: parent
            start: Qt.point(0, 0)
            end: Qt.point(0, parent.height)
            opacity: darktheme == false? 0.05 : 0.2
            gradient: Gradient {
                GradientStop { position: 0.0; color: darktheme == false?"#00072778" : "#FF162124" }
                GradientStop { position: 1.0; color: darktheme == false?"#FF072778" : "#00162124" }
            }
        }

        states: [
            State {
                name: "dark"
                PropertyChanges { target: darkOverlay; opacity: 1}
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
        anchors.horizontalCenter: homeView.horizontalCenter
        anchors.top: homeView.top
    }

    Controls.AddContact {
        id: contactModal
        z: 10
        anchors.horizontalCenter: homeView.horizontalCenter
        anchors.top: homeView.top
    }

    Controls.ContactModal {
        id: editContactModal
        z: 10
        anchors.horizontalCenter: homeView.horizontalCenter
        anchors.top: homeView.top
    }

    Controls.TransferModal{
        id: transferModal
        z: 10
        anchors.horizontalCenter: homeView.horizontalCenter
        anchors.top: homeView.top
    }

    Controls.AddressModal{
        id: addressModal
        z: 10
        anchors.horizontalCenter: homeView.horizontalCenter
        anchors.top: homeView.top
    }

    Controls.AddAddressModal{
        id: addAddressModal
        z: 10
        anchors.horizontalCenter: homeView.horizontalCenter
        anchors.top: homeView.top
    }

    Controls.WalletModal {
        id: walletModal
        z: 10
        anchors.horizontalCenter: homeView.horizontalCenter
        anchors.top: homeView.top
    }

    Controls.PortfolioModal {
        id: myPortfolio
        z: 10
        anchors.horizontalCenter: homeView.horizontalCenter
        anchors.top: homeView.top
    }

    Controls.QrScanner {
        id: qrScanner
        z: 10
        anchors.horizontalCenter: homeView.horizontalCenter
        anchors.top: homeView.top
        visible: selectedPage == "home" && scanQRTracker == 1
    }

    Controls.Sidebar{
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Controls.LogOut {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Controls.Goodbey {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
    }

}
