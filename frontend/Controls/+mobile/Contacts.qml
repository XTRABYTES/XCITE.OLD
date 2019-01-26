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

Rectangle {
    id: allWalletCards
    width: Screen.width
    height: parent.height
    color: "transparent"

    property alias cardSpacing: allContacts.spacing
    property string searchFilter: ""

    Component {
        id: contactCard

        Rectangle {
            id: cardRow
            color: "transparent"
            width: Screen.width
            height: 85
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: square
                width: parent.width - 55
                height: 75
                radius: 4
                color: darktheme == false? "#F2F2F2" : "#1B2934"
                border.width: 1
                border.color: darktheme == false? "#42454F" : "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top

                DropShadow {
                    id: iconShadow
                    anchors.fill: icon
                    source: icon
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    spread: 0
                    color:"black"
                    opacity: 0.3
                    transparentBorder: true
                }

                Image {
                    id: icon
                    source: photo
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    width: 50
                    height: 50
                }

                Label {
                    id: contactLastName
                    anchors.right: parent.right
                    anchors.rightMargin: 14
                    anchors.top: parent.top
                    anchors.topMargin: 12
                    text: lastName
                    font.pixelSize: 16
                    font.family: xciteMobile.name
                    font.capitalization: Font.AllUppercase
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    id: contactFirstName
                    anchors.right: contactLastName.left
                    anchors.rightMargin: 5
                    anchors.verticalCenter: contactLastName.verticalCenter
                    text: firstName
                    font.pixelSize: 16
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    id: addresses
                    anchors.right: parent.right
                    anchors.rightMargin: 14
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    text: addressesCount.text === 1? "address" : "addresses"
                    font.pixelSize: 14
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    id: addressesCount
                    anchors.right: addresses.left
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    text: countAddressesContact(contactNR)
                    font.pixelSize: 14
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        contactIndex = contactNR
                        contactTracker = 1
                    }

                    onPressAndHold: {
                        contactIndex = contactNR
                        editContactTracker = 1
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
                RegExpFilter {
                    roleName: "telNR"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "cellNR"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "mailAddress"
                    pattern: searchFilter
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "chatID"
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

    ListView {
        id: allContacts
        model: filteredContacts
        delegate: contactCard
        spacing: 0
        anchors.fill: parent
        contentHeight: (filteredContacts.count * 85) + 75
        interactive: appsTracker == 0 && addAddressTracker == 0 && addContactTracker == 0 && transferTracker == 0
    }
}
