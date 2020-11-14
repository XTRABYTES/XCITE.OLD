/**
* Filename: AddressBookPicklist.qml
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

import "qrc:/Controls" as Controls

Rectangle {
    width: parent.width
    height: parent.height
    color: "transparent"
    clip :true

    property bool addressSelected: false
    property int addressCount: filteredAddresses.count

    Component {
        id: contactLine

        Rectangle {
            id: contactsRow
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: appHeight/15
            color:"transparent"
            clip: true

            Rectangle {
                id: clickIndicator
                anchors.fill: parent
                color: maincolor
                opacity: 0.3
                visible: false
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    clickIndicator.visible = true
                }

                onExited: {
                    clickIndicator.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    selectedAddress = address
                    clickIndicator.visible = false
                    addressSelected = true
                    addressbookTracker = 0
                    addressSelected = false
                    selectedAddress = ""
                }
            }

            Label {
                id: addressContactName
                text: contactList.get(contact).firstName + " " + contactList.get(contact).lastName
                anchors.left: parent.left
                anchors.leftMargin: font.pixelSize*2
                anchors.right: addressLabelName.left
                anchors.rightMargin: font.pixelSize
                anchors.top: parent.top
                anchors.topMargin: font.pixelSize/2
                font.family: xciteMobile.name
                font.pixelSize: parent.height/3
                font.capitalization: Font.SmallCaps
                color: themecolor
                elide: Text.ElideRight
            }

            Label {
                id: addressLabelName
                text: "(" + label + ")"
                anchors.right: parent.right
                anchors.rightMargin: font.pixelSize*2
                anchors.top: parent.top
                anchors.topMargin: font.pixelSize/2
                font.family: xciteMobile.name
                font.pixelSize: parent.height/3
                font.letterSpacing: 2
                color: themecolor
            }

            Label {
                id: addressHash
                text: address
                anchors.left: addressContactName.left
                anchors.right: addressLabelName.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: font.pixelSize/2
                font.family: xciteMobile.name
                font.pixelSize: parent.height/4
                color: themecolor
                elide: Text.ElideRight
            }
        }
    }
    SortFilterProxyModel {
        id: filteredAddresses
        sourceModel: addressList
        filters: [
            RegExpFilter {
                roleName: "coin"
                pattern: "^" + selectedCoin + "$"
            },
            ValueFilter {
                roleName: "remove"
                value: false
            }
        ]
        sorters: [
            StringSorter { roleName: "fullname" },
            StringSorter { roleName: "label" }
        ]
    }


    ListView {
        anchors.fill: parent
        id: picklist
        model: filteredAddresses
        delegate: contactLine
        onDraggingChanged: detectInteraction()
    }
}
