/**
* Filename: CurrencyPicklist.qml
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
import QtQuick.Window 2.2


Rectangle {
    id: completePicklist
    width: 100
    height: totalLines * 35
    radius: 5
    color: "#2A2C31"

    function picklistLines(){
        totalLines = 0
        for(var i = 0; i < currencyList.count; i++) {
            totalLines += 1
        }
        return totalLines
    }

    Component.onCompleted: picklistLines()

    Component {
        id: picklistEntry

        Rectangle {
            id: picklistRow
            width: 100
            height: 35
            color: "transparent"

            Image {
                id: picklistCoinLogo
                source: logo
                height: 20
                width: 20
                anchors.left: parent.left
                anchors.leftMargin: 7
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                id: pickListCoinName
                text: name
                color: "#F2F2F2"
                font.pixelSize: 16
                font.family: "Brandon Grotesque"
                font.weight: Font.Medium
                anchors.verticalCenter: picklistCoinLogo.verticalCenter
                anchors.left: picklistCoinLogo.right
                anchors.leftMargin: 7
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    newCoinPicklist = index;
                    newCoinSelect = 1
                    picklistTracker = 0
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#5F5F5F"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                visible: index < totalLines ? true : false
            }
        }
    }



    ListView {
        anchors.fill: parent
        id: pickList
        model: currencyList
        delegate: picklistEntry
        interactive: false
    }
}

