/**
 * Filename: WalletModal.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */

import QtQuick.Controls 2.3
import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtMultimedia 5.8

import "qrc:/Controls" as Controls
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: walletModal
    width: Screen.width
    state: walletDetailTracker == 0 ? "down" : "up"
    height: Screen.height
    color: bgcolor
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 50

    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(0, parent.height)
        opacity: 0.05
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: maincolor }
        }
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: walletModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: walletModal; anchors.topMargin: Screen.height}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: walletModal; property: "anchors.topMargin"; duration: 400; easing.type: Easing.InOutCubic}
        }
    ]

    onStateChanged: {
        oldLabel = walletList.get(walletIndex).label
        oldInclude = walletList.get(walletIndex).include
        oldRemove = walletList.get(walletIndex).remove
        newInclude = oldInclude
    }

    property string oldLabel: ""
    property bool oldInclude
    property bool oldRemove
    property int editSaved: 0
    property int editFailed: 0
    property bool editingWallet: false
    property bool deletingWallet: false
    property int deleteConfirmed: 0
    property int deleteFailed: 0
    property int deleteErrorNr: 0
    property int deleteSuccess: 0
    property bool walletDeleted: false
    property int deleteWalletTracker: 0
    property int labelExists: 0
    property bool newInclude
    property bool walletEdited
    property int saveErrorNR: 0
    property string failError: ""

    function compareLabel(){
        labelExists = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coinName.text) {
                if (newLabel.text != "" && walletList.get(i).remove === false && walletList.get(i).label === newLabel.text) {
                    labelExists = 1
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
    }


    Text {
        id: walletModalLabel
        text: "EDIT WALLET"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 20
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        elide: Text.ElideRight
    }

    Flickable {
        id: scrollArea
        width: parent.width
        contentHeight: (editSaved == 0 && deleteWalletTracker == 0 && editFailed == 0)? walletScrollArea.height + 125 : scrollArea.height + 125
        anchors.left: parent.left
        anchors.top: walletModalLabel.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Rectangle {
            id: walletScrollArea
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: deleteWallet.bottom
            color: "transparent"
        }

        Item {
            id: coinTitle
            width: coinIcon.width + coinName.width + 7
            height: coinIcon.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0

            Image {
                id: coinIcon
                source: getLogo(coinName.text)
                height: 30
                width: 30
                anchors.left: parent.left
                anchors.top: parent.top
            }

            Label {
                id: coinName
                text: walletList.get(walletIndex).name
                anchors.right: parent.right
                anchors.verticalCenter: coinIcon.verticalCenter
                font.pixelSize: 24
                font.family: xciteMobile.name
                font.letterSpacing: 2
                font.bold: true
                color: darktheme == true? "#F2F2F2" : "#2A2C31"

            }
        }

        Label {
            id: labelText
            text: "LABEL:"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: coinTitle.bottom
            anchors.topMargin: 20
            font.family: xciteMobile.name
            font.pointSize: 18
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
        }

        Controls.TextInput {
            id: newLabel
            text: ""
            height: 34
            placeholder: walletList.get(walletIndex).label
            anchors.left: labelText.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.verticalCenter: labelText.verticalCenter
            color: newLabel.text != "" ? themecolor : "#727272"
            textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
            font.pixelSize: 14
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
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
            anchors.left: newLabel.left
            anchors.leftMargin: 5
            anchors.top: newLabel.bottom
            anchors.topMargin: 1
            font.pixelSize: 11
            font.family: xciteMobile.name
            visible: editSaved == 0
                     && editFailed == 0
                     && labelExists == 1
                     && deleteWalletTracker == 0
        }

        Label {
            id: addressText
            text: "ADDRESS:"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: labelText.bottom
            anchors.topMargin: 25
            font.family: xciteMobile.name
            font.pointSize: 18
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
        }

        Label {
            id: addressHash
            text: walletList.get(walletIndex).address
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.right: parent.right
            anchors.rightMargin: 28
            maximumLineCount: 2
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            anchors.top: addressText.bottom
            anchors.topMargin: 10
            font.pointSize: 14
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
        }

        Label {
            id: balanceText
            text: "BALANCE:"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: addressHash.bottom
            anchors.topMargin: 30
            font.family: xciteMobile.name
            font.pointSize: 18
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
        }

        Label {
            id: balanceTicker
            text: walletList.get(walletIndex).name
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.top: balanceText.bottom
            anchors.topMargin: 10
            font.family: xciteMobile.name
            font.pointSize: 18
            font.bold: true
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
        }

        Label {
            property int decimals: walletList.get(walletIndex).balance <= 1 ? 8 : (walletList.get(walletIndex).balance <= 1000 ? 4 : 2)
            property string amountArray: walletList.get(walletIndex).balance.toLocaleString(Qt.locale("en_US"), "f", decimals)
            id: balanceAmount
            text: amountArray
            anchors.right: balanceTicker.left
            anchors.rightMargin: 7
            anchors.top: balanceText.bottom
            anchors.topMargin: 10
            font.family: xciteMobile.name
            font.pointSize: 18
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
        }

        Label {
            id: includeText
            text: "ADD TO WALLET TOTAL?"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: balanceAmount.bottom
            anchors.topMargin: 35
            font.family: xciteMobile.name
            font.pointSize: 18
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
        }

        Label {
            id: includeLabel
            text: newInclude == true? "YES" : "NO"
            anchors.right: includeSwitch.left
            anchors.rightMargin: 10
            anchors.top: includeText.top
            font.family: xciteMobile.name
            font.pointSize: 18
            font.bold: true
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
        }

        Rectangle {
            id: includeSwitch
            z: 1
            width: 20
            height: 20
            radius: 10
            anchors.verticalCenter: includeText.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 28
            color: "transparent"
            border.color: themecolor
            border.width: 2
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0

            Rectangle {
                id: includeIndicator
                z: 1
                width: 12
                height: 12
                radius: 8
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: newInclude == true ? maincolor : "#757575"

                MouseArea {
                    id: includeButton
                    width: 20
                    height: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    onPressed: {
                        detectInteraction()
                    }

                    onClicked: {
                        if (newInclude === false) {
                            newInclude = true
                        }
                        else {
                            newInclude = false
                        }
                    }
                }
            }
        }

        Rectangle {
            id: saveEditButton
            width: doubbleButtonWidth
            height: 34
            color: (labelExists == 0) ? maincolor : "#727272"
            opacity: 0.25
            anchors.top: includeText.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
                     && editingWallet == false

            MouseArea {
                anchors.fill: saveEditButton

                onPressed: {
                    parent.opacity = 0.5
                    click01.play()
                }

                onReleased: {
                    parent.opacity = 0.25
                }

                onCanceled: {
                    parent.opacity = 0.25
                }

                onClicked: {
                    if (labelExists == 0) {
                        walletList.setProperty(walletIndex, "include", newInclude);
                        if (newLabel.text != "") {
                            walletList.setProperty(walletIndex, "label", newLabel.text);
                            editWalletInAddreslist(coinName.text, walletList.get(walletIndex).address, newLabel.text, oldRemove)
                        }
                        else {
                            editWalletInAddreslist(coinName.text, walletList.get(walletIndex).address, oldLabel, oldRemove)
                        }
                        saveErrorNR = 0
                        walletEdited = false
                        editingWallet = true
                        updateToAccount()
                    }
                }
            }

            Connections {
                target: UserSettings

                onSaveSucceeded: {
                    if (walletDetailTracker == 1 && editingWallet == true) {
                        editSaved = 1
                        editingWallet = false
                        sumBalance()
                    }
                }

                onSaveFailed: {
                    if (walletDetailTracker == 1 && editingWallet == true) {
                        if (userSettings.localKeys === false) {
                            walletList.setProperty(walletIndex, "label", oldLabel);
                            walletList.setProperty(walletIndex, "include", oldInclude);
                            editWalletInAddreslist(coinName.text, walletList.get(walletIndex).address, oldLabel, oldRemove)
                            newInclude = oldInclude
                            editFailed = 1
                            editingWallet = false
                        }
                        else if (userSettings.localKeys === true && walletEdited == true) {
                            editWalletInAddreslist(coinName.text, walletList.get(walletIndex).address, oldLabel, oldRemove)
                            newInclude = oldInclude
                            editFailed = 1
                            saveErrorNr = 1
                            editingWallet = false
                            walletEdited = false
                            sumBalance()
                        }

                    }
                }

                onSaveFileSucceeded: {
                    if (walletDetailTracker == 1 && userSettings.localKeys === true && editingWallet == true) {
                        walletEdited = true
                    }
                }

                onSaveFileFailed: {
                    if (walletDetailTracker == 1 && userSettings.localKeys === true && editingWallet == true) {
                        walletList.setProperty(walletIndex, "label", oldLabel);
                        walletList.setProperty(walletIndex, "include", oldInclude);
                        editWalletInAddreslist(coinName.text, walletList.get(walletIndex).address, oldLabel, oldRemove)
                        editFailed = 1
                        saveErrorNr = 0
                        editingWallet = false
                    }
                }

                onSaveFailedDBError: {
                    if (walletDetailTracker == 1 && editingWallet == true) {
                        failError = "Database ERROR"
                    }
                }

                onSaveFailedAPIError: {
                    if (walletDetailTracker == 1 && editingWallet == true) {
                        failError = "Network ERROR"
                    }
                }

                onSaveFailedInputError: {
                    if (walletDetailTracker == 1 && editingWallet == true) {
                        failError = "Input ERROR"
                    }
                }

                onSaveFailedUnknownError: {
                    if (walletDetailTracker == 1 && editingWallet == true) {
                        failError = "Unknown ERROR"
                    }
                }
            }
        }

        Text {
            text: "SAVE"
            font.family: xciteMobile.name
            font.pointSize: 14
            font.bold: true
            color: (labelExists == 0) ? (darktheme == true? "#F2F2F2" : maincolor) : "#979797"
            anchors.horizontalCenter: saveEditButton.horizontalCenter
            anchors.verticalCenter: saveEditButton.verticalCenter
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
                     && editingWallet == false
        }

        Rectangle {
            width: saveEditButton.width
            height: 34
            color: "transparent"
            border.color: (labelExists == 0) ? maincolor : "#727272"
            border.width: 1
            opacity: 0.25
            anchors.top: saveEditButton.top
            anchors.horizontalCenter: saveEditButton.horizontalCenter
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
                     && editingWallet == false
        }

        AnimatedImage  {
            id: waitingDots
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 90
            height: 60
            anchors.horizontalCenter: saveEditButton.horizontalCenter
            anchors.verticalCenter: saveEditButton.verticalCenter
            playing: editingWallet == true
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
                     && editingWallet == true
        }

        Image {
            id: deleteWallet
            source: darktheme == true? 'qrc:/icons/mobile/trash-icon_01_light.svg' : 'qrc:/icons/mobile/trash-icon_01_dark.svg'
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: saveEditButton.bottom
            anchors.topMargin: 40
            visible: editSaved == 0
                     && editFailed == 0
                     && deleteWalletTracker == 0
                     && walletList.count > 2

            Rectangle {
                id: deleteButton
                height: 20
                width: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
            }

            MouseArea {
                anchors.fill: deleteButton

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    deleteWalletTracker = 1
                }
            }


        }

        // Save failed state
        Controls.ReplyModal {
            id: createWalletFailed
            modalHeight: saveFailed.height + saveFailedLabel.height + closeFail.height + 85
            visible: editFailed == 1

            Image {
                id: saveFailed
                source: saveErrorNR == 0? (darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg') : ('qrc:/icons/mobile/warning-icon_01.svg')
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: createWalletFailed.modalTop
                anchors.topMargin: 20
            }

            Label {
                id: saveFailedLabel
                width: doubbleButtonWidth
                maximumLineCount: saveErrorNR == 0? 1 : 4
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                text: saveErrorNR == 0? "Failed to edit your wallet!" : "Your wallet was edited but we could not edit the wallet settings in your addressbook. You will need to edit this wallet manually."
                anchors.top: saveFailed.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: saveFailed.horizontalCenter
                color: maincolor
                font.pixelSize: 14
                font.family: "Brandon Grotesque"
                font.bold: true
            }

            Label {
                id: saveFailedError
                text: failError
                anchors.top: saveFailedLabel.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: saveFailed.horizontalCenter
                color: maincolor
                font.pixelSize: 14
                font.family: "Brandon Grotesque"
                font.bold: true
            }

            Rectangle {
                id: closeFail
                width: doubbleButtonWidth / 2
                height: 34
                color: maincolor
                opacity: 0.25
                anchors.top: saveFailedError.bottom
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if (saveErrorNR == 1) {
                            saveErrorNR = 0
                            walletEdited = true
                            walletDetailTracker = 0;
                        }
                        editFailed = 0
                        failError = ""
                    }
                }
            }

            Text {
                text: saveErrorNR == 0? "TRY AGAIN" : "OK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: closeFail.horizontalCenter
                anchors.verticalCenter: closeFail.verticalCenter
            }

            Rectangle {
                width: doubbleButtonWidth / 2
                height: 34
                anchors.bottom: closeFail.bottom
                anchors.left: closeFail.left
                color: "transparent"
                opacity: 0.5
                border.color: maincolor
                border.width: 1
            }
        }

        // Save succes state
        Controls.ReplyModal {
            id: editWalletSucces
            modalHeight: saveSuccess.height + saveSuccessLabel.height + closeSave.height + 75
            visible: editSaved == 1

            Image {
                id: saveSuccess
                source: darktheme == true? 'qrc:/icons/mobile/add_address-icon_01_light.svg' : 'qrc:/icons/mobile/add_address-icon_01_dark.svg'
                height: 75
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: editWalletSucces.modalTop
                anchors.topMargin: 20
            }

            Label {
                id: saveSuccessLabel
                text: "Wallet edited!"
                anchors.top: saveSuccess.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: saveSuccess.horizontalCenter
                color: maincolor
                font.pixelSize: 14
                font.family: "Brandon Grotesque"
                font.bold: true
            }

            Rectangle {
                id: closeSave
                width: doubbleButtonWidth / 2
                height: 34
                color: maincolor
                opacity: 0.25
                anchors.top: saveSuccessLabel.bottom
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: closeSave

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        if (userSettings.accountCreationCompleted === false) {
                            userSettings.accountCreationCompleted = true
                        }
                        walletAdded = true
                        addWalletTracker = 0;
                        editSaved = 0;
                        createWalletTracker = 0
                    }
                }
            }

            Text {
                text: "OK"
                font.family: "Brandon Grotesque"
                font.pointSize: 14
                font.bold: true
                color: "#F2F2F2"
                anchors.horizontalCenter: closeSave.horizontalCenter
                anchors.verticalCenter: closeSave.verticalCenter
            }

            Rectangle {
                width: doubbleButtonWidth / 2
                height: 34
                anchors.bottom: closeSave.bottom
                anchors.left: closeSave.left
                color: "transparent"
                opacity: 0.5
                border.color: maincolor
                border.width: 1
            }
        }
    }

    // Delete confirm state
    Controls.ReplyModal {
        id: deleteConfirmation
        modalHeight: deleteText.height + deleteWalletName.height + deleteWalletHash.height + deleteWarning.height + confirmationDeleteButton.height + 99
        visible: deleteWalletTracker == 1
                 && deleteConfirmed == 0
                 && deleteFailed == 0

        Text {
            id: deleteText
            text: "You are about to delete:"
            anchors.top: deleteConfirmation.modalTop
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: xciteMobile.name
            font.pixelSize: 20
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
        }

        Text {
            id: deleteWalletName
            text: oldLabel + " (" + coinName.text + ")"
            width: doubbleButtonWidth - 20
            wrapMode: Text.Wrap
            maximumLineCount: 2
            horizontalAlignment: Text.AlignHCenter
            anchors.top: deleteText.bottom
            anchors.topMargin: 7
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: xciteMobile.name
            font.pixelSize: 18
            font.bold: true
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
        }

        Text {
            id: deleteWalletHash
            text: addressHash.text
            width: doubbleButtonWidth - 20
            wrapMode: Text.WrapAnywhere
            maximumLineCount: 2
            anchors.top: deleteWalletName.bottom
            anchors.topMargin: 7
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: xciteMobile.name
            font.pixelSize: 16
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
        }

        Text {
            id: deleteWarning
            width: doubbleButtonWidth - 20
            text: "If you still have coins in this wallet make sure you make a backup of your private key before deleting this wallet!"
            maximumLineCount: 3
            wrapMode: Text.WordWrap
            anchors.top: deleteWalletHash.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: xciteMobile.name
            font.pixelSize: 16
            font.bold: true
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
        }

        Rectangle {
            id: confirmationDeleteButton
            width: (doubbleButtonWidth - 30) / 2
            height: 34
            anchors.top: deleteWarning.bottom
            anchors.topMargin: 25
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 5
            color: "#4BBE2E"
            opacity: 0.25
            visible: deletingWallet == false

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    parent.opacity = 0.5
                    click01.play()
                    detectInteraction()
                }

                onCanceled: {
                    parent.opacity = 0.25
                }

                onReleased: {
                    parent.opacity = 0.25
                }

                onClicked: {
                    deleteConfirmed = 1
                    labelExists = 0
                    deletingWallet = true
                    walletDeleted = false
                    walletList.setProperty(walletIndex, "remove", true)
                    editWalletInAddreslist(coinName.text, addressHash.text, oldLabel, true)
                    updateToAccount()
                }
            }

            Connections {
                target: UserSettings

                onSaveSucceeded: {
                    if (deleteWalletTracker == 1 && deletingWallet == true) {
                        deleteConfirmed = 1
                        deletingWallet = false
                        sumXBY()
                        sumXFUEL()
                        sumXBYTest()
                        sumXFUELTest()
                        sumBalance()
                    }
                }

                onSaveFailed: {
                    if (deleteWalletTracker == 1 && deletingWallet == true) {
                        if (userSettings.localKeys === false) {
                            walletList.setProperty(walletIndex, "remove", false)
                            editWalletInAddreslist(coinName.text, addressHash.text, oldLabel, false)
                            deleteFailed = 1
                            coinListTracker = 0
                            deletingAddress = false
                        }
                        else if (usersettings.localKeys === true && walletDeleted == true) {
                            editWalletInAddreslist(coinName.text, addressHash.text, oldLabel, false)
                            deleteFailed = 1
                            deleteErrorNr = 1
                            deletingWallet = false
                            walletDeleted = false
                        }
                    }
                }

                onSaveFileSucceeded: {
                    if (deleteWalletTracker == 1 && userSettings.localKeys === true && deletingWallet == true) {
                        walletDeleted = true
                    }
                }

                onSaveFileFailed: {
                    if (deleteWalletTracker == 1 && userSettings.localKeys === true && deletingWallet == true) {
                        walletList.setProperty(walletIndex, "remove", false)
                        editWalletInAddreslist(coinName.text, addressHash.text, oldLabel, false)
                        deleteFailed = 1
                        deleteErrorNr = 0
                        deletingWallet = false
                    }
                }

                onSaveFailedDBError: {
                    if (deleteWalletTracker == 1 && deletingAddress == true) {
                        failError = "Database ERROR"
                    }
                }

                onSaveFailedAPIError: {
                    if (deleteWalletTracker == 1 && deletingAddress == true) {
                        failError = "Network ERROR"
                    }
                }

                onSaveFailedInputError: {
                    if (deleteWalletTracker == 1 && deletingAddress == true) {
                        failError = "Input ERROR"
                    }
                }

                onSaveFailedUnknownError: {
                    if (deleteWalletTracker == 1 && deletingAddress == true) {
                        failError = "Unknown ERROR"
                    }
                }
            }
        }

        Text {
            text: "CONFIRM"
            font.family: xciteMobile.name
            font.pointSize: 14
            color: "#4BBE2E"
            font.bold: true
            anchors.horizontalCenter: confirmationDeleteButton.horizontalCenter
            anchors.verticalCenter: confirmationDeleteButton.verticalCenter
            visible: deletingWallet == false
        }

        Rectangle {
            width: (doubbleButtonWidth - 30) / 2
            height: 34
            anchors.top: deleteWarning.bottom
            anchors.topMargin: 25
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 5
            color: "transparent"
            border.color: "#4BBE2E"
            border.width: 1
            visible: deletingWallet == false
        }

        Rectangle {
            id: cancelDeleteButton
            width: (doubbleButtonWidth - 30) / 2
            height: 34
            anchors.top: deleteWarning.bottom
            anchors.topMargin: 25
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 5
            color: "#E55541"
            opacity: 0.25
            visible: deletingWallet == false

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    parent.opacity = 0.5
                    detectInteraction()
                }

                onCanceled: {
                    parent.opacity = 0.25
                }

                onReleased: {
                    parent.opacity = 0.25
                }

                onClicked: {
                    deleteWalletTracker = 0
                }
            }
        }

        Text {
            text: "CANCEL"
            font.family: xciteMobile.name
            font.pointSize: 14
            font.bold: true
            color: "#E55541"
            anchors.horizontalCenter: cancelDeleteButton.horizontalCenter
            anchors.verticalCenter: cancelDeleteButton.verticalCenter
            visible: deletingWallet == false
        }

        Rectangle {
            width: (doubbleButtonWidth - 30) / 2
            height: 34
            anchors.top: deleteWarning.bottom
            anchors.topMargin: 25
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 5
            color: "transparent"
            border.color: "#E55541"
            border.width: 1
            visible: deletingWallet == false
        }

        AnimatedImage  {
            id: waitingDots2
            source: 'qrc:/gifs/loading-gif_01.gif'
            width: 90
            height: 60
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: confirmationDeleteButton.verticalCenter
            playing: deletingWallet == true
            visible: deletingWallet == true
        }
    }

    // Delete failed state
    Controls.ReplyModal {
        id: deleteAddresFailed
        modalHeight: failedIcon.height + deleteFailedLabel.height + deleteFailedError.height + closeDeleteFail.height + 85
        visible: deleteFailed == 1

        Image {
            id: failedIcon
            source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
            height: 75
            width: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: deleteAddresFailed.modalTop
            anchors.topMargin: 20
        }

        Label {
            id: deleteFailedLabel
            width: doubbleButtonWidth
            maximumLineCount: 3
            wrapMode: Text.WordWrap
            text: deleteErrorNr == 0? "Failed to delete your address!" : "Your Wallet was deleted, but we would not update your addressbook. You will need to removethe address manually!"
            anchors.top: failedIcon.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: failedIcon.horizontalCenter
            color: maincolor
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.bold: true
        }

        Label {
            id: deleteFailedError
            text: failError
            anchors.top: deleteFailedLabel.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: failedIcon.horizontalCenter
            color: maincolor
            font.pixelSize: 14
            font.family: "Brandon Grotesque"
            font.bold: true
        }

        Rectangle {
            id: closeDeleteFail
            width: doubbleButtonWidth / 2
            height: 34
            color: maincolor
            opacity: 0.25
            anchors.top: deleteFailedError.bottom
            anchors.topMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onClicked: {
                    if (deleteErrorNr == 1) {
                        deleteErrorNr = 0
                        walletDeleted = true
                        walletDetailTracker = 0;
                    }
                    deleteFailed = 0
                    deleteWalletTracker = 0
                    failError = ""
                }
            }
        }

        Text {
            text: deleteErrorNr == 0? "TRY AGAIN" : "OK"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: closeDeleteFail.horizontalCenter
            anchors.verticalCenter: closeDeleteFail.verticalCenter
        }

        Rectangle {
            width: doubbleButtonWidth / 2
            height: 34
            anchors.bottom: closeDeleteFail.bottom
            anchors.left: closeDeleteFail.left
            color: "transparent"
            opacity: 0.5
            border.color: maincolor
            border.width: 1
        }
    }

    // Delete success state
    Controls.ReplyModal {
        id: deleted
        modalHeight: deleteSuccess.height + deleteSuccessLabel.height + closeDelete.height + 75
        visible: deleteConfirmed == 1

        Image {
            id: deleteSuccess
            source: darktheme == true? 'qrc:/icons/mobile/delete_address-icon_01_light.svg' : 'qrc:/icons/mobile/delete_address-icon_01_dark.svg'
            height: 75
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: deleted.modalTop
            anchors.topMargin: 20
            visible: deleteConfirmed == 1
        }

        Label {
            id: deleteSuccessLabel
            text: "Wallet removed!"
            anchors.top: deleteSuccess.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: deleteSuccess.horizontalCenter
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.pixelSize: 14
            font.family: xciteMobile.name
            font.bold: true
            visible: deleteConfirmed == 1
        }

        Rectangle {
            id: closeDelete
            width: doubbleButtonWidth / 2
            height: 34
            color: maincolor
            opacity: 0.25
            anchors.top: deleteSuccessLabel.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: deleteConfirmed == 1

            MouseArea {
                anchors.fill: closeDelete

                Timer {
                    id: timerDelete
                    interval: 300
                    repeat: false
                    running: false

                    onTriggered: {
                        newLabel.text = ""
                        deleteWalletTracker = 0
                        deleteConfirmed = 0
                    }
                }

                onPressed: {
                    closeDelete.opacity = 0.5
                    click01.play()
                    detectInteraction()
                }

                onCanceled: {
                    closeDelete.opacity = 0.25
                }

                onReleased: {
                    closeDelete.opacity = 0.25
                }

                onClicked: {
                    walletDetailTracker = 0;
                    timerDelete.start()
                }
            }
        }

        Text {
            text: "OK"
            font.family: xciteMobile.name
            font.pointSize: 14
            font.bold: true
            color: darktheme == true? "#F2F2F2" : maincolor
            anchors.horizontalCenter: closeDelete.horizontalCenter
            anchors.verticalCenter: closeDelete.verticalCenter
            visible: deleteConfirmed == 1
        }

        Rectangle {
            width: doubbleButtonWidth / 2
            height: 34
            anchors.bottom: closeDelete.bottom
            anchors.horizontalCenter: closeDelete.horizontalCenter
            color: "transparent"
            border.color: maincolor
            border.width: 1
            opacity: 0.5
            visible: deleteConfirmed == 1
        }
    }

    Item {
        z: 3
        width: Screen.width
        height: myOS === "android"? 125 : 145
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(x, y)
            end: Qt.point(x, y + height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: darktheme == true? "#14161B" : "#FDFDFD" }
                GradientStop { position: 1.0; color: darktheme == true? "#14161B" : "#FDFDFD" }
            }
        }
    }

    Label {
        id: closeWalletModal
        z: 10
        text: "BACK"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 14
        font.family: "Brandon Grotesque"
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        visible: editSaved == 0 && editFailed == 0 &&  deleteWalletTracker == 0

        Rectangle{
            id: closeButton
            height: 34
            width: doubbleButtonWidth / 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
        }

        MouseArea {
            anchors.fill: closeButton

            Timer {
                id: timer
                interval: 300
                repeat: false
                running: false

                onTriggered: {
                    walletIndex = 0
                    sumBalance()
                    sumXBY()
                    sumXFUEL()
                    sumXTest()
                }
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onReleased: {
                walletDetailTracker = 0;
                timer.start()
            }
        }
    }
}
