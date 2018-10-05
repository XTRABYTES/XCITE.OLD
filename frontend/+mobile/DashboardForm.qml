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
import QtMultimedia 5.8
import QZXing 2.3

import "./Controls" as Controls

Item{

    // dash form vars
    property int sw: -1
    property int appsTracker1: 0
    property int transferTracker: 0
    property int addressBookTracker: 0
    property int scanQRCodeTracker: 0
    property int historyTracker: 0
    property int transactionSentTracker: 0
    property int transactionConfirmTracker: 0
    property int coinHistoryA1: 1
    property int coinHistoryA2:1
    property int clickedSquare: 0
    property int clickedSquare2: 0
    property int clickedSquare3: 0
    property int clickedSquare4: 0
    property int clickedSquare5: 0
    property int clickedSquare6: 0
    property int totalCards: 5
    property string address1: "B5xiknaGNK330s9gyU4riyKuVzvIOPEVz6"
    property string address2: "B2QiknazjkA30s9gyV4riyKuVWvUMXEVss"
    property string address3: "B09iknaFAFKA30s392J4riyKuVWvUMXEV3"
    property string address4: "BxkiknaGNKA30s9gyV4riyKuVWvFJKEVq9"

    // address book vars
    property int clickedAddSquare: 0
    property int clickedAddSquare2: 0
    property int clickedAddSquare3: 0
    property int clickedAddSquare4: 0
    property int clickedAddSquare5: 0
    property int editAddressTracker: 0
    property int editAddressTracker2: 0
    property int editAddressTracker3: 0
    property int editAddressTracker4: 0
    property int editAddressTracker5: 0

    // shared vars
    property int pageTracker: view.currentIndex == 0 ? 0 : 1


    RowLayout {
        id: headingLayout
        anchors.top: parent.top
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        z: 2
        visible: transferTracker != 1
        Label {
            id: overview
            text: "OVERVIEW"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            font.bold: true
            color: pageTracker == 0 ? "#5E8BFE": "#757575"
            Rectangle {
                id: titleLine
                width: overview.width
                height: 2
                color: "#5E8BFE"
                anchors.top: overview.bottom
                anchors.left: overview.left
                anchors.topMargin: 2
                visible: pageTracker == 0
            }
        }
        Label {
            id: add5
            text: "ADDRESS BOOK"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            color: pageTracker == 0 ? "#757575" : "#5E8BFE"
            font.bold: true
            Rectangle {
                id: titleLine2
                width: add5.width
                height: 2
                color: "#5E8BFE"
                anchors.top: add5.bottom
                anchors.left: add5.left
                anchors.topMargin: 2
                visible: pageTracker == 1
            }
        }
    }

    Image {
        id: apps
        source: '../icons/mobile-menu.svg'
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.verticalCenter: headingLayout.verticalCenter
        width: 22
        height: 17
        z: 2
        visible: transferTracker != 1
        ColorOverlay {
            anchors.fill: apps
            source: apps
            color: "#5E8BFF"
        }
        MouseArea {
            anchors.fill: apps
            onClicked: appsTracker1 = 1
        }
    }

    Controls.Sidebar{
        z: 1000
        anchors.left: parent.left
        anchors.top: parent.top
        appsTracker: appsTracker1 == 0 ? 0 : 1
    }

    Image {
        id: notif
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.verticalCenter: headingLayout.verticalCenter
        source: '../icons/notification_icon_03.svg'
        width: 30
        height: 30
        z: 2
        visible: transferTracker != 1
        ColorOverlay {
            anchors.fill: notif
            source: notif
            color: "#5E8BFF"
        }
        Image{
            id: notifAlert
            anchors.left: parent.right
            anchors.leftMargin: -16
            anchors.top: parent.top
            anchors.topMargin: 3
            source: '../icons/notification_red_circle_icon.svg'
            width: 8
            height: 8
        }
    }

    Rectangle {
        color: "black"
        opacity: .8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height
        width: parent.width
        z: 5
        visible: appsTracker1 == 1
    }

    SwipeView {
        id: view

        currentIndex: 0
        anchors.fill: parent
        interactive: (appsTracker1 == 1 || transferTracker == 1) ? 0 : 1

        /**
         * Main page
         */
        Item {
            z: 2
            id: dashForm
            Rectangle {
                color: "black"
                opacity: .8
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                height: parent.height
                width: parent.width
                z: 5
                visible: transferTracker == 1 || historyTracker == 1 || appsTracker1 == 1
            }
            Rectangle {
                id: mainrect
                color: "#34363D"
                anchors.top: transfer.bottom
                anchors.topMargin: 14
                anchors.left: parent.left
                height: parent.height
                width: parent.width
                z: 0
                visible: true
                MouseArea {
                    anchors.fill: mainrect
                    onClicked: {
                        appsTracker1 = 0
                    }
                }
            }

            Loader {
                id: pageLoader
            }
            Rectangle {
                id:scrollArea
                width: parent.width
                anchors.top: parent.top
                anchors.topMargin: 165
                anchors.bottom: parent.bottom
                color: "transparent"

                Flickable {
                    id:scrollArea2
                    width: parent.width
                    height: parent.height
                    maximumFlickVelocity: 40
                    property int propertyCheck: scrollArea2.contentY
                    onContentYChanged: {
                        console.log("contentY position ", propertyCheck)
                    }

                    states: [
                        State {
                            name:"focusCard1a"
                            PropertyChanges {
                                target: scrollArea2
                                contentY: 0*82
                            }
                        },
                        State {
                            name:"focusCard1b"
                            PropertyChanges {
                                target: scrollArea2
                                contentY: 0*82
                            }
                        },
                        State {
                            name:"focusCard2a"
                            PropertyChanges {
                                target: scrollArea2
                                contentY: 1*82
                            }
                        },
                        State {
                            name:"focusCard2b"
                            PropertyChanges {
                                target: scrollArea2
                                contentY: 1*82
                            }
                        },
                        State {
                            name:"focusCard3"
                            PropertyChanges {
                                target: scrollArea2
                                contentY: 2*82
                            }
                        },
                        State {
                            name:"focusCard4"
                            PropertyChanges {
                                target: scrollArea2
                                contentY: 3*82
                            }
                        },
                        State {
                            name:"focusCard5a"
                            PropertyChanges {
                                target: scrollArea2
                                contentY: 4*82
                            }
                        },
                        State {
                            name:"focusCard5b"
                            PropertyChanges {
                                target: scrollArea2
                                contentY: 4*82
                            }
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            ParallelAnimation {
                                NumberAnimation {properties: "contentY"; duration: 100; easing.type: Easing.Linear}
                            }
                        }
                    ]

                    Controls.CurrencySquare {
                        id: square1
                        anchors.horizontalCenter: parent.horizontalCenter
                        currencyType: '../icons/XBY_card_logo_colored_05.svg'
                        currencyType2: "XBY"
                        percentChange: "+%.8"
                        gainLossTracker: 1
                        state: "currencyClosed"
                        value: ((marketValue.marketValue*100)/100).toLocaleString(
                                   Qt.locale(), "f", 4)

                        states: [
                            State {
                                name:"currencyClosed"
                                PropertyChanges {
                                    target: square1
                                    height:75
                                }
                                PropertyChanges {
                                    target: scrollArea2
                                    contentHeight: (totalCards*85) + 141
                                    interactive: ((parent.height-50)>(totalCards*85))? false : true
                                }
                            },
                            State {
                                name:"currencyOpen"
                                PropertyChanges {
                                    target: square1
                                    height:166
                                }
                                PropertyChanges {
                                    target: scrollArea2
                                    contentHeight: (totalCards*85) + 141
                                    interactive: ((parent.height-50)>(scrollArea2.contentHeight))? false : true
                                }
                            }

                        ]

                        transitions: [
                            Transition {
                                from: "*"
                                to: "*"
                                ParallelAnimation {
                                    NumberAnimation {properties: "height"; duration: 100; easing.type: Easing.Linear}
                                }
                            }
                        ]

                        // since expandbutton is very tiny and hard to click we put an invisible rectangle here to mimic the dots
                        Rectangle {
                            id: expandButtonArea1
                            width: 40
                            height: 25
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: -5
                            color: "transparent"
                            property int positionCheck

                            MouseArea {

                                Timer {
                                    id: timer1
                                }

                                function delay1(delayTime, cb) {
                                    timer1.interval = delayTime;
                                    timer1.repeat = false;
                                    timer1.triggered.connect(cb);
                                    timer1.triggered.connect(function() {
                                        timer1.triggered.disconnect(cb); // This is important
                                    });
                                    timer1.start();
                                }

                                anchors.fill: expandButtonArea1
                                // disable for now while only XBY can be traded
                                onClicked: {
                                    if (square1.state === "currencyOpen") {
                                        clickedSquare = 0
                                        square1.state = "currencyClosed"
                                        if (scrollArea2.contentHeight < scrollArea.height){
                                            scrollArea2.state = "focusClear"
                                        }
                                        return
                                    }
                                    if (square1.state === "currencyClosed") {
                                        square5.state = "currencyClosed"
                                        square4.state = "currencyClosed"
                                        square3.state = "currencyClosed"
                                        square2.state = "currencyClosed"
                                        clickedSquare5 = 0
                                        clickedSquare4 = 0
                                        clickedSquare3 = 0
                                        clickedSquare2 = 0
                                        expandButtonArea1.positionCheck =  scrollArea2.contentY
                                        if (expandButtonArea1.positionCheck > 0*82) {
                                            if (scrollArea2.state == "focusCard1a") {
                                                scrollArea2.state = "focusCard1b"
                                            }
                                            else {
                                                scrollArea2.state = "focusCard1a"
                                            }
                                        }
                                        square1.state ="currencyOpen"
                                        delay1(100, function() {
                                            clickedSquare = 1
                                        })
                                        return
                                    }
                                }

                            }
                        }
                        Image {
                            id: expandButton
                            width: 25
                            height: 5
                            anchors.horizontalCenter: expandButtonArea1.horizontalCenter
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
                        /**
               Text {
                   text: "Unconfirmed 55.42 XBY"
                   font.family: "Brandon Grotesque"
                   font.pointSize: 12
                   font.italic: true
                   color: "#919191"
                   anchors.horizontalCenter: parent.horizontalCenter
                   anchors.bottom: dividerLine.top
                   anchors.bottomMargin: 2
                   visible: clickedSquare == 1 ? true : false
               }
               */
                        Rectangle {
                            id: transferButton
                            visible: clickedSquare == 1 && transferTracker != 1
                            width: (parent.width/2) - 15
                            height: 40
                            radius: 8
                            border.color: "#5E8BFF"
                            border.width: 2
                            color: "transparent"
                            anchors.top: dividerLine.bottom
                            anchors.right: expandButton.horizontalCenter
                            anchors.rightMargin: 5
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
                            visible: clickedSquare == 1 && transferTracker != 1
                            width: transferButton.width
                            height: 40
                            radius: 8
                            border.color: "#5E8BFF"
                            border.width: 2
                            color: "transparent"
                            anchors.top: dividerLine.bottom
                            anchors.left: expandButton.horizontalCenter
                            anchors.leftMargin: 5
                            anchors.topMargin: 15
                            MouseArea {
                                anchors.fill: historyButton
                                onClicked: {
                                    historyTracker = 1
                                }
                            }
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
                        anchors.left: square1.left
                        currencyType: '../icons/XFUEL_card_logo_colored_07.svg'
                        currencyType2: "XFUEL"
                        percentChange: "+0%"
                        gainLossTracker: 0
                        amountSize: "0"
                        totalValue: "0"
                        value: "0"
                        state: "currencyClosed"

                        states: [
                            State {
                                name:"currencyClosed"
                                PropertyChanges {
                                    target: square2
                                    height:75
                                }
                                PropertyChanges {
                                    target: scrollArea2
                                    contentHeight: (totalCards*85) + 141
                                    interactive: ((parent.height-50)>(totalCards*85))? false : true
                                }
                            },
                            State {
                                name:"currencyOpen"
                                PropertyChanges {
                                    target: square2
                                    height:166
                                }
                                PropertyChanges {
                                    target: scrollArea2
                                    contentHeight: (totalCards*85) + 141
                                    interactive: ((parent.height-50)>(scrollArea2.contentHeight))? false : true
                                }
                            }
                        ]

                        transitions: [
                            Transition {
                                from: "*"
                                to: "*"
                                ParallelAnimation {
                                    NumberAnimation {properties: "height"; duration: 100; easing.type: Easing.Linear}
                                }
                            }
                        ]
                        Rectangle {
                            id: expandButtonArea2
                            width: 40
                            height: 25
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: -5
                            color: "transparent"
                            property int positionCheck
                            /**
                   MouseArea {

                       Timer {
                               id: timer2
                           }

                           function delay2(delayTime, cb) {
                               timer2.interval = delayTime;
                               timer2.repeat = false;
                               timer2.triggered.connect(cb);
                               timer2.triggered.connect(function() {
                                   timer2.triggered.disconnect(cb); // This is important
                               });
                               timer2.start();
                           }

                       anchors.fill: expandButtonArea2
                       onClicked: {
                           if (square2.state === "currencyOpen") {
                               clickedSquare2 = 0
                               square2.state = "currencyClosed"
                               if (scrollArea2.contentHeight < scrollArea.height){
                                   scrollArea2.state = "focusClear"
                               }
                               return
                           }
                           if (square2.state === "currencyClosed") {
                               square5.state = "currencyClosed"
                               square4.state = "currencyClosed"
                               square3.state = "currencyClosed"
                               square1.state = "currencyClosed"
                               clickedSquare5 = 0
                               clickedSquare4 = 0
                               clickedSquare3 = 0
                               clickedSquare = 0
                               expandButtonArea2.positionCheck =  scrollArea2.contentY
                               if (expandButtonArea2.positionCheck > 1*82) {
                                   if (scrollArea2.state == "focusCard2a") {
                                       scrollArea2.state = "focusCard2b"
                                   }
                                   else {
                                       scrollArea2.state = "focusCard2a"
                                   }
                               }
                               square2.state = "currencyOpen"
                               delay2(100, function() {
                                   clickedSquare2 = 1
                               })
                               return
                           }
                       }

                   }
                   */
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
                        /**
               Text {
                   text: "Unconfirmed 55.42 XFUEL"
                   font.family: "Brandon Grotesque"
                   font.pointSize: 12
                   font.italic: true
                   color: "#919191"
                   anchors.horizontalCenter: parent.horizontalCenter
                   anchors.bottom: dividerLine2.top
                   visible: clickedSquare2 == 1 ? true : false
               }
               */
                        Rectangle {
                            id: transferButton2
                            visible: clickedSquare2 == 1 ? true : false
                            width: (parent.width/2) - 15
                            height: 40
                            radius: 8
                            border.color: "#5E8BFF"
                            border.width: 2
                            color: "transparent"
                            anchors.top: dividerLine2.bottom
                            anchors.right: expandButton2.horizontalCenter
                            anchors.rightMargin: 5
                            anchors.topMargin: 15
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
                            width: transferButton.width
                            height: 40
                            radius: 8
                            border.color: "#5E8BFF"
                            border.width: 2
                            color: "transparent"
                            anchors.top: dividerLine2.bottom
                            anchors.left: expandButton2.horizontalCenter
                            anchors.leftMargin: 5
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
                        anchors.left: square1.left
                        currencyType: '../icons/BTC-color.svg'
                        currencyType2: "BTC"
                        percentChange: "+0%"
                        gainLossTracker: 0
                        amountSize: "0"
                        totalValue: "0"
                        value: "0"
                        height: clickedSquare3 == 1 ? 166 : 75
                        Rectangle {
                            id: expandButtonArea3
                            width: 40
                            height: 25
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: -5
                            color: "transparent"

                            MouseArea {
                                anchors.fill: expandButtonArea3
                                /**
                         * disable for now while only XBY can be traded
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
                       */
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
                        /**
               Text {
                   text: "Unconfirmed 55.42 BTC"
                   font.family: "Brandon Grotesque"
                   font.pointSize: 12
                   font.italic: true
                   color: "#919191"
                   anchors.horizontalCenter: parent.horizontalCenter
                   anchors.bottom: dividerLine3.top
                   visible: clickedSquare3 == 1 ? true : false
               }
               */
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
                        anchors.left: square1.left
                        currencyType: '../icons/ETH-color.svg'
                        currencyType2: "ETH"
                        percentChange: "+0%"
                        gainLossTracker: 0
                        amountSize: "0"
                        totalValue: "0"
                        value: "0"
                        height: clickedSquare4 == 1 ? 166 : 75
                        z: 0
                        Rectangle {
                            id: expandButtonArea4
                            width: 40
                            height: 25
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: -5
                            color: "transparent"

                            MouseArea {
                                anchors.fill: expandButtonArea4
                                /**
                         * disable for now while only XBY can be traded
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
                       */
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
                        /**
               Text {
                   text: "Unconfirmed 55.42 ETH"
                   font.family: "Brandon Grotesque"
                   font.pointSize: 12
                   font.italic: true
                   color: "#919191"
                   anchors.horizontalCenter: parent.horizontalCenter
                   anchors.bottom: dividerLine4.top
                   visible: clickedSquare4 == 1 ? true : false
               }
               */
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
                        anchors.left: square1.left
                        currencyType: '../icons/NEO_card_logo_colored_02.svg'
                        currencyType2: "NEO"
                        percentChange: "+0%"
                        gainLossTracker: 0
                        amountSize: "0"
                        totalValue: "0"
                        value: "0"
                        state: "currencyClosed"

                        states: [
                            State {
                                name:"currencyClosed"
                                PropertyChanges {
                                    target: square5
                                    height:75
                                }
                                PropertyChanges {
                                    target: scrollArea2
                                    contentHeight: (totalCards*85) + 141
                                    interactive: ((parent.height-50)>(totalCards*85))? false : true
                                }
                            },
                            State {
                                name:"currencyOpen"
                                PropertyChanges {
                                    target: square5
                                    height:166
                                }
                                PropertyChanges {
                                    target: scrollArea2
                                    contentHeight: (totalCards*85) + 141
                                    interactive: ((parent.height-50)>(scrollArea2.contentHeight))? false : true
                                }
                            }
                        ]

                        transitions: [
                            Transition {
                                from: "*"
                                to: "*"
                                ParallelAnimation {
                                    NumberAnimation {properties: "height"; duration: 100; easing.type: Easing.Linear}
                                }
                            }
                        ]
                        Rectangle {
                            id: expandButtonArea5
                            width: 40
                            height: 25
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: -5
                            color: "transparent"
                            property int positionCheck
                            /**
                    MouseArea {
                        Timer {
                            id: timer
                        }
                        function delay(delayTime, cb) {
                            timer.interval = delayTime;
                            timer.repeat = false;
                            timer.triggered.connect(cb);
                            timer.triggered.connect(function() {
                                timer.triggered.disconnect(cb); // This is important
                            });
                            timer.start();
                        }

                        anchors.fill: expandButtonArea5
                        onClicked: {
                            if (square5.state === "currencyOpen") {
                                clickedSquare5 = 0
                                square5.state = "currencyClosed"
                                if ((square1.state = "currencyClosed")&&(square2.state = "currencyClosed")&&(square3.state = "currencyClosed")&&(square4.state = "currencyClosed")&&((scrollArea.height - 50)>(totalCards*85))) {
                                    if (scrollArea2.state == "focusCard1a") {
                                        scrollArea2.state = "focusCard1b"
                                    }
                                    else {
                                        scrollArea2.state = "focusCard1a"
                                    }
                                }
                                return

                            }
                            if (square5.state === "currencyClosed") {
                                square4.state = "currencyClosed"
                                square3.state = "currencyClosed"
                                square2.state = "currencyClosed"
                                square1.state = "currencyClosed"
                                clickedSquare4 = 0
                                clickedSquare3 = 0
                                clickedSquare2 = 0
                                clickedSquare = 0
                                expandButtonArea5.positionCheck =  scrollArea2.contentY
                                if (expandButtonArea5.positionCheck > 4*82) {
                                    if (scrollArea2.state == "focusCard5a") {
                                        scrollArea2.state = "focusCard5b"
                                    }
                                    else {
                                        scrollArea2.state = "focusCard5a"
                                    }
                                }
                                square5.state = "currencyOpen"
                                delay(100, function() {
                                    clickedSquare5 = 1
                                })
                                return
                            }
                        }
                    }
                    */
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
                        /**
               Text {
                   text: "Unconfirmed 55.42 NEO"
                   font.family: "Brandon Grotesque"
                   font.pointSize: 12
                   font.italic: true
                   color: "#919191"
                   anchors.horizontalCenter: parent.horizontalCenter
                   anchors.bottom: dividerLine5.top
                   visible: clickedSquare5 == 1 ? true : false
               }
               */
                        Rectangle {
                            id: transferButton5
                            visible: clickedSquare5 == 1 ? true : false
                            // fix me
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
                            // fix me
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

                    contentWidth: parent.width
                    contentHeight: (totalCards*85) + 50
                    // replace height value by calculation based on the number of currency cards and the height of the scrollable area
                    interactive: ((parent.height-50)>(totalCards*85)) ? false : true

                    // replace by if statement to lock when the place needed by the currency cards does not exceed the available space
                    boundsBehavior: Flickable.StopAtBounds
                }
            }

            Rectangle {
                id:headerSection
                width: parent.width
                height:150
                color:"#2a2c31"
            }

            // round to two places for total value (dollars), 4 for value (crypto), 6 for amount (crypto)
            Label {
                id: value
                anchors.top: parent.top
                anchors.topMargin: 62
                anchors.horizontalCenter: dashForm.horizontalCenter
                text: "$" + (wallet.balance * marketValue.marketValue).toLocaleString(
                          Qt.locale(), "f", 2)
                font.pixelSize: 40
                font.family: "Brandon Grotesque"
                color: "#E5E5E5"
            }

            Label {
                id: transfer
                text: "TRANSFER"
                font.pixelSize: 13
                font.family: "Brandon Grotesque"
                color: "#C7C7C7"
                anchors.left: parent.left
                anchors.leftMargin: 28
                anchors.bottom: scrollArea.top
                anchors.bottomMargin: 30
                font.bold: true
                Image {
                    id: transfer2
                    anchors.verticalCenter: transfer.verticalCenter
                    anchors.left: parent.right
                    anchors.leftMargin: 8
                    source: '../icons/transfer_icon_02.svg'
                    width: 18
                    height: 18
                    ColorOverlay {
                        anchors.fill: transfer2
                        source: transfer2
                        color: "#5E8BFF"
                    }
                    MouseArea {
                        anchors.fill: transfer2
                        onClicked: {
                            transferTracker = 1
                        }
                    }
                }
            }

            Image {
                id: plus
                anchors.verticalCenter: transfer.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 28
                source: '../icons/add_icon_04.svg'
                width: 18
                height: 18
                ColorOverlay {
                    anchors.fill: plus
                    source: plus
                    color: "#5E8BFF"
                }
                Label {
                    id: addCoin
                    text: "ADD COIN"
                    font.pixelSize: 13
                    font.family: "Brandon Grotesque"
                    color: "#C7C7C7"
                    anchors.right: parent.left
                    anchors.rightMargin:8
                    anchors.verticalCenter: plus.verticalCenter
                    font.bold: true
                }
            }

            Controls.TransferModal{
                z: 1000
                anchors.horizontalCenter: dashForm.horizontalCenter
                anchors.top: dashForm.top
                anchors.topMargin: 40
            }

            Controls.HistoryModal{

            }
        }

        /**
      * Address Book
      */
        Item {
            id: addressBookForm

            Rectangle {
                id: mainrect2
                color: "#34363D"
                anchors.top: transfer22.top
                anchors.topMargin: 28
                anchors.left: parent.left
                height: parent.height
                width: parent.width
                z: 0
                visible: true
                MouseArea {
                    anchors.fill: mainrect2
                    onClicked: {
                        appsTracker1 = 0
                    }
                }
            }

            Rectangle {
                color: "black"
                opacity: .8
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                height: parent.height
                width: parent.width
                z: 5
                visible: transferTracker == 1 || appsTracker1 == 1 || editAddressTracker == 1 || editAddressTracker2 == 1 || editAddressTracker3 == 1 || editAddressTracker4 == 1 || editAddressTracker5 == 1
            }

            Controls.TransferModal {
                z: 1000
                anchors.horizontalCenter: addressBookForm.horizontalCenter
                anchors.top: addressBookForm.top
                anchors.topMargin: 40
            }

            Label {
                id: transfer22
                text: "TRANSFER"
                font.pixelSize: 13
                font.family: "Brandon Grotesque"
                color: "#C7C7C7"
                anchors.left: address.left
                anchors.top: searchForAddress.bottom
                anchors.topMargin: 23
                font.bold: true
                Image {
                    id: transfer222
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.right
                    anchors.leftMargin: 8
                    source: '../icons/transfer_icon_02.svg'
                    width: 18
                    height: 18
                    ColorOverlay {
                        anchors.fill: transfer222
                        source: transfer222
                        color: "#5E8BFF"
                    }
                    MouseArea {
                        anchors.fill: transfer222
                        onClicked: {
                            transferTracker = 1
                        }
                    }
                }
            }

            Label {
                id: addAddress
                text: "ADD ADDRESS"
                font.pixelSize: 13
                font.family: "Brandon Grotesque"
                color: "#C7C7C7"
                anchors.right: address.right
                anchors.verticalCenter: transfer22.verticalCenter
                anchors.rightMargin: 24
                font.bold: true
                Image {
                    id: plus2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.right
                    anchors.leftMargin: 8
                    source: '../icons/add_icon_04.svg'
                    width: 18
                    height: 18
                    ColorOverlay {
                        anchors.fill: plus2
                        source: plus2
                        color: "#5E8BFF"
                    }
                }
            }

            Controls.TextInput {
                id: searchForAddress
                height: 34
                placeholder: "SEARCH ADDRESS BOOK"
                anchors.left: address.left
                anchors.top: parent.top
                anchors.topMargin: 65
                width: address.width
                color: "#727272"
                font.pixelSize: 11
                font.family: "Brandon Grotesque"
                font.bold: true
                mobile: 1
                addressBook: 1
            }
            Controls.AddressBookSquares {
                id: address
                anchors.top: searchForAddress.bottom
                anchors.topMargin: 65
                anchors.left: parent.left
                anchors.leftMargin: 25
                name: addressName1
                numberAddresses: 1
                height: clickedAddSquare == 0 ? 75 : 150
                Image {
                    width: 25
                    height: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 8
                    source: '../icons/expand_buttons.svg'
                }
                Rectangle {
                    id: expandAddressArea
                    width: 40
                    height: 25
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -5
                    color: "transparent"
                    MouseArea {
                        anchors.fill: expandAddressArea
                        onClicked: {
                            if(clickedAddSquare == 0){
                                clickedAddSquare = 1
                                return
                            }
                            if(clickedAddSquare == 1 ){
                                clickedAddSquare = 0
                                return
                            }
                        }
                    }
                }
                Image {
                    id: icon
                    width: 20
                    height: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    source: '../icons/XBY_card_logo_colored_05.svg'
                    visible: clickedAddSquare == 1
                }
                Label {
                    anchors.left: icon.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: icon.verticalCenter
                    text: "XBY"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare == 1
                }
                Label {
                    id: addressLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: icon.verticalCenter
                    text: "Main"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare == 1
                }
                Image {
                    id: editAddress
                    width: 20
                    height: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    source: '../icons/edit.svg'
                    visible: clickedAddSquare == 1
                    ColorOverlay {
                        anchors.fill: editAddress
                        source: editAddress
                        color: "#DADADA"
                    }
                    MouseArea {
                        anchors.fill: editAddress
                        onClicked: {
                            editAddressTracker = 1
                        }
                    }
                }
                Rectangle {
                    id: dividerLine22
                    visible: clickedAddSquare == 1
                    width: address.width - 20
                    height: 1
                    color: "#575757"
                    anchors.top: icon.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: modal
                height: 300
                width: 325
                color: "#42454F"
                radius: 4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 150
                visible: editAddressTracker == 1
                z: 100
                Rectangle {
                    id: modalTop
                    height: 50
                    width: modal.width
                    anchors.bottom: modal.top
                    anchors.left: modal.left
                    color: "#34363D"
                    radius: 4
                }
                Label{
                    anchors.horizontalCenter: modalTop.horizontalCenter
                    anchors.verticalCenter: modalTop.verticalCenter
                    color: "White"
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    text: "EDIT ADDRESS"
                }
                Image {
                    id: icon2
                    width: 25
                    height: 25
                    anchors.left: keyInput1.left
                    anchors.leftMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 25
                    source: '../icons/XBY_card_logo_colored_05.svg'
                    visible: clickedAddSquare == 1
                }
                Label {
                    id: label1
                    anchors.left: icon2.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: icon2.verticalCenter
                    text: "XBY"
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare == 1
                }
                Image {
                    source: '../icons/dropdown_icon.svg'
                    width: 15
                    height: 15
                    anchors.left: label1.right
                    anchors.leftMargin: 8
                    anchors.verticalCenter: label1.verticalCenter
                }
                Controls.TextInput {
                    id: keyInput1
                    height: 34
                    placeholder: "Edit Name"
                    text: address.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: icon2.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker == 1
                    mobile: 1
                }
                Image {
                    id: textFieldEmpty1
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput1.verticalCenter
                    anchors.right: keyInput1.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty1.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty1
                        source: textFieldEmpty1
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput1ButtonArea
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty1.left
                        anchors.bottom: textFieldEmpty1.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput1ButtonArea
                            onClicked: {
                                keyInput1.text = ""
                            }
                        }
                    }
                }
                Controls.TextInput {
                    id: keyInput2
                    height: 34
                    placeholder: "Edit Label"
                    text: addressLabel.text
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: keyInput1.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker == 1
                    mobile: 1
                }
                Image {
                    id: textFieldEmpty2
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput2.verticalCenter
                    anchors.right: keyInput2.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty2.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty2
                        source: textFieldEmpty2
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput2ButtonArea
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty2.left
                        anchors.bottom: textFieldEmpty2.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput2ButtonArea
                            onClicked: {
                                keyInput2.text = ""
                            }
                        }
                    }
                }
                Controls.TextInput {
                    id: keyInput3
                    height: 34
                    placeholder: "Edit Address"
                    text: receivingAddress
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: keyInput2.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker == 1
                    mobile: 1
                }
                Image {
                    id: textFieldEmpty3
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput3.verticalCenter
                    anchors.right: keyInput3.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty3.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty3
                        source: textFieldEmpty3
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput3ButtonArea
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty3.left
                        anchors.bottom: textFieldEmpty3.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput3ButtonArea
                            onClicked: {
                                keyInput3.text = ""
                            }
                        }
                    }
                }
                Rectangle {
                    id: editConfirm
                    width: keyInput1.width
                    height: 33
                    radius: 8
                    border.color: "#5E8BFF"
                    border.width: 2
                    color: "transparent"
                    anchors.top: keyInput3.bottom
                    anchors.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: editAddressTracker == 1
                    MouseArea {
                        anchors.fill: editConfirm

                        onClicked: {
                            editAddressTracker = 0
                            addressName1 = keyInput1.text
                            addressLabel.text = keyInput2.text
                            addressType1 = keyInput2.text
                            receivingAddress = keyInput3.text
                        }
                    }
                    Text {
                        text: "DONE"
                        font.family: "Brandon Grotesque"
                        font.pointSize: 14
                        font.bold: true
                        color: "#5E8BFF"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            Controls.AddressBookSquares {
                id: address_2
                anchors.top: address.bottom
                anchors.topMargin: 7
                anchors.left: parent.left
                anchors.leftMargin: 25
                name: addressName2
                numberAddresses: 1
                height: clickedAddSquare2 == 0 ? 75 : 150

                Image {
                    width: 25
                    height: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 8
                    source: '../icons/expand_buttons.svg'
                }
                Rectangle {
                    id: expandAddressArea_2
                    width: 40
                    height: 25
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -5
                    color: "transparent"
                    MouseArea {
                        anchors.fill: expandAddressArea_2
                        onClicked: {
                            if(clickedAddSquare2 == 0){
                                clickedAddSquare2 = 1
                                return
                            }
                            if(clickedAddSquare2 == 1 ){
                                clickedAddSquare2 = 0
                                return
                            }
                        }
                    }
                }
                Image {
                    id: icon_2
                    width: 20
                    height: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    source: '../icons/XBY_card_logo_colored_05.svg'
                    visible: clickedAddSquare2 == 1
                }
                Label {
                    anchors.left: icon_2.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: icon_2.verticalCenter
                    text: "XBY"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare2 == 1
                }
                Label {
                    id: addressLabel_2
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: icon_2.verticalCenter
                    text: "Main"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare2 == 1
                }
                Image {
                    id: editAddress_2
                    width: 20
                    height: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    source: '../icons/edit.svg'
                    visible: clickedAddSquare2 == 1
                    ColorOverlay {
                        anchors.fill: editAddress_2
                        source: editAddress_2
                        color: "#DADADA"
                    }
                    MouseArea {
                        anchors.fill: editAddress_2
                        onClicked: {
                            editAddressTracker2 = 1
                        }
                    }
                }
                Rectangle {
                    id: dividerLine_2
                    visible: clickedAddSquare2 == 1
                    width: address_2.width - 20
                    height: 1
                    color: "#575757"
                    anchors.top: icon_2.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: modal_2
                height: 300
                width: 325
                color: "#42454F"
                radius: 4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 150
                visible: editAddressTracker2 == 1
                z: 100
                Rectangle {
                    id: modalTop_2
                    height: 50
                    width: modal_2.width
                    anchors.bottom: modal_2.top
                    anchors.left: modal_2.left
                    color: "#34363D"
                    radius: 4
                }
                Label{
                    anchors.horizontalCenter: modalTop_2.horizontalCenter
                    anchors.verticalCenter: modalTop_2.verticalCenter
                    color: "White"
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    text: "EDIT ADDRESS"
                }
                Image {
                    id: icon2_2
                    width: 25
                    height: 25
                    anchors.left: keyInput1_2.left
                    anchors.leftMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 25
                    source: '../icons/XBY_card_logo_colored_05.svg'
                    visible: clickedAddSquare2 == 1
                }
                Label {
                    id: label1_2
                    anchors.left: icon2_2.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: icon2_2.verticalCenter
                    text: "XBY"
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare2 == 1
                }
                Image {
                    source: '../icons/dropdown_icon.svg'
                    width: 15
                    height: 15
                    anchors.left: label1_2.right
                    anchors.leftMargin: 8
                    anchors.verticalCenter: label1_2.verticalCenter
                }
                Controls.TextInput {
                    id: keyInput1_2
                    height: 34
                    placeholder: "Edit Name"
                    text: address_2.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: icon2_2.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker2 == 1
                }
                Image {
                    id: textFieldEmpty1_2
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput1_2.verticalCenter
                    anchors.right: keyInput1_2.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty1_2.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty1_2
                        source: textFieldEmpty1_2
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput1ButtonArea_2
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty1_2.left
                        anchors.bottom: textFieldEmpty1_2.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput1ButtonArea_2
                            onClicked: {
                                keyInput1_2.text = ""
                            }
                        }
                    }
                }
                Controls.TextInput {
                    id: keyInput2_2
                    height: 34
                    placeholder: "Edit Label"
                    text: addressLabel_2.text
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: keyInput1_2.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker2 == 1
                }
                Image {
                    id: textFieldEmpty2_2
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput2_2.verticalCenter
                    anchors.right: keyInput2_2.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty2_2.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty2_2
                        source: textFieldEmpty2_2
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput2ButtonArea_2
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty2_2.left
                        anchors.bottom: textFieldEmpty2_2.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput2ButtonArea_2
                            onClicked: {
                                keyInput2_2.text = ""
                            }
                        }
                    }
                }
                Controls.TextInput {
                    id: keyInput3_2
                    height: 34
                    placeholder: "Edit Address"
                    text: receivingAddress2
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: keyInput2_2.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker2 == 1
                }
                Image {
                    id: textFieldEmpty3_2
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput3_2.verticalCenter
                    anchors.right: keyInput3_2.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty3_2.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty3_2
                        source: textFieldEmpty3_2
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput3ButtonArea_2
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty3_2.left
                        anchors.bottom: textFieldEmpty3_2.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput3ButtonArea_2
                            onClicked: {
                                keyInput3_2.text = ""
                            }
                        }
                    }
                }
                Rectangle {
                    id: editConfirm_2
                    width: keyInput1_2.width
                    height: 33
                    radius: 8
                    border.color: "#5E8BFF"
                    border.width: 2
                    color: "transparent"
                    anchors.top: keyInput3_2.bottom
                    anchors.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: editAddressTracker2 == 1
                    MouseArea {
                        anchors.fill: editConfirm_2

                        onClicked: {
                            editAddressTracker2 = 0
                            addressName2 = keyInput1_2.text
                            addressType2 = keyInput2_2.text
                            addressLabel_2.text = keyInput2_2.text
                            receivingAddress2 = keyInput3_2.text
                        }
                    }
                    Text {
                        text: "DONE"
                        font.family: "Brandon Grotesque"
                        font.pointSize: 14
                        font.bold: true
                        color: "#5E8BFF"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            /**
          * address 3
          */
            Controls.AddressBookSquares {
                id: address_3
                anchors.top: address_2.bottom
                anchors.topMargin: 7
                anchors.left: parent.left
                anchors.leftMargin: 25
                name: addressName3
                numberAddresses: 1
                height: clickedAddSquare3 == 0 ? 75 : 150

                Image {
                    width: 25
                    height: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 8
                    source: '../icons/expand_buttons.svg'
                }
                Rectangle {
                    id: expandAddressArea_3
                    width: 40
                    height: 25
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -5
                    color: "transparent"
                    MouseArea {
                        anchors.fill: expandAddressArea_3
                        onClicked: {
                            if(clickedAddSquare3 == 0){
                                clickedAddSquare3 = 1
                                return
                            }
                            if(clickedAddSquare3 == 1 ){
                                clickedAddSquare3 = 0
                                return
                            }
                        }
                    }
                }
                Image {
                    id: icon_3
                    width: 20
                    height: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    source: '../icons/XBY_card_logo_colored_05.svg'
                    visible: clickedAddSquare3 == 1
                }
                Label {
                    anchors.left: icon_3.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: icon_3.verticalCenter
                    text: "XBY"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare3 == 1
                }
                Label {
                    id: addressLabel_3
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: icon_3.verticalCenter
                    text: "Main"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare3 == 1
                }
                Image {
                    id: editAddress_3
                    width: 20
                    height: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    source: '../icons/edit.svg'
                    visible: clickedAddSquare3 == 1
                    ColorOverlay {
                        anchors.fill: editAddress_3
                        source: editAddress_3
                        color: "#DADADA"
                    }
                    MouseArea {
                        anchors.fill: editAddress_3
                        onClicked: {
                            editAddressTracker3 = 1
                        }
                    }
                }
                Rectangle {
                    id: dividerLine_3
                    visible: clickedAddSquare3 == 1
                    width: address_3.width - 20
                    height: 1
                    color: "#575757"
                    anchors.top: icon_3.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: modal_3
                height: 300
                width: 325
                color: "#42454F"
                radius: 4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 150
                visible: editAddressTracker3 == 1
                z: 100
                Rectangle {
                    id: modalTop_3
                    height: 50
                    width: modal_3.width
                    anchors.bottom: modal_3.top
                    anchors.left: modal_3.left
                    color: "#34363D"
                    radius: 4
                }
                Label{
                    anchors.horizontalCenter: modalTop_3.horizontalCenter
                    anchors.verticalCenter: modalTop_3.verticalCenter
                    color: "White"
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    text: "EDIT ADDRESS"
                }
                Image {
                    id: icon2_3
                    width: 25
                    height: 25
                    anchors.left: keyInput1_3.left
                    anchors.leftMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 25
                    source: '../icons/XBY_card_logo_colored_05.svg'
                    visible: clickedAddSquare3 == 1
                }
                Label {
                    id: label1_3
                    anchors.left: icon2_3.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: icon2_3.verticalCenter
                    text: "XBY"
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare3 == 1
                }
                Image {
                    source: '../icons/dropdown_icon.svg'
                    width: 15
                    height: 15
                    anchors.left: label1_3.right
                    anchors.leftMargin: 8
                    anchors.verticalCenter: label1_3.verticalCenter
                }
                Controls.TextInput {
                    id: keyInput1_3
                    height: 34
                    placeholder: "Edit Name"
                    text: address_3.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: icon2_3.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker3 == 1
                }
                Image {
                    id: textFieldEmpty1_3
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput1_3.verticalCenter
                    anchors.right: keyInput1_3.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty1_3.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty1_3
                        source: textFieldEmpty1_3
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput1ButtonArea_3
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty1_3.left
                        anchors.bottom: textFieldEmpty1_3.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput1ButtonArea_3
                            onClicked: {
                                keyInput1_3.text = ""
                            }
                        }
                    }
                }
                Controls.TextInput {
                    id: keyInput2_3
                    height: 34
                    placeholder: "Edit Label"
                    text: addressLabel_3.text
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: keyInput1_3.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker3 == 1
                }
                Image {
                    id: textFieldEmpty2_3
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput2_3.verticalCenter
                    anchors.right: keyInput2_3.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty2_3.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty2_3
                        source: textFieldEmpty2_3
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput2ButtonArea_3
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty2_3.left
                        anchors.bottom: textFieldEmpty2_3.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput2ButtonArea_3
                            onClicked: {
                                keyInput2_3.text = ""
                            }
                        }
                    }
                }
                Controls.TextInput {
                    id: keyInput3_3
                    height: 34
                    placeholder: "Edit Address"
                    text: receivingAddress3
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: keyInput2_3.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker3 == 1
                }
                Image {
                    id: textFieldEmpty3_3
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput3_3.verticalCenter
                    anchors.right: keyInput3_3.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty3_3.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty3_3
                        source: textFieldEmpty3_3
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput3ButtonArea_3
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty3_3.left
                        anchors.bottom: textFieldEmpty3_3.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput3ButtonArea_3
                            onClicked: {
                                keyInput3_3.text = ""
                            }
                        }
                    }
                }
                Rectangle {
                    id: editConfirm_3
                    width: keyInput1_3.width
                    height: 33
                    radius: 8
                    border.color: "#5E8BFF"
                    border.width: 2
                    color: "transparent"
                    anchors.top: keyInput3_3.bottom
                    anchors.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: editAddressTracker3 == 1
                    MouseArea {
                        anchors.fill: editConfirm_3

                        onClicked: {
                            editAddressTracker3 = 0
                            addressName3 = keyInput1_3.text
                            addressType3 = keyInput2_3.text
                            addressLabel_3.text = keyInput2_3.text
                            receivingAddress3 = keyInput3_3.text
                        }
                    }
                    Text {
                        text: "DONE"
                        font.family: "Brandon Grotesque"
                        font.pointSize: 14
                        font.bold: true
                        color: "#5E8BFF"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            /**
          * address 4
          */
            Controls.AddressBookSquares {
                id: address_4
                anchors.top: address_3.bottom
                anchors.topMargin: 7
                anchors.left: parent.left
                anchors.leftMargin: 25
                name: addressName4
                numberAddresses: 1
                height: clickedAddSquare4 == 0 ? 75 : 150

                Image {
                    width: 25
                    height: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 8
                    source: '../icons/expand_buttons.svg'
                }
                Rectangle {
                    id: expandAddressArea_4
                    width: 40
                    height: 25
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -5
                    color: "transparent"
                    MouseArea {
                        anchors.fill: expandAddressArea_4
                        onClicked: {
                            if(clickedAddSquare4 == 0){
                                clickedAddSquare4 = 1
                                return
                            }
                            if(clickedAddSquare4 == 1 ){
                                clickedAddSquare4 = 0
                                return
                            }
                        }
                    }
                }
                Image {
                    id: icon_4
                    width: 20
                    height: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    source: '../icons/XBY_card_logo_colored_05.svg'
                    visible: clickedAddSquare4 == 1
                }
                Label {
                    anchors.left: icon_4.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: icon_4.verticalCenter
                    text: "XBY"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare4 == 1
                }
                Label {
                    id: addressLabel_4
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: icon_4.verticalCenter
                    text: "Main"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare4 == 1
                }
                Image {
                    id: editAddress_4
                    width: 20
                    height: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    source: '../icons/edit.svg'
                    visible: clickedAddSquare4 == 1
                    ColorOverlay {
                        anchors.fill: editAddress_4
                        source: editAddress_4
                        color: "#DADADA"
                    }
                    MouseArea {
                        anchors.fill: editAddress_4
                        onClicked: {
                            editAddressTracker4 = 1
                        }
                    }
                }
                Rectangle {
                    id: dividerLine_4
                    visible: clickedAddSquare4 == 1
                    width: address_4.width - 20
                    height: 1
                    color: "#575757"
                    anchors.top: icon_4.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: modal_4
                height: 300
                width: 325
                color: "#42454F"
                radius: 4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 150
                visible: editAddressTracker4 == 1
                z: 100
                Rectangle {
                    id: modalTop_4
                    height: 50
                    width: modal_4.width
                    anchors.bottom: modal_4.top
                    anchors.left: modal_4.left
                    color: "#34363D"
                    radius: 4
                }
                Label{
                    anchors.horizontalCenter: modalTop_4.horizontalCenter
                    anchors.verticalCenter: modalTop_4.verticalCenter
                    color: "White"
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    text: "EDIT ADDRESS"
                }
                Image {
                    id: icon2_4
                    width: 25
                    height: 25
                    anchors.left: keyInput1_4.left
                    anchors.leftMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 25
                    source: '../icons/XBY_card_logo_colored_05.svg'
                    visible: clickedAddSquare4 == 1
                }
                Label {
                    id: label1_4
                    anchors.left: icon2_4.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: icon2_4.verticalCenter
                    text: "XBY"
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare4 == 1
                }
                Image {
                    source: '../icons/dropdown_icon.svg'
                    width: 15
                    height: 15
                    anchors.left: label1_4.right
                    anchors.leftMargin: 8
                    anchors.verticalCenter: label1_4.verticalCenter
                }
                Controls.TextInput {
                    id: keyInput1_4
                    height: 34
                    placeholder: "Edit Name"
                    text: address_4.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: icon2_4.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker4 == 1
                }
                Image {
                    id: textFieldEmpty1_4
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput1_4.verticalCenter
                    anchors.right: keyInput1_4.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty1_4.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty1_4
                        source: textFieldEmpty1_4
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput1ButtonArea_4
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty1_4.left
                        anchors.bottom: textFieldEmpty1_4.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput1ButtonArea_4
                            onClicked: {
                                keyInput1_4.text = ""
                            }
                        }
                    }
                }
                Controls.TextInput {
                    id: keyInput2_4
                    height: 34
                    placeholder: "Edit Label"
                    text: addressLabel_4.text
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: keyInput1_4.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker4 == 1
                }
                Image {
                    id: textFieldEmpty2_4
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput2_4.verticalCenter
                    anchors.right: keyInput2_4.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty2_4.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty2_4
                        source: textFieldEmpty2_4
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput2ButtonArea_4
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty2_4.left
                        anchors.bottom: textFieldEmpty2_4.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput2ButtonArea_4
                            onClicked: {
                                keyInput2_4.text = ""
                            }
                        }
                    }
                }
                Controls.TextInput {
                    id: keyInput3_4
                    height: 34
                    placeholder: "Edit Address"
                    text: receivingAddress4
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: keyInput2_4.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker4 == 1
                }
                Image {
                    id: textFieldEmpty3_4
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput3_4.verticalCenter
                    anchors.right: keyInput3_4.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty3_4.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty3_4
                        source: textFieldEmpty3_4
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput3ButtonArea_4
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty3_4.left
                        anchors.bottom: textFieldEmpty3_4.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput3ButtonArea_4
                            onClicked: {
                                keyInput3_4.text = ""
                            }
                        }
                    }
                }
                Rectangle {
                    id: editConfirm_4
                    width: keyInput1_4.width
                    height: 33
                    radius: 8
                    border.color: "#5E8BFF"
                    border.width: 2
                    color: "transparent"
                    anchors.top: keyInput3_4.bottom
                    anchors.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: editAddressTracker4 == 1
                    MouseArea {
                        anchors.fill: editConfirm_4

                        onClicked: {
                            editAddressTracker4 = 0
                            addressName4 = keyInput1_4.text
                            addressType4 = keyInput2_4.text
                            addressLabel_4.text = keyInput2_4.text
                            receivingAddress4 = keyInput3_4.text
                        }
                    }
                    Text {
                        text: "DONE"
                        font.family: "Brandon Grotesque"
                        font.pointSize: 14
                        font.bold: true
                        color: "#5E8BFF"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            /**
          * address 5
          */
            Controls.AddressBookSquares {
                id: address_5
                anchors.top: address_4.bottom
                anchors.topMargin: 7
                anchors.left: parent.left
                anchors.leftMargin: 25
                name: addressName5
                numberAddresses: 1
                height: clickedAddSquare5 == 0 ? 75 : 150

                Image {
                    width: 25
                    height: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 8
                    source: '../icons/expand_buttons.svg'
                }
                Rectangle {
                    id: expandAddressArea_5
                    width: 40
                    height: 25
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -5
                    color: "transparent"
                    MouseArea {
                        anchors.fill: expandAddressArea_5
                        onClicked: {
                            if(clickedAddSquare5 == 0){
                                clickedAddSquare5 = 1
                                return
                            }
                            if(clickedAddSquare5 == 1 ){
                                clickedAddSquare5 = 0
                                return
                            }
                        }
                    }
                }
                Image {
                    id: icon_5
                    width: 20
                    height: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    source: '../icons/XBY_card_logo_colored_05.svg'
                    visible: clickedAddSquare5 == 1
                }
                Label {
                    anchors.left: icon_5.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: icon_5.verticalCenter
                    text: "XBY"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare5 == 1
                }
                Label {
                    id: addressLabel_5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: icon_5.verticalCenter
                    text: "Main"
                    font.pixelSize: 12
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare5 == 1
                }
                Image {
                    id: editAddress_5
                    width: 20
                    height: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    source: '../icons/edit.svg'
                    visible: clickedAddSquare5 == 1
                    ColorOverlay {
                        anchors.fill: editAddress_5
                        source: editAddress_5
                        color: "#DADADA"
                    }
                    MouseArea {
                        anchors.fill: editAddress_5
                        onClicked: {
                            editAddressTracker5 = 1
                        }
                    }
                }
                Rectangle {
                    id: dividerLine_5
                    visible: clickedAddSquare5 == 1
                    width: address_5.width - 20
                    height: 1
                    color: "#575757"
                    anchors.top: icon_5.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: modal_5
                height: 300
                width: 325
                color: "#42454F"
                radius: 4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 150
                visible: editAddressTracker5 == 1
                z: 100
                Rectangle {
                    id: modalTop_5
                    height: 50
                    width: modal_5.width
                    anchors.bottom: modal_5.top
                    anchors.left: modal_5.left
                    color: "#34363D"
                    radius: 4
                }
                Label{
                    anchors.horizontalCenter: modalTop_5.horizontalCenter
                    anchors.verticalCenter: modalTop_5.verticalCenter
                    color: "White"
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    text: "EDIT ADDRESS"
                }
                Image {
                    id: icon2_5
                    width: 25
                    height: 25
                    anchors.left: keyInput1_5.left
                    anchors.leftMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 25
                    source: '../icons/XBY_card_logo_colored_05.svg'
                    visible: clickedAddSquare5 == 1
                }
                Label {
                    id: label1_5
                    anchors.left: icon2_5.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: icon2_5.verticalCenter
                    text: "XBY"
                    font.pixelSize: 14
                    font.family: "Brandon Grotesque"
                    color: "#E5E5E5"
                    font.bold: true
                    visible: clickedAddSquare5 == 1
                }
                Image {
                    source: '../icons/dropdown_icon.svg'
                    width: 15
                    height: 15
                    anchors.left: label1_5.right
                    anchors.leftMargin: 8
                    anchors.verticalCenter: label1_5.verticalCenter
                }
                Controls.TextInput {
                    id: keyInput1_5
                    height: 34
                    placeholder: "Edit Name"
                    text: address_5.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: icon2_5.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker5 == 1
                }
                Image {
                    id: textFieldEmpty1_5
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput1_5.verticalCenter
                    anchors.right: keyInput1_5.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty1_5.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty1_5
                        source: textFieldEmpty1_5
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput1ButtonArea_5
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty1_5.left
                        anchors.bottom: textFieldEmpty1_5.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput1ButtonArea_5
                            onClicked: {
                                keyInput1_5.text = ""
                            }
                        }
                    }
                }
                Controls.TextInput {
                    id: keyInput2_5
                    height: 34
                    placeholder: "Edit Label"
                    text: addressLabel_5.text
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: keyInput1_5.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker5 == 1
                }
                Image {
                    id: textFieldEmpty2_5
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput2_5.verticalCenter
                    anchors.right: keyInput2_5.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty2_5.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty2_5
                        source: textFieldEmpty2_5
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput2ButtonArea_5
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty2_5.left
                        anchors.bottom: textFieldEmpty2_5.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput2ButtonArea_5
                            onClicked: {
                                keyInput2_5.text = ""
                            }
                        }
                    }
                }
                Controls.TextInput {
                    id: keyInput3_5
                    height: 34
                    placeholder: "Edit Address"
                    text: receivingAddress5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: keyInput2_5.bottom
                    anchors.topMargin: 20
                    color: "#727272"
                    font.pixelSize: 11
                    font.family: "Brandon Grotesque"
                    font.bold: true
                    visible: editAddressTracker5 == 1
                }
                Image {
                    id: textFieldEmpty3_5
                    source: '../icons/CloseIcon.svg'
                    anchors.verticalCenter: keyInput3_5.verticalCenter
                    anchors.right: keyInput3_5.right
                    anchors.rightMargin: 10
                    width: textFieldEmpty3_5.height
                    height: 12
                    ColorOverlay {
                        anchors.fill: textFieldEmpty3_5
                        source: textFieldEmpty3_5
                        color: "#727272"
                    }
                    Rectangle {
                        id: keyInput3ButtonArea_5
                        width: 20
                        height: 20
                        anchors.left: textFieldEmpty3_5.left
                        anchors.bottom: textFieldEmpty3_5.bottom
                        color: "transparent"
                        MouseArea {
                            anchors.fill: keyInput3ButtonArea_5
                            onClicked: {
                                keyInput3_5.text = ""
                            }
                        }
                    }
                }
                Rectangle {
                    id: editConfirm_5
                    width: keyInput1_5.width
                    height: 33
                    radius: 8
                    border.color: "#5E8BFF"
                    border.width: 2
                    color: "transparent"
                    anchors.top: keyInput3_5.bottom
                    anchors.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: editAddressTracker5 == 1
                    MouseArea {
                        anchors.fill: editConfirm_5

                        onClicked: {
                            editAddressTracker5 = 0
                            addressName5 = keyInput1_5.text
                            addressType5 = keyInput2_5.text
                            addressLabel_5.text = keyInput2_5.text
                            receivingAddress5 = keyInput3_5.text
                        }
                    }
                    // done
                    Text {
                        text: "DONE"
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
    }
}


