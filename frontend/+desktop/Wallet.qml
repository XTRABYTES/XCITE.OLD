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
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: backgroundHome
    z: 1
    width: appWidth/6 * 5
    height: appHeight
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    color: "transparent" //bgcolor

    property var balanceArray: ((totalBalance).toLocaleString(Qt.locale("en_US"), "f", 2)).split('.')
    property string searchCriteria:""
    property int swipeBack: dashboardIndex

    onSwipeBackChanged: {
        if(swipeBack == 1) {
            view.currentIndex = 0
        }
        else {
            view.currentIndex = 1
        }
    }

    Rectangle {
        id: homeView
        z: 1
        width: appWidth/6 * 5
        height: appHeight
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
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
            interactive: false
            clip: true

            onCurrentIndexChanged: {
                detectInteraction()
                pageTracker = view.currentIndex
            }

            Item {
                id: wallet

                Label {
                    id: walletLabel
                    text: "WALLET"
                    anchors.right: parent.right
                    anchors.rightMargin: appWidth/12
                    anchors.top: parent.top
                    anchors.topMargin: appWidth/24
                    font.pixelSize: appHeight/18
                    font.family: xciteMobile.name
                    color: darktheme == true? "#F2F2F2" : "#2A2C31"
                    font.letterSpacing: 2
                }
            }

            Item {
                id: addressBook

                Label {
                    id: addressbookLabel
                    text: "ADDRESSBOOK"
                    anchors.right: parent.right
                    anchors.rightMargin: appWidth/12
                    anchors.top: parent.top
                    anchors.topMargin: appWidth/24
                    font.pixelSize: appHeight/18
                    font.family: xciteMobile.name
                    color: darktheme == true? "#F2F2F2" : "#2A2C31"
                    font.letterSpacing: 2
                }
            }
        }
    }
}
