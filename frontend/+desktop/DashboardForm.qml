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
import "qrc:/Controls/+desktop" as Desktop

Item {
    width: appWidth
    height: appHeight
    clip: true

    Component.onCompleted: {
        dashboardIndex = 1
        mainStack.push("qrc:/+desktop/Wallet.qml")
    }

    Rectangle {
        id: sideMenuArea
        width: appWidth/6
        height: appHeight
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        color: darktheme == true? "#0B0B09" : "#F2F2F2"

        Item {
            id: appID
            width: parent.width
            height: appName.height + appVersion.height + 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.width/3

            Item {
                id: appName
                width: xciteLabel.width + trademark.width + 5
                height: xciteLabel.height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    id: xciteLabel
                    text: "XCITE"
                    color: themecolor
                    font.pixelSize: appID.width/6
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    textFormat: Text.RichText
                }

                Label {
                    id: trademark
                    text: "TM"
                    color: themecolor
                    font.family: xciteMobile.name
                    font.pixelSize: xciteLabel.font.pixelSize/3
                    anchors.top: xciteLabel.top
                    anchors.topMargin: font.pixelSize/2 * 0.75
                    anchors.right: parent.right
                    font.bold: true
                }            }

            Label {
                id: appVersion
                text: "v " + versionNR
                color: themecolor
                font.family: xciteMobile.name
                font.pixelSize: xciteLabel.font.pixelSize/3
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
            }
        }

        Item {
            id: sideMenu
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: appID.bottom
            anchors.topMargin: parent.width/3
            anchors.bottom: logoutSection.top
            anchors.bottomMargin: parent.width/3

            Rectangle {
                id: walletSection
                width: parent.width
                height: parent.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                color: "transparent"

                Rectangle {
                    width: parent.width*0.99
                    height: parent.height*0.85
                    anchors.left: parent.left
                    anchors.top: parent.top
                    color: darktheme == true? "#14161B" : "#FDFDFD"
                    border.width: 2
                    border.color: (selectedPage == "home" && pageTracker == 0)? maincolor : "transparent"

                    Rectangle {
                        width: 5
                        height: parent.height
                        anchors.left: parent.left
                        anchors.top: parent.top
                        color: (selectedPage == "home" && pageTracker == 0)? maincolor : "transparent"
                    }

                    Image {
                        id: walletIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        source: darktheme == true? "qrc:/icons/wallet/WALLETF2F2F2.png" : "qrc:/icons/wallet/WALLET14161B.png"
                        height: parent.height/2
                        width: parent.height/2
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        text: "WALLET"
                        color: themecolor
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            selectedPage = "home"
                            pageTracker = 0
                            dashboardIndex = 1
                        }
                    }
                }
            }

            Rectangle {
                id: backupSection
                width: parent.width
                height: parent.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: walletSection.bottom
                color: "transparent"

                Rectangle {
                    width: parent.width*0.99
                    height: parent.height*0.85
                    anchors.left: parent.left
                    anchors.top: parent.top
                    color: darktheme == true? "#14161B" : "#FDFDFD"
                    border.width: 2
                    border.color: selectedPage == "backup"? maincolor : "transparent"

                    Rectangle {
                        width: 5
                        height: parent.height
                        anchors.left: parent.left
                        anchors.top: parent.top
                        color: (selectedPage == "backup")? maincolor : "transparent"
                    }

                    Image {
                        id: backupIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        source: darktheme == true? "qrc:/icons/backup/BACKUPF2F2F2.png" : "qrc:/icons/backup/BACKUP14161B.png"
                        height: parent.height/2
                        width: parent.height/2
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        text: "BACKUP"
                        color: themecolor
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            if (userSettings.pinlock === true) {
                                backupTracker = 1
                                pincodeTracker = 1
                            }
                            else {
                                appsTracker = 0
                                selectedPage = "backup"
                            }
                        }

                        Timer {
                            id: timer3
                            interval: 1000
                            repeat: false
                            running: false

                            onTriggered: {
                                selectedPage = "backup"
                            }
                        }

                        Connections {
                            target: UserSettings
                            onPincodeCorrect: {
                                if (pincodeTracker == 1 && backupTracker == 1) {
                                    timer3.start()
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: appsSection
                width: parent.width
                height: parent.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: backupSection.bottom
                color: "transparent"

                Rectangle {
                    width: parent.width*0.99
                    height: parent.height*0.85
                    anchors.left: parent.left
                    anchors.top: parent.top
                    color: darktheme == true? "#14161B" : "#FDFDFD"
                    border.width: 2
                    border.color: selectedPage == "apps"? maincolor : "transparent"

                    Rectangle {
                        width: 5
                        height: parent.height
                        anchors.left: parent.left
                        anchors.top: parent.top
                        color: (selectedPage == "apps")? maincolor : "transparent"
                    }

                    Image {
                        id: appsIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        source: darktheme == true? "qrc:/icons/apps/APPSF2F2F2.png" : "qrc:/icons/apps/APPS14161B.png"
                        height: parent.height/2
                        width: parent.height/2
                        fillMode: Image.PreserveAspectFit
                    }
                    Label {
                        text: "APPS"
                        color: themecolor
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked:  {
                            selectedPage = "apps"
                        }
                    }
                }
            }

            Rectangle {
                id: alertSection
                width: parent.width
                height: parent.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: appsSection.bottom
                color: "transparent"

                Rectangle {
                    width: parent.width*0.99
                    height: parent.height*0.85
                    anchors.left: parent.left
                    anchors.top: parent.top
                    color: darktheme == true? "#14161B" : "#FDFDFD"
                    border.width: 2
                    border.color: selectedPage == "notif"? maincolor : "transparent"

                    Rectangle {
                        width: 5
                        height: parent.height
                        anchors.left: parent.left
                        anchors.top: parent.top
                        color: (selectedPage == "notif")? maincolor : "transparent"
                    }

                    Image {
                        id: alertIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        source: darktheme == true? "qrc:/icons/notification/notificationF2F2F2.png" : "qrc:/icons/notification/notification14161B.png"
                        height: parent.height/2
                        width: parent.height/2
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        text: "ALERTS"
                        color: themecolor
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked:  {
                            selectedPage = "notif"
                        }
                    }
                }
            }

            Rectangle {
                id: addressbookSection
                width: parent.width
                height: parent.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: alertSection.bottom
                color: "transparent"

                Rectangle {
                    width: parent.width*0.99
                    height: parent.height*0.85
                    anchors.left: parent.left
                    anchors.top: parent.top
                    color: darktheme == true? "#14161B" : "#FDFDFD"
                    border.width: 2
                    border.color: (selectedPage == "home" && pageTracker == 1)? maincolor : "transparent"

                    Rectangle {
                        width: 5
                        height: parent.height
                        anchors.left: parent.left
                        anchors.top: parent.top
                        color: (selectedPage == "home" && pageTracker == 1)? maincolor : "transparent"
                    }

                    Image {
                        id: addressbookIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        source: darktheme == true? "qrc:/icons/address/ADDRESSF2F2F2.png" : "qrc:/icons/address/ADDRESS14161B.png"
                        height: parent.height/2
                        width: parent.height/2
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        text: "ADDRESSBOOK"
                        color: themecolor
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            selectedPage = "home"
                            pageTracker = 1
                            dashboardIndex = 0
                        }
                    }
                }
            }

            Rectangle {
                id: settingsSection
                width: parent.width
                height: parent.height/6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: addressbookSection.bottom
                color: "transparent"

                Rectangle {
                    width: parent.width*.99
                    height: parent.height*0.85
                    anchors.left: parent.left
                    anchors.top: parent.top
                    color: darktheme == true? "#14161B" : "#FDFDFD"
                    border.width: 2
                    border.color: selectedPage == "settings"? maincolor : "transparent"

                    Rectangle {
                        width: 5
                        height: parent.height
                        anchors.left: parent.left
                        anchors.top: parent.top
                        color: (selectedPage == "settings")? maincolor : "transparent"
                    }

                    Image {
                        id: settingsIcon
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        source: darktheme == true? "qrc:/icons/settings/settingsF2F2F2.png" : "qrc:/icons/settings/settings14161B.png"
                        height: parent.height/2
                        width: parent.height/2
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: settingsLabel
                        text: "SETTINGS"
                        color: themecolor
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            selectedPage = "settings"
                        }
                    }
                }
            }
        }

        Item {
            id: logoutSection
            width: sideMenuArea.width
            height: logoutIcon.height
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15

            Image {
                id: logoutIcon
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: 10
                source: 'qrc:/icons/logout/LOGOUT0ED8D2.png'
                width: settingsIcon.width
                height: settingsIcon.height
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: logoutText
                text: "LOG OUT"
                color: maincolor
                font.family: xciteMobile.name
                font.pixelSize: settingsLabel.font.pixelSize
                anchors.verticalCenter: logoutIcon.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: settingsSection.height*0.85
            }

            Rectangle {
                id: logoutButtonArea
                anchors.fill: parent
                color: "transparent"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        click01.play()
                        detectInteraction()
                        sessionStart = 0
                        sessionTime = 0
                        manualLogout = 1
                        logoutTracker = 1
                    }
                }
            }
        }
    }

    Rectangle {
        id: mainArea
        height: appHeight
        anchors.left: sideMenuArea.right
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        color: darktheme == true? "#14161B" : "#FDFDFD"
        clip: true

        StackView {
            id: mainStack
            anchors.fill: parent
            initialItem: "qrc:/Controls/+desktop/Loading.qml"
        }

        Image {
            id: darklight
            anchors.right: parent.right
            anchors.rightMargin: width
            anchors.top: parent.top
            anchors.topMargin: height
            source: darktheme == true? 'qrc:/icons/theme/THEMEF2F2F2.png' : 'qrc:/icons/theme/THEME0ED8D2.png'
            width: logoutIcon.width
            height: logoutIcon.height
            fillMode: Image.PreserveAspectFit

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
                        if (darktheme == true) {
                            userSettings.theme = "light"
                        }
                        else {
                            userSettings.theme = "dark"
                        }
                    }
                }
            }
        }

        Text {
            id: loginLabel
            text: "Logged in as:"
            color: themecolor
            font.pixelSize: logoutText.font.pixelSize
            font.family: xciteMobile.name
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
        }

        Text {
            id: loginName
            text: myUsername
            color: themecolor
            font.pixelSize: logoutText.font.pixelSize
            font.family: xciteMobile.name
            anchors.left: loginLabel.right
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
        }

        Image {
            id: combinationMark
            source: darktheme == true?  'qrc:/icons/xby_logo_with_name.png' : 'qrc:/icons/xby_logo_with_name_dark.png'
            width: appWidth*0.3
            fillMode: Image.PreserveAspectFit
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: -50
        }
    }

    Mobile.ClickToLogout {
        z: 100
        anchors.left: parent.left
        anchors.top: parent.top
        visible: clickToLogout == 1
    }
}
