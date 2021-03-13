/**
 * Filename: WalletList.qml
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
    width: parent.width
    height: parent.height
    color: "transparent"

    property int labelExists: 0
    property int editSaved: 0
    property int editFailed: 0
    property int saveErrorNr: 0
    property bool walletEdited: false
    property string coinName: ""
    property string oldLabel: ""

    function compareLabel(){
        labelExists = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coinName) {
                if (newName.text != "" && walletList.get(i).remove === false && walletList.get(i).label === newName.text) {
                    labelExists = 1
                }
            }
        }
    }

    Component {
        id: walletCard

        Rectangle {
            id: currencyRow
            color: "transparent"
            width: allWalletCards.width
            height: appHeight/6
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
                    opacity: 0.3
                    visible: false
                }

                Rectangle {
                    id: cardBorder
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

                MouseArea {
                    anchors.fill: selectionIndicator
                    hoverEnabled: true
                    enabled: editWalletName == 0

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

                    onReleased: {
                    }

                    onClicked: {
                        console.log(walletName.text + "selected")
                        walletIndex = walletNR
                        if (coinIndex < 3){
                            historyDetailsCollected = false
                            transactionPages = 0
                            currentPage = 1
                            transferTracker = 1
                            historyTracker = 1
                            updateTransactions(name, address, 1)
                        }
                        walletDetailTracker = 1
                    }

                    Connections {
                        target: explorer

                        onUpdateTransactions: {
                            if (historyDetailsCollected === false) {
                                transactionPages = totalPages;
                                loadTransactions(transactions);
                                historyDetailsCollected = true
                            }
                        }
                    }
                }

                Image {
                    id: walletFavorite
                    source: favorite == true ? 'qrc:/icons/mobile/favorite-icon_01_color.svg' : (darktheme === true? 'qrc:/icons/mobile/favorite-icon_01_light.svg' : 'qrc:/icons/mobile/favorite-icon_01_dark.svg')
                    anchors.left: parent.left
                    anchors.leftMargin: appWidth*3/48
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height/5
                    fillMode: Image.PreserveAspectFit
                    state: favorite == true ? "yes" : "no"

                    states: [
                        State {
                            name: "yes"
                            PropertyChanges { target: walletFavorite; width: 20}
                        },
                        State {
                            name: "no"
                            PropertyChanges { target: walletFavorite; width: 18}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "no"
                            to: "yes"
                            NumberAnimation { target: walletFavorite; properties: "width"; duration: 200; easing.type: Easing.OutBack}
                        },
                        Transition {
                            from: "yes"
                            to: "no"
                            NumberAnimation { target: walletFavorite; properties: "width"; duration: 200; easing.type: Easing.InBack}
                        }
                    ]
                }

                Rectangle {
                    id: favoriteButton
                    anchors.fill: walletFavorite
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent
                        enabled: editWalletName == 0

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            if (viewOnly == false) {
                                if (favorite == true) {
                                    //walletList.setProperty(walletNR, "favorite", false)
                                }
                                else {
                                    resetFavorites(name)
                                    walletList.setProperty(walletNR, "favorite", true)
                                }
                            }
                        }
                    }
                }

                Text {
                    id: walletName
                    anchors.left: parent.left
                    anchors.leftMargin: (appWidth*3/48) + (parent.height*2/5)
                    anchors.verticalCenter: parent.verticalCenter
                    text: label
                    font.capitalization: Font.AllUppercase
                    font.pixelSize: appHeight/36
                    font.family: xciteMobile.name
                    font.letterSpacing: 2
                    color: themecolor
                    elide: Text.ElideRight
                }

                Image {
                    id: editButton
                    source: darktheme == true? "qrc:/icons/edit_icon_light01.png" : "qrc:/icons/edit_icon_dark01.png"
                    height: appHeight/45
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: walletName.verticalCenter
                    anchors.left: walletName.right
                    anchors.leftMargin: appWidth/48
                    visible: editWalletName == 0

                    property bool myTheme: darktheme

                    onMyThemeChanged: {
                        if (darktheme) {
                            editButton.source = "qrc:/icons/edit_icon_light01.png"
                        }
                        else {
                            editButton.source = "qrc:/icons/edit_icon_dark01.png"
                        }
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true

                            onEntered: {
                                editButton.source = "qrc:/icons/edit_icon_green01.png"
                            }

                            onExited: {
                                if (darktheme) {
                                    editButton.source = "qrc:/icons/edit_icon_light01.png"
                                }
                                else {
                                    editButton.source = "qrc:/icons/edit_icon_dark01.png"
                                }
                            }

                            onPressed: {
                                click01.play()
                                detectInteraction()
                            }

                            onClicked: {
                                oldLabel = walletList.get(walletIndex).label
                                walletIndex = walletNR
                                coinName = name
                                editWalletName = 1
                            }
                        }
                    }
                }

                Label {
                    id: viewOnlyLabel
                    text: " VIEW ONLY"
                    anchors.left: walletName.left
                    anchors.top:  walletName.bottom
                    anchors.topMargin: 2
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    font.letterSpacing: 2
                    color: "#E55541"
                    visible: viewOnly
                }

                Text {
                    id: amountSizeLabel
                    anchors.right: cardBorder.right
                    anchors.rightMargin: appHeight/72
                    anchors.top: cardBorder.top
                    anchors.topMargin: appHeight/72
                    text: name
                    font.pixelSize: appHeight/36
                    font.family:  xciteMobile.name
                    color: darktheme == false? "#2A2C31" : "#F2F2F2"
                }

                Text {
                    property var totalBalance: balance
                    property int decimals: totalBalance <= 1 ? 8 : (totalBalance <= 1000 ? 4 : 2)
                    property var amountArray: (totalBalance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountSizeLabel1
                    anchors.right: amountSizeLabel.left
                    anchors.rightMargin: 3
                    anchors.bottom: amountSizeLabel.bottom
                    text:  "." + amountArray[1]
                    font.pixelSize: appHeight/36
                    font.family:  xciteMobile.name
                    color: themecolor
                }

                Text {
                    property var totalBalance: balance
                    property int decimals: totalBalance <= 1 ? 8 : (totalBalance <= 1000 ? 4 : 2)
                    property var amountArray: (totalBalance.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
                    id: amountSizeLabel2
                    anchors.right: amountSizeLabel1.left
                    anchors.bottom: amountSizeLabel.bottom
                    text: amountArray[0]
                    font.pixelSize: appHeight/36
                    font.family:  xciteMobile.name
                    color: themecolor
                }

                Label {
                    id: unconfirmedTicker
                    text: name
                    anchors.right: amountSizeLabel.right
                    anchors.top: amountSizeLabel.bottom
                    anchors.topMargin: appHeight/54
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    opacity: coinIndex < 3? 1 : 0.3
                }

                Label {
                    property int decimals: unconfirmedTx(name, address) === 0? 2 : (unconfirmedTx(name, address) <= 1 ? 8 : (unconfirmedTx(name, address) <= 1000 ? 4 : 2))
                    property string unconfirmedAmount: ((unconfirmedTx(name, address)).toLocaleString(Qt.locale("en_US"), "f", decimals))
                    property int updateTracker1: failedPendingTracker
                    property int updateTracker2: updatePendingTracker
                    property int updateTracker3: interactionTracker
                    property int newBalance: newBalanceTracker
                    id: unconfirmedTotal
                    text: unconfirmedAmount
                    anchors.right: unconfirmedTicker.left
                    anchors.bottom: unconfirmedTicker.bottom
                    anchors.rightMargin: 3
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    opacity: coinIndex < 3? 1 : 0.3

                    onNewBalanceChanged: {
                        var unconfirmedDecimals = unconfirmedTx(name, address) === 0? 2 : (unconfirmedTx(name, address) <= 1 ? 8 : (unconfirmedTx(name, address) <= 1000 ? 4 : 2))
                        unconfirmedTotal.text = ((unconfirmedTx(name, address)).toLocaleString(Qt.locale("en_US"), "f", unconfirmedDecimals))
                    }

                    onUpdateTracker1Changed: {
                        if(updateTracker1 == 1) {
                            for (var e = 0; e < pendingList.count; e ++) {
                                if (pendingList.get(e).coin === name && pendingList.get(e).address === address && failedTX === pendingList.get(e).txid) {
                                    decimals = unconfirmedTx(name, address) === 0? 2 : (unconfirmedTx(name, address) <= 1 ? 8 : (unconfirmedTx(name, address) <= 1000 ? 4 : 2))
                                    unconfirmedTotal.text = ((unconfirmedTx(name, address)).toLocaleString(Qt.locale("en_US"), "f", decimals))
                                }
                            }
                        }
                    }

                    onUpdateTracker2Changed: {
                        if(updateTracker2 == 1) {
                            var i = pendingList.count
                            if (pendingList.get(i-1).coin === name && pendingList.get(i-1).address === address) {
                                decimals = unconfirmedTx(name, address) === 0? 2 : (unconfirmedTx(name, address) <= 1 ? 8 : (unconfirmedTx(name, address) <= 1000 ? 4 : 2))
                                unconfirmedTotal.text = ((unconfirmedTx(name, address)).toLocaleString(Qt.locale("en_US"), "f", decimals))
                            }
                        }
                    }
                    
                    onUpdateTracker3Changed: {
                        for (var e = 0; e < pendingList.count; e ++) {
                            if (pendingList.get(e).coin === name && pendingList.get(e).address === address && failedTX === pendingList.get(e).txid) {
                                decimals = unconfirmedTx(name, address) === 0? 2 : (unconfirmedTx(name, address) <= 1 ? 8 : (unconfirmedTx(name, address) <= 1000 ? 4 : 2))
                                unconfirmedTotal.text = ((unconfirmedTx(name, address)).toLocaleString(Qt.locale("en_US"), "f", decimals))
                            }
                        }
                    }
                }

                Label {
                    id: unconfirmedLabel
                    text: "unconfirmed outgoing TXs:"
                    anchors.right: unconfirmedTotal.left
                    anchors.top: unconfirmedTotal.top
                    anchors.rightMargin: appHeight/54
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    opacity: coinIndex < 3? 1 : 0.3
                }

                Label {
                    id: unavailableTicker
                    text: name
                    anchors.right: unconfirmedTicker.right
                    anchors.top: unconfirmedTicker.bottom
                    anchors.topMargin: appHeight/72
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    opacity: coinIndex < 3? 1 : 0.3
                }

                Label {
                    property int decimals: pendingCoins(name, address) === 0? 2 : (pendingCoins(name, address) <= 1 ? 8 : (pendingCoins(name, address) <= 1000 ? 4 : 2))
                    property string unavailableAmount: (pendingCoins(name, address).toLocaleString(Qt.locale("en_US"), "f", decimals))
                    property int updateTracker1: failedPendingTracker
                    property int updateTracker2: updatePendingTracker
                    property int updateTracker3: interactionTracker
                    property int newBalance: newBalanceTracker
                    id: unavailableTotal
                    text: unavailableAmount
                    anchors.right: unavailableTicker.left
                    anchors.bottom: unavailableTicker.bottom
                    anchors.rightMargin: 3
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    opacity: coinIndex < 3? 1 : 0.3

                    onNewBalanceChanged: {
                        var pendingDecimals = pendingCoins(name, address) === 0? 2 : (pendingCoins(name, address) <= 1 ? 8 : (pendingCoins(name, address) <= 1000 ? 4 : 2))
                        unavailableTotal.text = (pendingCoins(name, address).toLocaleString(Qt.locale("en_US"), "f", pendingDecimals))
                    }

                    onUpdateTracker1Changed: {
                        if(updateTracker1 == 1) {
                            for (var e = 0; e < pendingList.count; e ++) {
                                if (pendingList.get(e).coin === name && pendingList.get(e).address === address && failedTX === pendingList.get(e).txid) {
                                    decimals = pendingCoins(name, address) === 0? 2 : (pendingCoins(name, address) <= 1 ? 8 : (pendingCoins(name, address) <= 1000 ? 4 : 2))
                                    unavailableTotal.text = ((pendingCoins(name, address)).toLocaleString(Qt.locale("en_US"), "f", decimals))
                                }
                            }
                        }
                    }

                    onUpdateTracker2Changed: {
                        if(updateTracker2 == 1) {
                            var i = pendingList.count
                            if (pendingList.get(i-1).coin === name && pendingList.get(i-1).address === address) {
                                decimals = pendingCoins(name, address) === 0? 2 : (pendingCoins(name, address) <= 1 ? 8 : (pendingCoins(name, address) <= 1000 ? 4 : 2))
                                unavailableTotal.text = (pendingCoins(name, address).toLocaleString(Qt.locale("en_US"), "f", decimals))
                            }
                        }
                    }
                    
                    onUpdateTracker3Changed: {
                        for (var e = 0; e < pendingList.count; e ++) {
                            if (pendingList.get(e).coin === name && pendingList.get(e).address === address && failedTX === pendingList.get(e).txid) {
                                decimals = pendingCoins(name, address) === 0? 2 : (pendingCoins(name, address) <= 1 ? 8 : (pendingCoins(name, address) <= 1000 ? 4 : 2))
                                unavailableTotal.text = ((pendingCoins(name, address)).toLocaleString(Qt.locale("en_US"), "f", decimals))
                            }
                        }
                    }
                }

                Label {
                    id: unavailableLabel
                    text: "unavailable coins:"
                    anchors.right: unavailableTotal.left
                    anchors.top: unavailableTotal.top
                    anchors.rightMargin: appHeight/54
                    font.pixelSize: appHeight/54
                    font.family: xciteMobile.name
                    color: themecolor
                    opacity: coinIndex < 3? 1 : 0.3
                }
            }
        }
    }

    SortFilterProxyModel {
        id: filteredWallets
        sourceModel: walletList
        filters: [
            RegExpFilter {
                roleName: "name"
                pattern: "^" + getName(coinIndex) + "$"
            },
            ValueFilter {
                roleName: "remove"
                value: false
            }
        ]
        sorters: [
            RoleSorter {
                roleName: "balance"
                sortOrder: Qt.DescendingOrder
            },
            RoleSorter {
                roleName: "label"
                sortOrder: Qt.AscendingOrder
            }
        ]
    }

    ListView {
        id: allWallets
        model: filteredWallets
        delegate: walletCard
        anchors.fill: parent
        onDraggingChanged: detectInteraction()
    }

    Rectangle {
        id: editBg
        anchors.fill: parent
        color: bgcolor
        visible: editWalletName == 1
        opacity: 0.9

        MouseArea {
            anchors.fill: parent
        }
    }

    DropShadow {
        z: 12
        anchors.fill: editNamePopup
        source: editNamePopup
        horizontalOffset: 0
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.4
        transparentBorder: true
        visible: editNamePopup.visible
    }

    Label {
        id: popUpLabel
        text: "EDIT WALLET NAME"
        color: themecolor
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        anchors.horizontalCenter: editNamePopup.horizontalCenter
        anchors.bottom: editNamePopup.top
        anchors.bottomMargin: font.pixelSize/2
        visible: editWalletName == 1 && editSaved == 0 && editFailed == 0
    }

    Rectangle {
        id: editNamePopup
        width: appWidth/6 + appWidth/12
        height: newName.height + newName.anchors.topMargin + saveNameButton.height*2 + saveNameButton.anchors.topMargin
        color: bgcolor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        border.color: themecolor
        border.width: 1
        visible: editWalletName == 1 && editSaved == 0 && editFailed == 0

        Controls.TextInput {
            id: newName
            height: appHeight/18
            width: appWidth/6
            placeholder: walletList.get(walletIndex).label
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: appHeight/27
            color: themecolor
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: height/2
            mobile: 1
            onTextChanged: {
                detectInteraction()
                compareLabel()
            }
        }

        Label {
            id: nameWarning
            text: "Already a wallet with this label!"
            color: "#FD2E2E"
            anchors.left: newName.left
            anchors.leftMargin: font.pixelSize/2
            anchors.top: newName.bottom
            anchors.topMargin: 1
            font.pixelSize: appHeight/72
            font.family: xciteMobile.name
            visible: labelExists == 1
        }

        Rectangle {
            id: saveNameButton
            width: newName.width/2*0.9
            height: appHeight/27
            radius: height/2
            color: "transparent"
            anchors.top: newName.bottom
            anchors.topMargin: appHeight/18
            anchors.left: newName.left
            border.width: 1
            border.color: (newName.text != "" && labelExists == 0)? themecolor : "#727272"

            Rectangle {
                id: selectSaveName
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                text: "SAVE"
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                enabled: (labelExists == 0 && newName.text != "")? true : false


                onEntered: {
                    selectSaveName.visible = true
                }

                onExited: {
                    selectSaveName.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    selectSaveName.visible = false
                    walletList.setProperty(walletIndex, "label", newName.text);
                    editWalletInAddreslist(coinName, walletList.get(walletIndex).address, newName.text, false)
                    if (userSettings.localKeys) {
                        saveErrorNR = 0
                        walletEdited = false
                        editingWallet = true
                        updateToAccount()
                    }
                    else {
                        editSaved = 1
                    }
                }

                Connections {
                    target: UserSettings

                    onSaveSucceeded: {
                        if (editWalletName == 1 && editingWallet == true) {
                            editSaved = 1
                        }
                    }

                    onSaveFailed: {
                        if (editWalletName == 1 && editingWallet == true) {
                            if (walletEdited == true) {
                                walletList.setProperty(walletIndex, "label", oldLabel);
                                editWalletInAddreslist(coinName, walletList.get(walletIndex).address, oldLabel, false)
                                editFailed = 1
                                saveErrorNr = 1
                                walletEdited = false
                            }
                        }
                    }

                    onNoInternet: {
                        if (editWalletName == 1 && editingWallet == true) {
                            networkError = 1
                            if (walletEdited == true) {
                                walletList.setProperty(walletIndex, "label", oldLabel);
                                editWalletInAddreslist(coinName, walletList.get(walletIndex).address, oldLabel, false)
                                editFailed = 1
                                saveErrorNr = 1
                                walletEdited = false
                            }
                        }
                    }

                    onSaveFileSucceeded: {
                        if (editWalletName == 1 && editingWallet == true) {
                            walletEdited = true
                        }
                    }

                    onSaveFileFailed: {
                        if (editWalletName == 1 && editingWallet == true) {
                            walletList.setProperty(walletIndex, "label", oldLabel);
                            editWalletInAddreslist(coinName, walletList.get(walletIndex).address, oldLabel, false)
                            editFailed = 1
                            saveErrorNr = 0
                        }
                    }
                }
            }
        }

        Rectangle {
            id: cancelNameButton
            width: newName.width/2*0.9
            height: appHeight/27
            radius: height/2
            color: "transparent"
            anchors.top: newName.bottom
            anchors.topMargin: appHeight/18
            anchors.right: newName.right
            border.width: 1
            border.color: themecolor

            Rectangle {
                id: selectCancelName
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                text: "CANCEL"
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
                color: parent.border.color
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    selectCancelName.visible = true
                }

                onExited: {
                    selectCancelName.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    newName.text = ""
                    editWalletName = 0
                }
            }
        }
    }

    Item {
        width: appWidth/6 + appWidth/12
        height: savedIcon.height + savedIcon.anchors.topMargin + savedLabel.height + savedLabel.anchors.topMargin + closeSaved.height + closeSaved.anchors.topMargin
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: editSaved == 1 && editWalletName == 1

        Image {
            id: savedIcon
            source: darktheme == true? 'qrc:/icons/mobile/add_address-icon_01_light.svg' : 'qrc:/icons/mobile/add_address-icon_01_dark.svg'
            height: appWidth/24
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: height
        }

        Label {
            id: savedLabel
            text: "Wallet edited!"
            anchors.top: savedIcon.bottom
            anchors.topMargin: font.pixelSize
            anchors.horizontalCenter: parent.horizontalCenter
            color: themecolor
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
        }

        Rectangle {
            id: closeSaved
            width: appWidth/6
            height: appHeight/27
            radius: height/2
            color: "transparent"
            anchors.top: savedLabel.bottom
            anchors.topMargin: height*2
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 1
            border.color: themecolor


            Rectangle {
                id: selectSaveClose
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: closeSaveButtonText
                text: "OK"
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
                color: themecolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    selectSaveClose.visible = true
                }

                onExited: {
                    selectSaveClose.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    editSaved = 0
                    newName.text = ""
                    editWalletName = 0
                }
            }
        }
    }

    Item {
        width: appWidth/6 + appWidth/12
        height: failedDeleteIcon.height + failedDeleteIcon.anchors.topMargin + deleteFailedLabel.height + deleteFailedLabel.anchors.topMargin + closeFailDelete.height + closeFailDelete.anchors.topMargin
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: editFailed == 1 && editWalletName == 1

        Image {
            id: failedDeleteIcon
            source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
            height: appWidth/24
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: height
        }

        Label {
            id: deleteFailedLabel
            text: "Failed to edit your wallet! Try again."
            anchors.top: failedDeleteIcon.bottom
            anchors.topMargin: font.pixelSize
            anchors.horizontalCenter: parent.horizontalCenter
            color: themecolor
            font.pixelSize: appHeight/36
            font.family: xciteMobile.name
        }

        Rectangle {
            id: closeFailDelete
            width: appWidth/6
            height: appHeight/27
            radius: height/2
            color: "transparent"
            anchors.top: deleteFailedLabel.bottom
            anchors.topMargin: height*2
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 1
            border.color: themecolor


            Rectangle {
                id: selectFailClose
                anchors.fill: parent
                radius: height/2
                color: maincolor
                opacity: 0.3
                visible: false
            }

            Text {
                id: closeFailButtonText
                text: "OK"
                font.family: xciteMobile.name
                font.pointSize: parent.height/2
                color: themecolor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    selectFailClose.visible = true
                }

                onExited: {
                    selectFailClose.visible = false
                }

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    saveErrorNr = 0
                    editFailed = 0
                    newName.text = ""
                    editWalletName = 0
                }
            }
        }
    }
}
