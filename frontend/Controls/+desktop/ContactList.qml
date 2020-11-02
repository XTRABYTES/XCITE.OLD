/**
 * Filename: Contactst.qml
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
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: allWalletCards
    width: parent.width - appWidth/12
    height: parent.height
    color: "transparent"

    property string searchFilter: ""

    Label {
        id: noResultLabel
        text: "No contacts matching your search criteria."
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: xciteMobile.name
        font.pixelSize: appHeight/36
        color: themecolor
        visible: filteredContacts.count == 0 && searchFilter != ""
    }

    Component {
        id: contactCard

        Item {
            width: grid.cellWidth
            height: grid.cellHeight

            Rectangle {
                id: currencyRow
                color: "transparent"
                width: allWalletCards.width
                height: appHeight/12
                anchors.horizontalCenter: parent.horizontalCenter
            }

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
                    width: parent.width - appWidth/24
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth/24
                    color: maincolor
                    opacity: 0.3
                    visible: false
                }

                Rectangle {
                    width: parent.width - appWidth/24
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth/24
                    color: "transparent"
                    border.width: 0.5
                    border.color: themecolor
                    opacity: 0.1
                }

                Rectangle {
                    width: parent.width - appWidth/12
                    height: parent.height*0.8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth/24
                    color: "transparent"

                    Image {
                        id: icon
                        source: profilePictures.get(0).photo
                        anchors.left: parent.left
                        anchors.leftMargin: appWidth/48
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height*2/3
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: contacttName
                        text: lastName !== ""? (firstName + " " + lastName) : firstName
                        anchors.left: icon.right
                        anchors.leftMargin: appWidth/96
                        anchors.right: parent.right
                        anchors.rightMargin: appWidth/48
                        anchors.top: parent.top
                        anchors.topMargin: parent.height/6
                        font.pixelSize: parent.height/3
                        font.family: xciteMobile.name
                        font.bold: true
                        color: themecolor
                        elide: Text.ElideRight
                    }

                    Label {
                        id: addresses
                        text: addressesCount.text === 1? "address" : "addresses"
                        anchors.left: addressesCount.right
                        anchors.leftMargin: parent.height/3
                        anchors.right: parent.right
                        anchors.rightMargin: appWidth/48
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: parent.height/6
                        font.pixelSize: parent.height/3 *0.8
                        font.family: xciteMobile.name
                        color: themecolor
                    }

                    Label {
                        id: addressesCount
                        text: countAddressesContact(contactNR)
                        anchors.left: contacttName.left
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: parent.height/6
                        font.pixelSize: parent.height/3 *0.8
                        font.family: xciteMobile.name
                        color: themecolor
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
                            detectInteraction()
                            click01.play()
                        }

                        onClicked: {
                            contactIndex = contactNR
                            contactTracker = 1
                        }
                    }
                }
            }
        }
    }

    SortFilterProxyModel {
        id: filteredContacts
        sourceModel: contactList
        filters: [
            ValueFilter {
                roleName: "remove"
                value: false
            },
            AnyOf {
                RegExpFilter {
                    roleName: "firstName"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "lastName"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
            }

        ]
        sorters: [
            RoleSorter { roleName: "lastName" ; sortOrder: Qt.AscendingOrder },
            StringSorter { roleName: "firstName" }
        ]
    }

    GridView {
        id: grid
        width: parent.width
        height: parent.height
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        cellWidth: parent.width/2
        cellHeight: appHeight/9

        model: filteredContacts
        delegate: contactCard
    }
}
