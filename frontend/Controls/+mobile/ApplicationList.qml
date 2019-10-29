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
    width: parent.width
    height: parent.height
    anchors.top: parent.top
    color: "transparent"
    clip :true

    Flickable {
        width: parent.width
        height: parent.heigt
        flickableDirection: Flickable.VerticalFlick

        Component {
            id: applicationSquare

            Item {
                width: grid.cellWidth
                height: grid.cellHeight

                Image {
                        id: appIcon
                        source: darktheme == true? icon_white : icon_black
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        height: 60
                        width: 60
                        fillMode: Image.PreserveAspectFit

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"

                            MouseArea {
                                anchors.fill: parent

                                onClicked: {
                                    console.log("app button pushed")
                                    selectedApp = name
                                    openApplication(selectedApp)
                                }
                            }
                        }
                }

                Text {
                        id: appName
                        text: name
                        width: grid.cellWidth
                        horizontalAlignment: Text.AlignHCenter
                        elide: Text.ElideRight
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        font.pixelSize: 14
                        font.family: "Brandon Grotesque"
                        color: darktheme == true? "#F2F2F2" : "#2A2C31"
                        font.letterSpacing: 2
                }
            }
        }

        GridView {
            id: grid
            anchors.fill: parent
            cellWidth: parent.width/3; cellHeight: 105

            model: applicationList
            delegate: applicationSquare
        }
    }

}
