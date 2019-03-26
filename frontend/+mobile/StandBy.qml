/**
 * Filename: StandBy.qml
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

import "qrc:/Controls" as Controls

Rectangle {
   id: standbyModal
   width: Screen.width
   height: Screen.height
   color: bgcolor

   Text {
       id: standbyModalLabel
       text: "STAND BY MODUS"
       anchors.horizontalCenter: parent.horizontalCenter
       anchors.top: parent.top
       anchors.topMargin: 10
       font.pixelSize: 20
       font.family: "Brandon Grotesque"
       color: darktheme == true? "#F2F2F2" : "#2A2C31"
       font.letterSpacing: 2
   }

   Label {
       id:proceedLabel
           text: "How do you wish to continue?"
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.verticalCenter: parent.verticalCenter
           anchors.verticalCenterOffset: -50
           font.pixelSize: 20
           font.family: "Brandon Grotesque"
           color: darktheme == true? "#F2F2F2" : "#2A2C31"
   }

   Rectangle {
       id: reactivateButton
       width: (doubbleButtonWidth - 10) / 2
       height: 34
       anchors.top: proceedLabel.bottom
       anchors.topMargin: 20
       anchors.right: parent.horizontalCenter
       anchors.rightMargin: 5
       color: "#4BBE2E"
       opacity: 0.5

       MouseArea {
           anchors.fill: reactivateButton

           onPressed: {
               click01.play()
               detectInteraction()
           }

           onCanceled: {
           }

           onReleased: {
           }

           onClicked: {
               if(userSettings.pinlock === true) {
                   pincodeTracker = 1
               }
               else {
                   standBy = 0
                   mainRoot.pop()
               }
           }
       }

       Connections {
           target: UserSettings

           onPincodeCorrect: {
               if (pinOK == 1 && standBy == 1) {
                   pincodeTracker = 0
                   pinOK = 0
                   standBy = 0
                   mainRoot.pop()
               }
           }
       }
   }
   Text {
       text: "REACTIVATE"
       font.family: xciteMobile.name
       font.pointSize: 14
       color: "#4BBE2E"
       font.bold: true
       opacity: 0.75
       anchors.horizontalCenter: reactivateButton.horizontalCenter
       anchors.verticalCenter: reactivateButton.verticalCenter
   }

   Rectangle {
       width: (doubbleButtonWidth - 10) / 2
       height: 34
       anchors.bottom: reactivateButton.bottom
       anchors.right: reactivateButton.right
       color: "transparent"
       border.color: "#4BBE2E"
       border.width: 1
       opacity: 0.75
   }

   Rectangle {
       id: logoutButton
       width: (doubbleButtonWidth - 10) / 2
       height: 34
       anchors.top: proceedLabel.bottom
       anchors.topMargin: 20
       anchors.left: parent.horizontalCenter
       anchors.leftMargin: 5
       color: "#E55541"
       opacity: darktheme == true? 0.25 : 0.5

       MouseArea {
           anchors.fill: logoutButton

           onPressed: {
               click01.play()
               detectInteraction()
           }

           onCanceled: {
           }

           onReleased: {
           }

           onClicked: {
               goodbey = 1
               standBy = 0
               mainRoot.pop()
           }
       }
   }

   Text {
       text: "LOG OUT"
       font.family: xciteMobile.name
       font.pointSize: 14
       font.bold: true
       color: "#E55541"
       opacity: darktheme == true? 0.5 : 0.75
       anchors.horizontalCenter: logoutButton.horizontalCenter
       anchors.verticalCenter: logoutButton.verticalCenter
   }

   Rectangle {
       width: (doubbleButtonWidth - 10) / 2
       height: 34
       anchors.horizontalCenter: logoutButton.horizontalCenter
       anchors.verticalCenter: logoutButton.verticalCenter
       color: "transparent"
       border.color: "#E55541"
       border.width: 1
       opacity: darktheme == true? 0.5 : 0.75
   }

   Controls.Pincode {
       id: myPincode
       z: 5
       anchors.top: parent.top
       anchors.left: parent.left
   }

   Item {
       z: 3
       width: Screen.width
       height: 125
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
}
