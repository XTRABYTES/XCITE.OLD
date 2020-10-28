/**
 * Filename: NotificationList.qml
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
import QtQuick.Window 2.2
import SortFilterProxyModel 0.2
import QtGraphicalEffects 1.0

import "qrc:/Controls" as Controls

Rectangle {
    id: allAlertCards
    width: parent.width
    height: parent.height
    color: "transparent"

    property int selectedAlert:0

    Component {
        id: alertCard

        Rectangle {
            id: alertRow
            color: "transparent"
            width: allAlertCards.width
            height: appHeight/12
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: square
                width: parent.width
                height: parent.height
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                clip: true

                Rectangle {
                    id: selectionIndicator
                    width: parent.width - appWidth*3/24
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: appWidth/12
                    color: maincolor
                    opacity: 0.1
                    visible: false
                }

                Rectangle {
                    width: parent.width - appWidth*3/24
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: appWidth/12
                    color: "transparent"
                    border.width: 0.5
                    border.color: themecolor
                    opacity: 0.1
                }

                Rectangle {
                    id: alertIcon
                    height: parent.height/3
                    width: height
                    radius: height/2
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth*3/48
                    anchors.verticalCenter: parent.verticalCenter
                    color: type == "alert"? "green" : (type == "warning"? "yellow" : "red")
                }

                Label {
                    id: notificationDate
                    text: date
                    anchors.left: alertIcon.right
                    anchors.leftMargin: alertIcon.x - selectionIndicator.x
                    anchors.bottom: notificationOrigin.top
                    anchors.topMargin: 1
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/5
                    color: themecolor
                }

                Label {
                    id: notificationOrigin
                    text: origin
                    anchors.left: notificationDate.left
                    anchors.right: parent.right
                    anchors.rightMargin: appWidth/12
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/5
                    font.bold: true
                    color: themecolor
                    elide: Text.ElideRight
                }

                Label {
                    id: notificationMessage
                    wrapMode: Text.Wrap
                    text: message
                    anchors.left: notificationDate.left
                    anchors.top: notificationOrigin.bottom
                    anchors.topMargin: 1
                    anchors.right: parent.right
                    anchors.rightMargin: appWidth/12
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/5
                    color: themecolor
                    elide: Text.ElideRight
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        selectionIndicator.visible = true
                    }

                    onExited: {
                        selectionIndicator.visible = false
                    }

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        selectedAlert = index
                    }
                }
            }
        }
    }

    SortFilterProxyModel {
        id: filteredAlerts
        sourceModel: alertList
        filters: [
            ValueFilter {
                roleName: "remove"
                value: false
            }
        ]
    }

    ListView {
        id: allAlerts
        model: filteredAlerts
        delegate: alertCard
        spacing: 0
        anchors.fill: parent
        onDraggingChanged: detectInteraction()
    }
}
