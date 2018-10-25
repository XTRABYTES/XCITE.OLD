/**
* Filename: AddressPicklist.qml
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



Rectangle {
    width: parent.width
    height: parent.height
    color: "transparent"

    property int selectedWallet: 0
    property string searchFilter:  (selectedWallet == 0 ? "XBY":
                                    (selectedWallet == 1 ? "XFUEL" :
                                        (selectedWallet == 2 ? "BTC" : "ETH")))

    Component {
        id: contactLine

        Rectangle {
            id: contactsRow
            width: parent.width - 55
            anchors.horizontalCenter: parent.horizontalCenter
            height: 45

            color:"transparent"

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    addressbookTracker = 0;
                    selectedAddress = address
                }
            }

            Image {
                id: addressCoinLogo
                source: logo
                width: 20
                height: 20
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                id: addressContactName
                text: name
                anchors.left: addressCoinLogo.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: 18
                font.weight: Font.Medium
                color: "#F2F2F2"
            }
            /**
            Label {
                id: addressLabelName
                text: label
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Brandon Grotesque"
                font.pixelSize: 18
                color: "#F2F2F2"
            }
            */
        }
    }

    SortFilterProxyModel {
        id: filteredAddresses
        sourceModel: addressList
        filters: RegExpFilter {
            roleName: "coin"
            pattern: searchFilter
        }
    }

    ListView {
        anchors.fill: parent
        id: picklist
        model: filteredAddresses
        delegate: contactLine
    }
}
