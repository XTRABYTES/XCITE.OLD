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
import SortFilterProxyModel 0.2

Rectangle {
    id: completePicklist
    width: 120
    height: parent.height - 25
    color: "#2A2C31"

    Component {
        id: picklistEntry

        Rectangle {
            id: picklistRow
            width: 120
            height: 35
            color: "transparent"

            Rectangle {
                id: clickIndicator
                anchors.fill: parent
                color: "white"
                opacity: 0.25
                visible: false
            }

            AnimatedImage  {
                id: waitingDots
                source: 'qrc:/gifs/loading-gif_01.gif'
                width: 90
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                playing: saveCurrency == true
                visible: saveCurrency == true? (userSettings.defaultCurrency === currencyNR? true : false) : false
            }

            Label {
                id: currencyName
                text: currency
                color: "#F2F2F2"
                font.pixelSize: 16
                font.family: xciteMobile.name
                anchors.verticalCenter: picklistRow.verticalCenter
                anchors.left: picklistRow.left
                anchors.leftMargin: 7
                visible: saveCurrency == true? (userSettings.defaultCurrency === currencyNR? false : true) : true
            }

            Label {
                id: currencyTicker
                text: ticker
                color: "#F2F2F2"
                font.pixelSize: 16
                font.family: xciteMobile.name
                anchors.verticalCenter: picklistRow.verticalCenter
                anchors.right: picklistRow.right
                anchors.rightMargin: 7
                visible: saveCurrency == true? (userSettings.defaultCurrency === currencyNR? false : true) : true
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    clickIndicator.visible = true
                    click01.play()
                    detectInteraction()
                }

                onCanceled: {
                    clickIndicator.visible = false
                }

                onReleased: {
                    clickIndicator.visible = false
                }

                onClicked: {
                    if (saveCurrency == false) {
                        clickIndicator.visible = false
                        oldCurrency = userSettings.defaultCurrency
                        userSettings.defaultCurrency = currencyNR;
                        saveCurrency = true
                        updateToAccount()
                    }
                }

                Connections {
                    target: UserSettings

                    onSaveSucceeded: {
                        if (currencyTracker === 1) {
                            currencyTracker = 0
                            sumBalance()
                            saveCurrency =false
                        }
                    }

                    onSaveFailed: {
                        if (currencyTracker === 1) {
                            userSettings.defaultCurrency = oldCurrency
                            currencyChangeFailed = 1
                            saveCurrency = false
                        }
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#5F5F5F"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                visible: index < (fiatCurrencies.count - 1) ? true : false
            }
        }
    }

    ListView {
        anchors.fill: parent
        id: pickList
        model: fiatCurrencies
        delegate: picklistEntry
        contentHeight: fiatCurrencies.count * 35
        onDraggingChanged: detectInteraction()
    }
}
