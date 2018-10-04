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


/**
 * Main page
 */
Item {
    property int sw: -1
    property int appsTracker: 0
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

    z: 2
    id: dashForm
    /**
      * discuss new design decision.. drop shadow?
    Rectangle {
        id: bottomRect
        z: 100
        color: "#42454F"
        opacity: 0.1
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width
        height: 50
        DropShadow {
                anchors.fill: bottomRect
                radius: 0
                color: "#80000000"
                source: bottomRect
            }
    }
    */
    Rectangle {
        color: "black"
        opacity: .8
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height
        width: parent.width
        z: 5
        visible: transferTracker == 1 || historyTracker == 1 || appsTracker == 1
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
                appsTracker = 0
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

    RowLayout {
        id: headingLayout
        anchors.top: dashForm.top
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        Label {
            id: overview
            text: "OVERVIEW"
            font.pixelSize: 12
            font.family: "Brandon Grotesque"
            font.bold: true
            color: "#5E8BFE"
            Rectangle {
                id: titleLine
                width: overview.width
                height: 2
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
            font.bold: true
            MouseArea {
                anchors.fill: add5
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
    /**
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
            source: '../icons/add_icon_04.svg'
            width: 18
            height: 18
            ColorOverlay {
                anchors.fill: plus
                source: plus
                color: "#5E8BFF"
            }
        }
    }
    Controls.CurrencySquare {
        id: square1
        anchors.top: parent.top
        // 210
        anchors.topMargin: 165
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/XBY_card_logo_colored_05.svg'
        currencyType2: "XBY"
        percentChange: "+%.8"
        gainLossTracker: 1
        height: clickedSquare == 1 ? 166 : 75
        value: ((marketValue.marketValue*100)/100).toLocaleString(
                   Qt.locale(), "f", 4)
        // since expandbutton is very tiny and hard to click we put an invisible rectangle here to mimic the dots
        Rectangle {
            id: expandButtonArea
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
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
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/XFUEL_card_logo_colored_07.svg'
        currencyType2: "XFUEL"
        percentChange: "+0%"
        gainLossTracker: 0
        amountSize: "0"
        totalValue: "0"
        value: "0"
        height: clickedSquare2 == 1 ? 166 : 75
        // since expandbutton is very tiny and hard to click we put an invisible rectangle here to mimic the dots
        Rectangle {
            id: expandButtonArea2
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
            color: "transparent"
            MouseArea {
                anchors.fill: expandButtonArea2
                /**
                  * disable for now while only XBY can be traded
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
                */
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
            width: 145
            height: 40
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: dividerLine2.bottom
            anchors.left: dividerLine2.left
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
        anchors.left: parent.left
        anchors.leftMargin: 25
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
        anchors.left: parent.left
        anchors.leftMargin: 25
        currencyType: '../icons/NEO_card_logo_colored_02.svg'
        currencyType2: "NEO"
        percentChange: "+0%"
        gainLossTracker: 0
        amountSize: "0"
        totalValue: "0"
        value: "0"
        height: clickedSquare5 == 1 ? 166 : 75
        z: 0
        Rectangle {
            id: expandButtonArea5
            width: 40
            height: 25
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -5
            color: "transparent"

            MouseArea {
                anchors.fill: expandButtonArea5
                /**
                  * disable for now while only XBY can be traded
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
                */
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

    Image {
        id: apps
        source: '../icons/mobile-menu.svg'
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.verticalCenter: headingLayout.verticalCenter
        width: 22
        height: 17
        z: 100
        visible: appsTracker == 0
        ColorOverlay {
            anchors.fill: apps
            source: apps
            color: "#5E8BFF"
        }
        MouseArea {
            anchors.fill: apps
            onClicked: appsTracker = 1
        }
    }

    Controls.Sidebar{
        anchors.left: parent.left
        anchors.top: parent.top
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

