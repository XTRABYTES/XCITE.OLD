/**
* Filename: ContactInfo.qml
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
    id: backgroundContact
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: parent.right
    anchors.top: parent.top
    color: bgcolor
    state: contactTracker == 1? "up" : "down"
    clip: true

    states: [
        State {
            name: "up"
            PropertyChanges { target: backgroundContact; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: backgroundContact; anchors.topMargin: appHeight}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: backgroundContact; properties: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    property bool myTheme: darktheme

    onMyThemeChanged: {
        addAddressButton.border.color = themecolor

        if (darktheme) {
            editButton.source = "qrc:/icons/edit_icon_light01.png"
        }
        else {
            editButton.source = "qrc:/icons/edit_icon_dark01.png"
        }
    }

    MouseArea {
        anchors.fill: parent
    }

    Label {
        id: firstName
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        anchors.top: parent.top
        anchors.topMargin: appHeight/6
        text: contactList.get(contactIndex).firstName
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        color: themecolor
    }

    Label {
        id: lastName
        anchors.left: firstName.right
        anchors.leftMargin: appHeight/27
        anchors.bottom: firstName.bottom
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        text: contactList.get(contactIndex).lastName
        color: themecolor
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        font.capitalization: Font.AllUppercase
        elide: Text.ElideRight
    }

    Item {
        id: infoArea
        width: (parent.width - appWidth*3/24)/2
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        anchors.top: firstName.bottom
        anchors.topMargin: appHeight/24
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        clip: true

        Image {
            id: photo
            source: profilePictures.get(contactIndex).photo
            anchors.left: parent.left
            anchors.top: parent.top
            height: appWidth/12
            fillMode: Image.PreserveAspectFit
        }

        Label {
            id: telLabel
            text: "Telephone Nr.:"
            anchors.left: parent.left
            anchors.top: photo.bottom
            anchors.topMargin: appHeight/36
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
        }

        Label {
            id: telNr
            text: contactList.get(contactIndex).telNR
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.top: telLabel.top
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
        }

        Label {
            id: cellLabel
            text: "Cellphone Nr.:"
            anchors.left: parent.left
            anchors.top: telLabel.bottom
            anchors.topMargin: appHeight/36
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
        }

        Label {
            id: cellNr
            text: contactList.get(contactIndex).cellNR
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            anchors.top: cellLabel.top
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
        }

        Label {
            id: mailLabel
            text: "E-mail address:"
            anchors.left: parent.left
            anchors.top: cellLabel.bottom
            anchors.topMargin: appHeight/36
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
        }

        Label {
            id: emailAddress
            text: contactList.get(contactIndex).mailAddress
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            maximumLineCount: 2
            wrapMode: Text.WrapAnywhere
            anchors.top: mailLabel.top
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            elide: Text.ElideRight

            Rectangle {
                id: mailLine
                width: parent.implicitWidth
                height: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                color: maincolor
                visible: false
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        mailLine.visible = true
                    }

                    onExited: {
                        mailLine.visible = false
                    }

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
        }

        Label {
            id: chatLabel
            text: "X-CHAT ID.:"
            anchors.left: parent.left
            anchors.top: mailLabel.bottom
            anchors.topMargin: appHeight/36
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            opacity: 0.5
        }

        Label {
            id: xchatID
            text: contactList.get(contactIndex).chatID
            anchors.left: parent.left
            anchors.leftMargin: appWidth/9
            anchors.right: parent.right
            maximumLineCount: 2
            wrapMode: Text.WrapAnywhere
            anchors.top: chatLabel.top
            color: themecolor
            font.pixelSize: appHeight/54
            font.family: xciteMobile.name
            elide: Text.ElideRight

            Rectangle {
                id: chatLine
                width: parent.implicitWidth
                height: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                color: maincolor
                visible: false
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        chatLine.visible = true
                    }

                    onExited: {
                        chatLine.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if(contactList.get(contactIndex).chatID !== "") {

                        }
                    }
                }
            }
        }

        Item {
            id: addAddress
            width: addAddressButton.width + addAddressLabel.width
            height: addAddressButton.height
            anchors.left: parent.left
            anchors.top: chatLabel.bottom
            anchors.topMargin: appHeight/18

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

                }
            }
        }

        Image {
            id: editButton
            source: darktheme == true? "qrc:/icons/edit_icon_light01.png" : "qrc:/icons/edit_icon_dark01.png"
            height: appWidth/48
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: addAddress.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: appWidth/24

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        editButton.source = "qrc:/icons/edit_icon_green01.png"
                    }

                    onExited: {
                        if (darktheme) {
                            editButton.source = "qrc:/icons/edit_icon_light01.png"
                        }
                        else {
                            editButton.source = "qrc:/icons/edit_icon_dark01.png"
                        }
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {

                    }
                }
            }
        }
    }

    Item {
        id: walletArea
        width: (parent.width - appWidth*3/24)/2
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.top: firstName.bottom
        anchors.topMargin: appHeight/24
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        clip: true

        Label {
            id: walletListLabel
            text: "Addresses"
            color: themecolor
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: walletListArea
            width: parent.width
            anchors.top: walletListLabel.bottom
            anchors.topMargin: appHeight/36
            anchors.bottom: parent.bottom
            color: darktheme == true? "#14161B" : "#FDFDFD"
            clip: true

            Desktop.ContactAddressList {
                id: myContactAddressList
                anchors.top: parent.top
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
