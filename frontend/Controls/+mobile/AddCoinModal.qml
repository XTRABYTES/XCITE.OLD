/**
 * Filename: TransactionModal.qml
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
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQml.Models 2.11

import "qrc:/Controls" as Controls

Rectangle {
    id: addCoinModal
    width: 325
    height: (editSaved == 1)? 230 : 330
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 50

    property int editSaved: 0

    property string coinName1: ""
    property int favorite1: 0
    property int active1: 1

    property string coinName2: ""
    property int favorite2: 0
    property int active2: 1

    property string coinName3: ""
    property int favorite3: 0
    property int active3: 1

    property string coinName4: ""
    property int favorite4: 0
    property int active4: 1

    Rectangle {
        id: addCoinTitleBar
        width: parent.width
        height: 50
        radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: "#34363D"

        Text {
            id: addCoinModalLabel
            text: "MANAGE COINS"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -3
            font.pixelSize: 18
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"
            font.letterSpacing: 2
        }
    }

    Rectangle {
        id: addCoinBodyModal
        width: parent.width
        height: parent.height - 50
        radius: 4
        color: "#42454F"
        anchors.top: parent.top
        anchors.topMargin: 46
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: favoriteCoin1
            source: 'qrc:/icons/icon-favorite.svg'
            width: 22
            height: 21
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 25
            visible: editSaved == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: favorite1 == 1 ? "#FDBC40" : "transparent"
            }

            MouseArea {
                anchors.fill: parent
                enabled: active1 == 1

                onClicked: {
                    if (favorite1 == 0) {
                        favorite1 = 1
                        currencyList.setProperty(0, "favorite", 1)
                    }
                    else {
                        favorite1 = 0
                        currencyList.setProperty(0, "favorite", 0)
                    }
                }
            }
        }

        Label {
            id: coin1
            text: coinName1
            anchors.left: favoriteCoin1.right
            anchors.leftMargin: 10
            anchors.verticalCenter: favoriteCoin1.verticalCenter
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: switch1.state === "on" ? "#F2F2F2" : "#5F5F5F"
            visible: editSaved == 0
        }

        Controls.Switch_mobile {
            id: switch1
            anchors.verticalCenter: favoriteCoin1.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 25
            state: active1 ? "on" : "off"
            visible: editSaved == 0
        }

        Image {
            id: favoriteCoin2
            source: 'qrc:/icons/icon-favorite.svg'
            width: 22
            height: 21
            anchors.top: favoriteCoin1.bottom
            anchors.topMargin: 25
            anchors.left: parent.left
            anchors.leftMargin: 25
            visible: editSaved == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: favorite2 ? "#FDBC40" : "transparent"
            }

            MouseArea {
                anchors.fill: parent
                enabled: active2 == 1

                onClicked: {
                    if (favorite2 == 0) {
                        favorite2 = 1
                        currencyList.setProperty(1, "favorite", 1)
                    }
                    else {
                        favorite2 = 0
                        currencyList.setProperty(1, "favorite", 0)
                    }
                }
            }
        }

        Label {
            id: coin2
            text: coinName2
            anchors.left: favoriteCoin2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: favoriteCoin2.verticalCenter
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: switch2.state === "on" ? "#F2F2F2" : "#5F5F5F"
            visible: editSaved == 0
        }

        Controls.Switch_mobile {
            id: switch2
            anchors.verticalCenter: favoriteCoin2.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 25
            state: active2 === 1 ? "on" : "off"
            visible: editSaved == 0
        }

        Image {
            id: favoriteCoin3
            source: 'qrc:/icons/icon-favorite.svg'
            width: 22
            height: 21
            anchors.top: favoriteCoin2.bottom
            anchors.topMargin: 25
            anchors.left: parent.left
            anchors.leftMargin: 25
            visible: editSaved == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: favorite3 === 1 ? "#FDBC40" : "transparent"
            }

            MouseArea {
                anchors.fill: parent
                enabled: active3 == 1

                onClicked: {
                    if (favorite3 == 0) {
                        favorite3 = 1
                        currencyList.setProperty(2, "favorite", 1)
                    }
                    else {
                        favorite3 = 0
                        currencyList.setProperty(2, "favorite", 0)
                    }
                }
            }
        }

        Label {
            id: coin3
            text: coinName3
            anchors.left: favoriteCoin3.right
            anchors.leftMargin: 10
            anchors.verticalCenter: favoriteCoin3.verticalCenter
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: switch3.state === "on" ? "#F2F2F2" : "#5F5F5F"
            visible: editSaved == 0
        }

        Controls.Switch_mobile {
            id: switch3
            anchors.verticalCenter: favoriteCoin3.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 25
            state: active3 ? "on" : "off"
            visible: editSaved == 0
        }

        Image {
            id: favoriteCoin4
            source: 'qrc:/icons/icon-favorite.svg'
            width: 22
            height: 21
            anchors.top: favoriteCoin3.bottom
            anchors.topMargin: 25
            anchors.left: parent.left
            anchors.leftMargin: 25
            visible: editSaved == 0

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: favorite4 === 1 ? "#FDBC40" : "transparent"
            }

            MouseArea {
                anchors.fill: parent
                enabled: active4 === 1

                onClicked: {
                    if (favorite4 == 0) {
                        favorite4 = 1
                        currencyList.setProperty(3, "favorite", 1)
                    }
                    else {
                        favorite4 = 0
                        currencyList.setProperty(3, "favorite", 0)
                    }
                }
            }
        }

        Label {
            id: coin4
            text: coinName4
            anchors.left: favoriteCoin4.right
            anchors.leftMargin: 10
            anchors.verticalCenter: favoriteCoin4.verticalCenter
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            font.weight: Font.Bold
            color: switch4.state === "on" ? "#F2F2F2" : "#5F5F5F"
            visible: editSaved == 0
        }

        Controls.Switch_mobile {
            id: switch4
            anchors.verticalCenter: favoriteCoin4.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 25
            state: active4 ? "on" : "off"
            visible: editSaved == 0
        }

        Rectangle {
            id: saveSettingsButton
            width: parent.width - 30
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.top: switch4.bottom
            anchors.topMargin: 35
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 0

            MouseArea {
                anchors.fill: saveSettingsButton

                onClicked: {
                    if (switch1.state == "on") {
                        currencyList.setProperty(0, "active", 1)
                    }
                    else {
                        currencyList.setProperty(0, "active", 0)
                    }
                    if (switch2.state == "on") {
                        currencyList.setProperty(1, "active", 1)
                    }
                    else {
                        currencyList.setProperty(1, "active", 0)
                    }
                    if (switch3.state == "on") {
                        currencyList.setProperty(2, "active", 1)
                    }
                    else {
                        currencyList.setProperty(2, "active", 0)
                    }
                    if (switch4.state == "on") {
                        currencyList.setProperty(3, "active", 1)
                    }
                    else {
                        currencyList.setProperty(3, "active", 0)
                    }

                    sumBalance()
                    // error handeling (not a number, insufficient funds, negative amount, incorrect address)
                }
            }

            Text {
                text: "SAVE"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Text {
            id: saveSuccess
            text: "Your new settings have been saved!"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.weight: Font.Medium
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -15
            visible: editSaved == 1
        }

        Rectangle {
            id: closeSaveEdit
            width: (parent.width - 45) / 2
            height: 33
            radius: 8
            border.color: "#5E8BFF"
            border.width: 2
            color: "transparent"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 1

            MouseArea {
                anchors.fill: closeSaveEdit

                onClicked: {
                    editSaved = 0
                }
            }
            Text {
                text: "OK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#5E8BFF"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
    Label {
        id: closeAddCoinModal
        z: 10
        text: "CLOSE"
        anchors.top: addCoinBodyModal.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: addCoinBodyModal.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: "#F2F2F2"
        visible: addCoinTracker == 1 && editSaved == 0

        MouseArea {
            anchors.fill: closeAddCoinModal

            onClicked: {
                if (addCoinTracker == 1) {
                    addCoinTracker = 0
                }
            }
        }
    }
}



