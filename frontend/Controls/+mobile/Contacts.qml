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

Rectangle {
    id: allWalletCards
    width: Screen.width
    height: parent.height - 75
    color: "transparent"

    property alias cardSpacing: allContacts.spacing
    property string searchFilter: ""

    Label {
        id: noResultLabel
        text: "No contacts matching your search criteria."
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.top: parent.top
        anchors.topMargin: 30
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        font.family: xciteMobile.name
        font.pixelSize: 18
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: filteredContacts.count == 0 && searchFilter != ""
    }

    Component {
        id: contactCard

        Rectangle {
            id: cardRow
            color: "transparent"
            width: Screen.width
            height: 100
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: square
                width: parent.width
                height: parent.height
                radius: 4
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                clip: true

                Controls.CardBody {

                }

                Image {
                    id: icon
                    source: profilePictures.get(0).photo
                    anchors.left: parent.left
                    anchors.leftMargin: 28
                    anchors.verticalCenter: parent.verticalCenter
                    width: 70
                    height: 70
                }

                Label {
                    id: contacttName
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.left: icon.right
                    anchors.leftMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 17
                    text: lastName != ""? (firstName + " " + lastName) : firstName
                    font.pixelSize: 20
                    font.family: xciteMobile.name
                    font.letterSpacing: 2
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    id: addresses
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    text: addressesCount.text === 1? "address" : "addresses"
                    font.pixelSize: 18
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Label {
                    id: addressesCount
                    anchors.right: addresses.left
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    text: countAddressesContact(contactNR)
                    font.pixelSize: 18
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        detectInteraction()
                    }

                    onClicked: {
                        click01.play()
                        contactIndex = contactNR
                        contactTracker = 1
                    }

                    onPressAndHold: {
                        contactIndex = contactNR
                        console.log("contact index = " + contactIndex)
                        console.log("contactname: " + contactList.get(contactIndex).firstName)
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
        contentHeight: (filteredContacts.count * 100)
        interactive: appsTracker == 0 && addAddressTracker == 0 && addContactTracker == 0 && transferTracker == 0
        onDraggingChanged: detectInteraction()

    }
}
