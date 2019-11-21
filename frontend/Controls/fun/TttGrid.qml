/**
* Filename: TttGrid.qml
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
import SortFilterProxyModel 0.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.11
import QtQuick.Window 2.2

import "qrc:/Controls" as Controls

Rectangle {
    width: parent.width
    height: parent.height
    color: "transparent"
    clip :true

    Component {
        id: buttonSquare

        Item {
            width: grid.cellWidth
            height: grid.cellHeight

            Image {
                id: playedImage
                source: played == false? '': (player == "me"? 'qrc:/icons/XFUEL_logo_big.svg' : 'qrc:/icons/XBY_logo_big.svg')
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
                height: parent.height * 0.75
                width: parent.width * 0.75
                fillMode: Image.PreserveAspectFit
                visible: played
            }

            Rectangle {
                width: parent.width - 5
                height: parent.height - 5
                color: "transparent"
                border.width: 2
                border.color: maincolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent
                    enabled: !played

                    onClicked: {
                        console.log("clicked button nr: " + number)
                        tttGameStarted = true
                        tttButtonClicked(number)
                    }
                }
            }

        }
    }

    GridView {
        id: grid
        anchors.fill: parent
        cellWidth: parent.width/3; cellHeight: parent.width/3

        model: buttonList
        delegate: buttonSquare
    }
}
