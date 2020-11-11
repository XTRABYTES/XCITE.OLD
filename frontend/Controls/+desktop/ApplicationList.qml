/**
* Filename: ApplicationList.qml
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
    id: applications
    width: parent.width
    height: parent.width
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    color: "transparent"

    Component {
        id: applicationSquare

        Item {
            width: grid.cellWidth
            height: grid.cellHeight

            Rectangle {
                id: rect01
                height: appWidth/7.5
                width: height*0.85
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 1
                color: "transparent"
                border.width: 1
                border.color: maincolor
            }

            Rectangle {
                id: rect02
                height: appWidth/7.5
                width: height*0.85
                anchors.top: parent.top
                anchors.topMargin: 3
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -1
                color: "transparent"
                border.width: 1
                border.color: themecolor
            }

            Rectangle {
                id: selectIndicator
                anchors.top: rect02.top
                anchors.bottom: rect01.bottom
                anchors.right: rect02.right
                anchors.left: rect01.left
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Image {
                id: appIcon
                source: darktheme == true? icon_white : icon_black
                anchors.horizontalCenter: selectIndicator.horizontalCenter
                anchors.verticalCenter: selectIndicator.verticalCenter
                height: appWidth/18
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: appName
                text: name
                width: grid.cellWidth
                horizontalAlignment: Text.AlignHCenter
                elide: Text.ElideRight
                anchors.horizontalCenter: selectIndicator.horizontalCenter
                anchors.bottom: rect02.bottom
                anchors.bottomMargin: font.pixelSize/2
                font.pixelSize: appHeight/48
                font.family: "Brandon Grotesque"
                color: darktheme == true? "#F2F2F2" : "#2A2C31"
                font.letterSpacing: 2
            }

            Rectangle {
                anchors.fill: selectIndicator
                color: "transparent"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        selectIndicator.visible = true
                    }

                    onExited: {
                        selectIndicator.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                        selectIndicator.opacity = 0.6
                    }

                    onCanceled: {
                        selectIndicator.visible = false
                        selectIndicator.opacity = 0.6
                    }

                    onClicked: {
                        selectedApp = name
                        openApplication(selectedApp)
                        selectIndicator.visible = false
                        selectIndicator.opacity = 0.3
                    }
                }
            }
        }
    }

    GridView {
        id: grid
        width: parent.width
        height: parent.height
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        cellWidth: parent.width/4
        cellHeight: appWidth/6

        model: applicationList
        delegate: applicationSquare
    }
}
