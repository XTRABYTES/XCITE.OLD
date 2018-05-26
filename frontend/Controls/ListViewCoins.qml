/**
 * Filename: ListViewCoins.qml
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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4

Rectangle {
    property string backgroundColor: "transparent"
    property string textColor: "#ffffff"
    property string hoverBackgroundColor: "#42454D"
    property string hoverTextColor: textColor

    ListModel {
        id: contactModel
        ListElement {
            name: "DEFAULT"
            number: "BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS"
        }
        ListElement {
            name: "MAIN"
            number: "A2g62BpwyJc5i7upAsd334dakwXqBR3k4H"
        }
    }

    ListView {
        id: root
        model: contactModel
        clip: true
        anchors.fill: parent
        anchors.topMargin: 10

        delegate: Rectangle {
            id: addressContainer
            height: 28
            width: 294
            anchors.left: parent.left
            anchors.leftMargin: 3
            color: backgroundColor

            Text {
                id: addressItem
                text: name
                color: textColor
                font.family: "roboto thin"
                font.pixelSize: 14
                anchors.left: parent.left
                anchors.leftMargin: 22
                anchors.top: parent.top
                anchors.topMargin: 4

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {

                        //root.buttonClicked()
                    }
                    hoverEnabled: true
                    onHoveredChanged: {
                        if (containsMouse) {
                            addressContainer.color = hoverBackgroundColor
                        } else {
                            addressContainer.color = backgroundColor
                        }
                    }
                }
            }
        }
    } //end list view

    Rectangle {
        radius: 5
        color: 'transparent'
        anchors.fill: parent
    }
}
