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
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQrCode.Component 1.0
import "./Controls" as Controls

/**
  * Main page
  */
Item {
    property int sw: -1
    property int clickedSquare: 0
    property int clickedSquare2: 0
    property int clickedSquare3: 0
    property int clickedSquare4: 0
    property int clickedSquare5: 0
    property int clickedSquare6: 0
    property int appsTracker: 0
    property int transferTracker: 0
    z: 2

    Rectangle {
        z: 100
        color: "#2A2C31"
        opacity: 0.8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width
        height: 50
    }
    Rectangle {
        color: "black"
        opacity: .8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height
        width: parent.width
        z: 5
        visible: appsTracker == 1 || transferTracker == 1
    }
    Rectangle {
        color: "#34363D"
        anchors.top: transfer.bottom
        anchors.topMargin: 14
        anchors.left: parent.left
        height: parent.height
        width: parent.width
        z: 0
        visible: true
    }

    Loader {
        id: pageLoader
    }

    Controls.Header {
        id: heading
        text: qsTr("POSEY")
        showBack: false
        Layout.topMargin: 14
    }
    RowLayout {
        id: headingLayout
        anchors.top: heading.bottom
        anchors.topMargin: 10
        anchors.left: heading.left
        anchors.leftMargin: 100
        spacing: 20
        Label {
            id: overview
            text: "OVERVIEW"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#5E8BFE"
            Rectangle {
                id: titleLine
                width: overview.width
                height: 1
                color: "#5E8BFE"
                anchors.top: overview.bottom
                anchors.left: overview.left
                anchors.topMargin: 2
            }
        }

        Label {
            id: add5
            text: "ADDRESS BOOK"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: "#757575"

            MouseArea {
                anchors.fill: add5
                //onClicked: pageLoader.source = "MobileAddressBook.qml"
                onClicked: mainRoot.push("MobileAddressBook.qml")
            }
        }
    }

    Image {
        id: notif
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.verticalCenter: headingLayout.verticalCenter
        source: '../icons/notification_icon_03.svg'
        width: 30
        height: 30
    }

    Label {
        id: value
        anchors.top: parent.top
        anchors.topMargin: 90
        anchors.left: parent.left
        anchors.leftMargin: 20
        text: "$511,000.00"
        font.pixelSize: 36
        font.family: "Brandon Grotesque"
        color: "#E5E5E5"
        // font.weight: Font.DemiBold
    }

    Switch {
        id: switch1
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 90
        visible: transferTracker != 1
        width: 50
        height: 20

        transform: Rotation {
            origin.x: 25
            origin.y: 25
            angle: 90
        }

    }
    /**
    Label {
        id: week1
        text: "WEEK"
        font.pixelSize: 11
        font.bold: true
        font.family: "Brandon Grotesque"
        color: switch1.checked ? "#5F5F5F" : "#5E8BFE"
        anchors.right: switch1.left
        anchors.rightMargin: -5
        anchors.top: switch1.top
        anchors.topMargin: 40
    }
    Label {
        id: month1
        text: "MONTH"
        font.pixelSize: 11
        font.bold: true
        font.family: "Brandon Grotesque"
        color: switch1.checked ? "#5E8BFE" : "#5F5F5F"
        anchors.right: switch1.left
        anchors.leftMargin: 2
        anchors.bottom:switch1.bottom
    }
*/
    Label {
        id: transfer
        text: "TRANSFER"
        font.pixelSize: 13
        font.family: "Brandon Grotesque"
        color: "#C7C7C7"
        anchors.left: square1.left
        anchors.bottom: square1.top
        anchors.bottomMargin: 30
        font.bold: true
        Image {
            id: transfer2
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: 8
            source: '../icons/transfer_icon.svg'
            width: 18
            height: 18
            MouseArea {
                anchors.fill: transfer2
                onClicked: {
                    transferTracker = 1
                }
            }
        }
    }

    Label {
        id: addCoin
        text: "ADD COIN"
        font.pixelSize: 13
        font.family: "Brandon Grotesque"
        color: "#C7C7C7"
        anchors.right: square1.right
        anchors.bottom: square1.top
        anchors.bottomMargin: 30
        anchors.rightMargin: 24
        font.bold: true
        Image {
            id: plus
            anchors.verticalCenter: addCoin.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: 8
            source: '../icons/add_icon_03.svg'
            width: 18
            height: 18
        }
    }

    Controls.CurrencySquare {
        id: square1
        anchors.top: parent.top
        anchors.topMargin: 210
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/XBY_card_logo_colored_05.svg'
        currencyType2: "XBY"
        percentChange: "+%.8"
        gainLossTracker: 1
        amountSize: "22.5432"
        height: clickedSquare == 1 ? 166 : 75
        // since expandbutton is very tiny and hard to click we put an invisible rectangle here to mimic the dots
        Rectangle {
            id: expandButtonArea
            width: 40
            height: 15
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: "transparent"

            MouseArea {
                anchors.fill: expandButtonArea
                onClicked: {
                    if (clickedSquare == 1) {
                        clickedSquare = 0
                        return
                    }
                    if (clickedSquare == 0) {
                        clickedSquare = 1
                        clickedSquare5 = 0
                        clickedSquare4 = 0
                        clickedSquare3 = 0
                        clickedSquare2 = 0
                        return
                    }
                }
            }
        }
        Image {
            id: expandButton
            width: 25
            height: 5
            anchors.horizontalCenter: expandButtonArea.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }

        /**
          * Visible when square is clicked
          */
        Rectangle {
            id: dividerLine
            visible: clickedSquare == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: "Unconfirmed 55.42 XBY"
            font.family: "Brandon Grotesque"
            font.pointSize: 12
            font.italic: true
            color: "#919191"
            //font.weight: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: dividerLine.top
            visible: clickedSquare == 1 ? true : false
        }
        Rectangle {
            id: transferButton
            visible: clickedSquare == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine.bottom
            anchors.left: dividerLine.left
            anchors.topMargin: 15
            MouseArea {
                anchors.fill: transferButton
                onClicked: {
                    transferTracker = 1
                }
            }
            Text {
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton
            visible: clickedSquare == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine.bottom
            anchors.right: dividerLine.right
            anchors.topMargin: 15
            Text {
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
    Controls.CurrencySquare {
        id: square2
        anchors.top: square1.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/XFUEL_card_logo_colored_07.svg'
        currencyType2: "XFUEL"
        percentChange: "-%.8"
        gainLossTracker: 0
        amountSize: "22.5432"
        totalValue: "$43,443.94"
        value: "$9,839.99"
        height: clickedSquare2 == 1 ? 166 : 75
        // since expandbutton is very tiny and hard to click we put an invisible rectangle here to mimic the dots
        Rectangle {
            id: expandButtonArea2
            width: 40
            height: 15
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: expandButtonArea2
                onClicked: {
                    if (clickedSquare2 == 1) {
                        clickedSquare2 = 0
                        return
                    }
                    if (clickedSquare2 == 0) {
                        clickedSquare = 0
                        clickedSquare5 = 0
                        clickedSquare4 = 0
                        clickedSquare3 = 0
                        clickedSquare2 = 1
                        return
                    }
                }
            }
        }
        Image {
            id: expandButton2
            width: 25
            height: 5
            anchors.horizontalCenter: expandButtonArea2.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }

        /**
          * Visible when square is clicked
          */
        Rectangle {
            id: dividerLine2
            visible: clickedSquare2 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: "Unconfirmed 55.42 XFUEL"
            font.family: "Brandon Grotesque"
            font.pointSize: 12
            font.italic: true
            color: "#919191"
            //font.weight: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: dividerLine2.top
            visible: clickedSquare2 == 1 ? true : false
        }
        Rectangle {
            id: transferButton2
            visible: clickedSquare2 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine2.bottom
            anchors.left: dividerLine2.left
            anchors.topMargin: 15
            /**
            MouseArea {
                anchors.fill: transferButton2
                onClicked: {
                    transferTracker = 1
                }
            }
            */
            Text {
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton2
            visible: clickedSquare2 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine2.bottom
            anchors.right: dividerLine2.right
            anchors.topMargin: 15
            Text {
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Controls.CurrencySquare {
        id: square3
        anchors.top: square2.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/BTC-color.svg'
        currencyType2: "BTC"
        percentChange: "+%.8"
        gainLossTracker: 1
        amountSize: "22.5432"
        totalValue: "$43,443.94"
        value: "$9,839.99"
        height: clickedSquare3 == 1 ? 166 : 75
        Rectangle {
            id: expandButtonArea3
            width: 40
            height: 15
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: "transparent"

            MouseArea {
                anchors.fill: expandButtonArea3
                onClicked: {
                    if (clickedSquare3 == 1) {
                        clickedSquare3 = 0
                        return
                    }
                    if (clickedSquare3 == 0) {
                        clickedSquare3 = 1
                        clickedSquare5 = 0
                        clickedSquare4 = 0
                        clickedSquare = 0
                        clickedSquare2 = 0
                        return
                    }
                }
            }
        }
        Image {
            id: expandButton3
            width: 25
            height: 5
            anchors.horizontalCenter: expandButtonArea3.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }

        /**
          * Visible when square is clicked
          */
        Rectangle {
            id: dividerLine3
            visible: clickedSquare3 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: "Unconfirmed 55.42 BTC"
            font.family: "Brandon Grotesque"
            font.pointSize: 12
            font.italic: true
            color: "#919191"
            //font.weight: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: dividerLine3.top
            visible: clickedSquare3 == 1 ? true : false
        }
        Rectangle {
            id: transferButton3
            visible: clickedSquare3 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine3.bottom
            anchors.left: dividerLine3.left
            anchors.topMargin: 15
            /**
            MouseArea {
                anchors.fill: transferButton3
                onClicked: {
                    transferTracker = 1
                }
            }
            */
            Text {
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton3
            visible: clickedSquare3 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine3.bottom
            anchors.right: dividerLine3.right
            anchors.topMargin: 15
            Text {
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Controls.CurrencySquare {
        id: square4
        anchors.top: square3.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/ETH-color.svg'
        currencyType2: "ETH"
        percentChange: "-%.8"
        gainLossTracker: 0
        amountSize: "22.5432"
        totalValue: "$43,443.94"
        value: "$9,839.99"
        height: clickedSquare4 == 1 ? 166 : 75
        z: 0
        Rectangle {
            id: expandButtonArea4
            width: 40
            height: 15
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: "transparent"

            MouseArea {
                anchors.fill: expandButtonArea4
                onClicked: {
                    if (clickedSquare4 == 1) {
                        clickedSquare4 = 0
                        return
                    }
                    if (clickedSquare4 == 0) {
                        clickedSquare3 = 0
                        clickedSquare5 = 0
                        clickedSquare4 = 1
                        clickedSquare = 0
                        clickedSquare2 = 0
                        return
                    }
                }
            }
        }
        Image {
            id: expandButton4
            width: 25
            height: 5
            anchors.horizontalCenter: expandButtonArea4.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }

        /**
          * Visible when square is clicked
          */
        Rectangle {
            id: dividerLine4
            visible: clickedSquare4 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: "Unconfirmed 55.42 ETH"
            font.family: "Brandon Grotesque"
            font.pointSize: 12
            font.italic: true
            color: "#919191"
            //font.weight: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: dividerLine4.top
            visible: clickedSquare4 == 1 ? true : false
        }
        Rectangle {
            id: transferButton4
            visible: clickedSquare4 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine4.bottom
            anchors.left: dividerLine4.left
            anchors.topMargin: 15
            /**
            MouseArea {
                anchors.fill: transferButton4
                onClicked: {
                    transferTracker = 1
                }
            }
            */
            Text {
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton4
            visible: clickedSquare4 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine4.bottom
            anchors.right: dividerLine4.right
            anchors.topMargin: 15
            Text {
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Controls.CurrencySquare {
        id: square5
        anchors.top: square4.bottom
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/NEO_card_logo_colored_02.svg'
        currencyType2: "NEO"
        percentChange: "+%.8"
        gainLossTracker: 1
        amountSize: "22.5432"
        totalValue: "$43,443.94"
        value: "$9,839.99"
        height: clickedSquare5 == 1 ? 166 : 75
        z: 0
        Rectangle {
            id: expandButtonArea5
            width: 40
            height: 15
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: "transparent"

            MouseArea {
                anchors.fill: expandButtonArea5
                onClicked: {
                    if (clickedSquare5 == 1) {
                        clickedSquare5 = 0
                        return
                    }
                    if (clickedSquare5 == 0) {
                        clickedSquare3 = 0
                        clickedSquare5 = 1
                        clickedSquare4 = 0
                        clickedSquare = 0
                        clickedSquare2 = 0
                        return
                    }
                }
            }
        }

        Image {
            id: expandButton5
            width: 25
            height: 5
            anchors.horizontalCenter: expandButtonArea5.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            source: '../icons/expand_buttons.svg'
        }
        /**
          * Visible when square is clicked
          */
        Rectangle {
            id: dividerLine5
            visible: clickedSquare5 == 1 ? true : false
            width: parent.width - 20
            height: 1
            color: "#575757"
            anchors.top: parent.top
            anchors.topMargin: 75
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: "Unconfirmed 55.42 NEO"
            font.family: "Brandon Grotesque"
            font.pointSize: 12
            font.italic: true
            color: "#919191"
            //font.weight: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: dividerLine5.top
            visible: clickedSquare5 == 1 ? true : false
        }
        Rectangle {
            id: transferButton5
            visible: clickedSquare5 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine5.bottom
            anchors.left: dividerLine5.left
            anchors.topMargin: 15
            /**
            MouseArea {
                anchors.fill: transferButton5
                onClicked: {
                    transferTracker = 1
                }
            }
            */
            Text {
                text: "TRANSFER"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: historyButton5
            visible: clickedSquare5 == 1 ? true : false
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine5.bottom
            anchors.right: dividerLine5.right
            anchors.topMargin: 15
            Text {
                text: "HISTORY"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Image {
        id: settings
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 30
        source: '../icons/icon-settings.svg'
        width: 20
        height: 20
        z: 100

        ColorOverlay {
            anchors.fill: settings
            source: settings
            color: "#5E8BFF" // make image like it lays under grey glass
        }

        MouseArea {
            anchors.fill: settings
            //onClicked: pageLoader.source = "MobileAddressBook.qml"
            onClicked: mainRoot.push("Settings.qml")
        }
    }
    Image {
        id: apps
        source: '../icons/Apps_icon_03.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 30
        width: 20
        height: 20
        z: 100
        visible: appsTracker == 0
        MouseArea {
            anchors.fill: apps
            onClicked: appsTracker = 1
        }
        ColorOverlay {
            anchors.fill: apps
            source: apps
            color: "#5E8BFF" // make image like it lays under grey glass
        }
        /**
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    clipboard.text = regString.text
                }
            }
            */
    }

    Image {
        id: closeApps
        source: '../icons/CloseIcon.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 30
        width: 20
        height: 20
        z: 100
        visible: appsTracker == 1

        Rectangle {
            id: closeAppsButtonArea
            width: 20
            height: 20
            anchors.left: closeApps.left
            anchors.bottom: closeApps.bottom
            color: "transparent"
            MouseArea {
                anchors.fill: closeAppsButtonArea
                onClicked: appsTracker = 0
            }
        }
        ColorOverlay {
            anchors.fill: closeApps
            source: closeApps
            color: "#5E8BFF" // make image like it lays under grey glass
        }
    }
    Image {
        id: xchangeLink
        source: '../icons/XCHANGE_02.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 90
        anchors.right: parent.right
        anchors.rightMargin: 20
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        Text {
            text: "X-CHANGE"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }
        ColorOverlay {
            anchors.fill: xchangeLink
            source: xchangeLink
            color: "#5E8BFF" // make image like it lays under grey glass
        }
        /**
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    clipboard.text = regString.text
                }
            }
            */
    }

    Image {
        id: xvaultLink
        source: '../icons/XVAULT_02.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 160
        anchors.right: parent.right
        anchors.rightMargin: 20
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        Text {
            text: "X-VAULT"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }

        ColorOverlay {
            anchors.fill: xvaultLink
            source: xvaultLink
            color: "#5E8BFF" // make image like it lays under grey glass
        }
    }

    Image {
        id: xchatLink
        source: '../icons/XCHAT_02.svg'
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 230
        anchors.right: parent.right
        anchors.rightMargin: 20
        width: 40
        height: 40
        z: 100
        visible: appsTracker == 1
        Text {
            text: "X-CHAT"
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#5E8BFF"
            font.family: "Brandon Grotesque"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }
        ColorOverlay {
            anchors.fill: xchatLink
            source: xchatLink
            color: "#5E8BFF" // make image like it lays under grey glass
        }
    }
    /**
      * Transfer Modal popup
      */
    Rectangle {
        id: modal
        height: parent.height > 800 ? (parent.height - 400) : 400
        width: parent.width - 50
        color: "#42454F"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 150
        visible: transferTracker == 1
        radius: 4
        z: 100

        Rectangle {
            id: modalTop
            height: 50
            width: modal.width
            anchors.bottom: modal.top
            anchors.left: modal.left
            color: "#34363D"
            radius: 4
            Text {
                text: "TRANSFER"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#F2F2F2"
                font.family: "Brandon Grotesque"
                font.bold: false
                font.pixelSize: 14
            }
            Image {
                id: closeModal
                source: '../icons/CloseIcon.svg'
                anchors.bottom: modalTop.bottom
                anchors.bottomMargin: 15
                anchors.right: modalTop.right
                anchors.rightMargin: 30
                width: 20
                height: 20
                Rectangle {
                    id: closeModalButtonArea
                    width: 20
                    height: 20
                    anchors.left: closeModal.left
                    anchors.bottom: closeModal.bottom
                    color: "transparent"
                    MouseArea {
                        anchors.fill: closeModalButtonArea
                        onClicked: transferTracker = 0
                    }
                }
                ColorOverlay {
                    anchors.fill: closeModal
                    source: closeModal
                    color: "#5E8BFF" // make image like it lays under grey glass
                }
            }
        }
        Switch {
            id: transferSwitch
            anchors.horizontalCenter: modal.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10

            Text {
                id: receiveText
                text: qsTr("RECEIVE")
                anchors.right: transferSwitch.left
                anchors.rightMargin: 7
                anchors.verticalCenter: parent.verticalCenter
                color: transferSwitch.checked ? "#5F5F5F" : "#5E8BFE"
            }
            Text {
                id: sendText
                text: qsTr("SEND")
                anchors.left: transferSwitch.right
                anchors.leftMargin: 7
                anchors.verticalCenter: parent.verticalCenter
                color: transferSwitch.checked ? "#5E8BFE" : "#5F5F5F"
            }
        }

        /**
          * Transfer Modal both send & receive
          */
        Image {
            id: currencyIcon
            source: '../icons/XBY_card_logo_colored_05.svg'
            width: 25
            height: 25
            anchors.left: modal.left
            anchors.leftMargin: 20
            anchors.top: modal.top
            anchors.topMargin: 50
            visible: transferTracker == 1
            Label {
                id: currencyIconChild
                text: "XBY"
                anchors.left: currencyIcon.right
                anchors.leftMargin: 10
                color: "#E5E5E5"
                font.bold: true
                anchors.verticalCenter: currencyIcon.verticalCenter
            }
            Image {
                source: '../icons/dropdown_icon.svg'
                width: 12
                height: 12
                anchors.left: currencyIconChild.right
                anchors.leftMargin: 8
                anchors.verticalCenter: currencyIconChild.verticalCenter
                visible: transferTracker == 1
            }
        }
        Label {
            id: walletChoice
            text: "MAIN"
            anchors.right: qrBorder.right
            anchors.rightMargin: 10
            anchors.verticalCenter: currencyIcon.verticalCenter
            color: "#E5E5E5"
            font.bold: true
            visible: transferTracker == 1
        }
        Image {
            id: walletDropdown
            source: '../icons/dropdown_icon.svg'
            width: 12
            height: 12
            anchors.left: walletChoice.right
            anchors.leftMargin: 8
            anchors.verticalCenter: walletChoice.verticalCenter
            visible: transferTracker == 1
        }
        /**
          * Transfer modal receive state
          */

        Item {
            id: qrPlaceholder
            width: 180
            height: 180
            anchors.horizontalCenter: qrBorder.horizontalCenter
            anchors.verticalCenter: qrBorder.verticalCenter
            z: 10
            visible: transferSwitch.checked == false && transferTracker == 1
            QtQrCode {
                anchors.fill: parent
                data: publicKey.text
                background: "white"
                foreground: "black"
            }
        }
        Rectangle{
            id: qrBorder
            radius: 8
            width: 210
            height: 210
            visible: transferSwitch.checked == false && transferTracker == 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: currencyIcon.bottom
            anchors.topMargin: 20
            color: "white"
        }

        Text {
            id: pubKey
            text: "PUBLIC KEY"
            anchors.top: qrBorder.bottom
            anchors.topMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: true
            font.pixelSize: 11
            visible: transferSwitch.checked == false && transferTracker == 1
        }
        Text {
            id: publicKey
            text: "BM39fjwf093JF329f39fJFfa03987fja392WPF2948WQO"
            anchors.top: pubKey.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: pubKey.horizontalCenter
            color: "white"
            font.family: "Brandon Grotesque"
            font.bold: false
            font.pixelSize: 9
            visible: transferSwitch.checked == false && transferTracker == 1
        }
        Image {
            id: pasteIcon
            source: '../icons/paste_icon.svg'
            width: 13
            height: 13
            anchors.left: publicKey.right
            anchors.leftMargin: 5
            anchors.verticalCenter: publicKey.verticalCenter
            visible: transferSwitch.checked == false && transferTracker == 1
        }

        /**
          * Transfer modal send state
          */
        Label {
            id: walletBalance
            text: "18.5359 XBY"
            anchors.right: walletDropdown.right
            anchors.rightMargin: 0
            anchors.top: walletChoice.bottom
            anchors.topMargin: 1
            color: "#E5E5E5"
            font.bold: true
            font.pixelSize: 10
            visible: transferTracker == 1 && transferSwitch.checked == true
        }
        Controls.TextInput {
            id: sendAmount
            height: 34
            //radius: 8
            text: "AMOUNT (XBY)"
            anchors.left: currencyIcon.left
            anchors.top: currencyIcon.bottom
            anchors.topMargin: 15
            visible: transferTracker == 1 && transferSwitch.checked == true
            color: "#727272"
            font.pixelSize: 10
            font.family: "Brandon Grotesque"
            font.bold: true
        }
        Controls.TextInput {
            id: keyInput
            height: 34
            text: "SEND TO (PUBLIC KEY)"
            anchors.left: currencyIcon.left
            anchors.top: sendAmount.bottom
            anchors.topMargin: 15
            color: "#727272"
            font.pixelSize: 10
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: transferTracker == 1 && transferSwitch.checked == true
        }
        Rectangle {
            id: scanQrButton
            visible: transferTracker == 1 && transferSwitch.checked == true
            width: (keyInput.width / 2) - 3
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput.bottom
            anchors.topMargin: 15
            anchors.left: keyInput.left
            MouseArea {
                anchors.fill: scanQrButton
            }
            Text {
                text: "SCAN QR"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                color: "#5E8BFF"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
            id: addressBookButton
            visible: transferTracker == 1 && transferSwitch.checked == true
            width: (keyInput.width / 2) - 3
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: keyInput.bottom
            anchors.topMargin: 15
            anchors.right: keyInput.right
            MouseArea {
                anchors.fill: addressBookButton

                //onClicked: {
                //  transferTracker = 1
                // }
            }
            Text {
                text: "ADDRESS BOOK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Controls.TextInput {
            id: referenceInput
            height: 34
            // radius: 8
            text: "REFERENCE"
            anchors.left: currencyIcon.left
            anchors.top: scanQrButton.bottom
            anchors.topMargin: 15
            color: "#727272"
            font.pixelSize: 10
            font.family: "Brandon Grotesque"
            font.bold: true
            visible: transferTracker == 1 && transferSwitch.checked == true
        }
        Rectangle {
            id: sendButton
            visible: transferTracker == 1 && transferSwitch.checked == true
            width: keyInput.width
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: referenceInput.bottom
            anchors.topMargin: 35
            anchors.left: referenceInput.left
            MouseArea {
                anchors.fill: sendButton

                //onClicked: {
                //  transferTracker = 1
                // }
            }
            Text {
                text: "SEND"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
