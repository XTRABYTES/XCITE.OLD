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

import QtQuick 2.7
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtCharts 2.0
import QZXing 2.3

import "qrc:/Controls" as Controls
import "qrc:/Controls/+desktop" as Desktop
import "qrc:/Controls/+mobile" as Mobile

Rectangle {
    id: walletModal
    width: appWidth/6 * 5
    height: appHeight
    anchors.right: parent.right
    anchors.top: parent.top
    color: bgcolor
    state: walletDetailTracker == 0 ? "down" : "up"
    clip: true

    onStateChanged: {
        transferSwitchState = (coinIndex < 3 || walletList.get(walletIndex).viewOnly)? 0 : 1
        includeSwitch.state = walletList.get(walletIndex).include? "on" : "off"
        historySwitch.state = "off"
        transferSwitch.state = transferSwitchState == 0 ? "off" : "on"
        transactionSend = 0
        invalidAddress = 0
        failedSend = 0
        if (state == "up") {
            historyTracker = 1
            transferTracker = 1
            oldLabel = walletList.get(walletIndex).label
            oldInclude = walletList.get(walletIndex).include
            oldRemove = walletList.get(walletIndex).remove
            newInclude = oldInclude
        }
        else {
            historyTracker = 0
            transferTracker = 0
            keyInput.text = ""
            sendAmount.text = ""
            referenceInput.text = ""
        }
    }

    states: [
        State {
            name: "up"
            PropertyChanges { target: walletModal; anchors.topMargin: 0}
        },
        State {
            name: "down"
            PropertyChanges { target: walletModal; anchors.topMargin: appHeight}
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: walletModal; properties: "anchors.topMargin"; duration: 300; easing.type: Easing.InOutCubic}
        }
    ]

    property int decimals: totalCoinsSum == 0? 2 : (totalCoinsSum <= 1000? 8 : (totalCoinsSum <= 1000000? 4 : 2))
    property real totalCoinsSum: walletList.get(walletIndex).balance
    property var totalArray: (totalCoinsSum.toLocaleString(Qt.locale("en_US"), "f", decimals)).split('.')
    property bool myTheme: darktheme
    property int transferSwitchState: (coinIndex < 3 || walletList.get(walletIndex).viewOnly)? 0 : 1
    property int myIndex: walletIndex

    property int transactionSend: 0
    property int failedSend: 0
    property int requestSend: 0
    property int invalidAddress: 0
    property var inputAmount: Number.fromLocaleString(Qt.locale("en_US"),replaceComma)
    property int txFee: 1
    property string rawTX: ""
    property string receivedReceiver: ""
    property string receivedSender: ""
    property string receivedAmount: ""
    property string receivedLabel: ""
    property string receivedTxID: ""
    property string usedCoins: ""
    property string txId: ""
    property real totalAmount: 0
    property string network: coinList.get(coinIndex).fullname
    property real amountSend: 0
    property string transferReply: ""
    property var replyArray
    property string searchTxText: ""
    property string transactionDate: ""
    property int timestamp: 0
    property string addressName: compareAddress()
    property real currentBalance: getCurrentBalance()
    property string searchCriteria: ""
    property int copyImage2clipboard: 0
    property int badNetwork: 0
    property bool selectNetwork: false
    property string txFailError:""
    property var commaArray
    property int detectComma
    property string replaceComma
    property var transferArray
    property int precision: 0
    property bool qrFound: false
    property int newHistory: 0
    property int deleteWallet: 0
    property int deleteWarning: 0
    property string oldLabel: ""
    property bool oldInclude: false
    property bool oldRemove: false
    property bool newInclude: false
    property bool walletDeleted: false
    property int deleteFailed: 1
    property int deleteErrorNr: 1

    onMyThemeChanged: {
        if (myTheme) {
            trashcan.source = "qrc:/icons/trashcan_icon_light01.png"
        }
        else {
            trashcan.source = "qrc:/icons/trashcan_icon_dark01.png"
        }
    }

    onMyIndexChanged: {
        historySwitch.state = "off"
        transferSwitchState = walletList.get(walletIndex).viewOnly? 0 : transferSwitchState
        transferSwitch.state = transferSwitchState == 0 ? "off" : "on"
        includeSwitch.state = walletList.get(walletIndex).include? "on" : "off"

        if (coinIndex < 3){
            historyDetailsCollected = false
            transactionPages = 0
            currentPage = 1
            updateTransactions(walletList.get(walletIndex).name, walletList.get(walletIndex).address, 1)
        }
    }

    function compareAddress(){
        var fromto = ""
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).address === keyInput.text) {
                if (addressList.get(i).coin === walletList.get(walletIndex).name) {
                    fromto = (contactList.get(addressList.get(i).contact).firstName) + " " + (contactList.get(addressList.get(i).contact).lastName) + " (" + (addressList.get(i).label) + ")"
                }
            }
        }
        return fromto
    }

    function checkAddress() {
        var coinID = walletList.get(walletIndex).name
        invalidAddress = 0
        if (coinID === "XBY") {
            if (keyInput.length === 34
                    && keyInput.text !== ""
                    && (keyInput.text.substring(0,1) == "B")
                    && keyInput.acceptableInput == true) {
                invalidAddress = 0
            }
            else {
                invalidAddress = 1
            }
        }
        else if (coinID === "XFUEL") {
            if (keyInput.length === 34
                    && keyInput.text !== ""
                    && keyInput.text.substring(0,1) == "F"
                    && keyInput.acceptableInput == true) {
                invalidAddress = 0
            }
            else {
                invalidAddress = 1
            }
        }
        else if (coinID === "XTEST") {
            if (keyInput.length === 34
                    && keyInput.text !== ""
                    && keyInput.text.substring(0,1) == "G"
                    && keyInput.acceptableInput == true) {
                invalidAddress = 0
            }
            else {
                invalidAddress = 1
            }
        }
        else if (coinID === "BTC") {
            if (((keyInput.length > 25 && keyInput.length < 36 && (keyInput.text.substring(0,1) == "1" || keyInput.text.substring(0,1) == "3"))
                 || (keyInput.length > 36 && keyInput.length < 63 && keyInput.text.substring(0,3) == "bc1"))
                    && keyInput.acceptableInput == true) {
                invalidAddress = 0
            }
            else {
                invalidAddress = 1
            }
        }
        else if (coinID === "ETH") {
            if (keyInput.length == 42
                    && keyInput.text.substring(0,2) == "0x"
                    && keyInput.acceptableInput == true) {
                invalidAddress = 0
            }
            else {
                invalidAddress = 1
            }
        }
    }

    function getCurrentBalance(){
        var currentBalance = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).address === getAddress (walletList.get(walletIndex).name, walletLabel.text)) {
                currentBalance = walletList.get(i).balance
            }
        }
        return currentBalance
    }

    MouseArea {
        anchors.fill: parent
    }

    Label {
        id: walletLabel
        text: "WALLET - " + walletList.get(walletIndex).name + " - " + walletList.get(walletIndex).label
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.left: parent.left
        anchors.leftMargin: appWidth/12
        anchors.top: parent.top
        anchors.topMargin: appWidth/24
        horizontalAlignment: Text.AlignRight
        font.pixelSize: appHeight/18
        font.family: xciteMobile.name
        font.capitalization: Font.AllUppercase
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        font.letterSpacing: 2
        elide: Text.ElideRight
    }

    Label {
        id: includeLabel
        text: "Include address in wallet total?"
        color: themecolor
        font.pixelSize: appHeight/45
        font.family: xciteMobile.name
        anchors.bottom: includeSwitch.top
        anchors.bottomMargin: font.pixelSize
        anchors.horizontalCenter: includeSwitch.horizontalCenter
        visible: includeSwitch.visible
    }

    Controls.Switch {
        id: includeSwitch
        anchors.horizontalCenter: walletArea.horizontalCenter
        anchors.horizontalCenterOffset: -walletArea.width/4
        anchors.verticalCenter: trashcan.verticalCenter
        state: walletList.get(walletIndex).include ? "on" : "off"
        visible: transactionSend == 0 && deleteFailed == 1 && !coinList.get(coinIndex).testnet

        onSwitchOnChanged: {
            if (switchOn == true) {
                walletList.setProperty(walletIndex, "include", true)
                sumBalance()
                sumXBY()
                sumXFUEL()
                sumXTest()
                sumBTC()
                sumETH()
            }

            else {
                walletList.setProperty(walletIndex, "include", false)
                sumBalance()
                sumXBY()
                sumXFUEL()
                sumXTest()
                sumBTC()
                sumETH()
            }
        }
    }

    Text {
        id: noIncludeText
        text: "NO"
        anchors.right: includeSwitch.left
        anchors.rightMargin: font.pixelSize/2
        anchors.verticalCenter: includeSwitch.verticalCenter
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: includeSwitch.switchOn ? "#757575" : maincolor
        visible: includeSwitch.visible
    }

    Text {
        id: yesIncludeText
        text: "YES"
        anchors.left: includeSwitch.right
        anchors.leftMargin: font.pixelSize/2
        anchors.verticalCenter: includeSwitch.verticalCenter
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        color: includeSwitch.switchOn ? maincolor : "#757575"
        visible: includeSwitch.visible
    }

    Image {
        id: trashcan
        source: darktheme == true? "qrc:/icons/trashcan_icon_light01.png" : "qrc:/icons/trashcan_icon_dark01.png"
        height: appHeight/18
        fillMode: Image.PreserveAspectFit
        anchors.bottom: infoBar.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -appWidth/48
        visible: deleteFailed == 1

        Rectangle {
            anchors.fill: parent
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                enabled: transactionSend == 0

                onPressed: {
                    click01.play()
                    detectInteraction()
                }

                onEntered: {
                    trashcan.source = "qrc:/icons/trashcan_icon_green01.png"
                }

                onExited: {
                    if (darktheme == true) {
                        trashcan.source = "qrc:/icons/trashcan_icon_light01.png"
                    }
                    else {
                        trashcan.source = "qrc:/icons/trashcan_icon_dark01.png"
                    }
                }

                onClicked: {
                    deleteWallet = 1
                }
            }
        }
    }

    DropShadow {
        z: 12
        anchors.fill: confirmPopup
        source: confirmPopup
        horizontalOffset: 0
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.4
        transparentBorder: true
        visible: confirmPopup.visible
    }

    Item {
        id: confirmPopup
        z: 12
        width: popupConfirm.width
        height: popupConfirm.height
        anchors.horizontalCenter: trashcan.horizontalCenter
        anchors.verticalCenter: trashcan.verticalCenter
        visible: deleteWallet == 1

        Rectangle {
            id: popupConfirm
            height: popupConfirmText.height + popupConfirmBtn.height + appHeight/72
            width: confirmText.implicitWidth + confirmText.font.pixelSize*4
            color: "#42454F"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Item {
            id: popupConfirmText
            height: appHeight/27
            width: parent.width
            anchors.bottom: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: confirmText
                text: "Are you sure you wan to delete this address?"
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
                color: "#F2F2F2"
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Item {
            id: popupConfirmBtn
            height: appHeight/27
            width: parent.width
            anchors.bottom: popupConfirm.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                id: yesBtn
                height: parent.height
                width: parent.width/2
                anchors.top: parent.top
                anchors.left: parent.left

                Label {
                    text: "Yes"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/2
                    color: "#F2F2F2"
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: deleteWallet == 1

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        deleteWarning = 1
                        deleteWallet = 0
                    }
                }
            }

            Item {
                id: noBtn
                height: parent.height
                width: parent.width/2
                anchors.top: parent.top
                anchors.right: parent.right

                Label {
                    text: "No"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/2
                    color: "#F2F2F2"
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: deleteWallet == 1

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        deleteWallet = 0
                    }
                }
            }
        }

        Rectangle {
            height: 1
            width: parent.width - 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            opacity: 0.1
        }

        Rectangle {
            height: parent.height/2 - 2
            width: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            opacity: 0.1
        }
    }

    DropShadow {
        z: 12
        anchors.fill: warningPopup
        source: warningPopup
        horizontalOffset: 0
        verticalOffset: 4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.4
        transparentBorder: true
        visible: warningPopup.visible
    }

    Item {
        id: warningPopup
        z: 12
        width: popupWarning.width
        height: popupWarning.height
        anchors.horizontalCenter: trashcan.horizontalCenter
        anchors.verticalCenter: trashcan.verticalCenter
        visible: deleteWarning == 1

        Rectangle {
            id: popupWarning
            height: popupWarningText.height + popupWarningBtn.height + appHeight/72
            width: warningText.implicitWidth + warningText.font.pixelSize*4
            color: "#42454F"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Item {
            id: popupWarningText
            height: appHeight/27
            width: parent.width
            anchors.bottom: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: warningText
                text: "If you still have coins in this address, don't forget to back up your private key!"
                font.family: xciteMobile.name
                font.pixelSize: parent.height/2
                color: "#F2F2F2"
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Item {
            id: popupWarningBtn
            height: appHeight/27
            width: parent.width
            anchors.bottom: popupWarning.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                id: confirmBtn
                height: parent.height
                width: parent.width/2
                anchors.top: parent.top
                anchors.left: parent.left

                Label {
                    text: "Delete address"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/2
                    color: "#F2F2F2"
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: deleteWarning == 1

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        deleteWarning = 0
                        walletList.setProperty(walletIndex, "remove", true)
                        editWalletInAddreslist(coinList.get(coinIndex).name, walletList.get(walletIndex).address, oldLabel, true)
                        if (userSettings.localKeys) {
                            deletingWallet = true
                            walletDeleted = false
                            updateToAccount()
                        }
                        else {
                            walletDetailTracker = 0
                            walletIndex = -1
                            sumBalance()
                            sumXBY()
                            sumXFUEL()
                            sumXTest()
                            sumBTC()
                            sumETH()
                        }
                    }

                    Connections {
                        target: UserSettings

                        onSaveSucceeded: {
                            if (deletingWallet == true) {
                                walletDetailTracker = 0
                                walletIndex = -1
                                deletingWallet = false
                                sumBalance()
                                sumXBY()
                                sumXFUEL()
                                sumXTest()
                                sumBTC()
                                sumETH()
                            }
                        }

                        onSaveFailed: {
                            if (deletingWallet == true && walletDeleted == true) {
                                walletList.setProperty(walletIndex, "remove", false)
                                editWalletInAddreslist(coinList.get(coinIndex).name, walletList.get(walletIndex).address, oldLabel, false)
                                deleteFailed = 1
                                deleteErrorNr = 1
                                walletDeleted = false
                            }
                        }

                        onNoInternet: {
                            if (deletingWallet == true && walletDeleted == true) {
                                networkError = 1
                                walletList.setProperty(walletIndex, "remove", false)
                                editWalletInAddreslist(coinList.get(coinIndex).name, walletList.get(walletIndex).address, oldLabel, false)
                                deleteFailed = 1
                                deleteErrorNr = 1
                                walletDeleted = false
                            }
                        }

                        onSaveFileSucceeded: {
                            if (deletingWallet == true) {
                                walletDeleted = true
                            }
                        }

                        onSaveFileFailed: {
                            if (deletingWallet == true) {
                                walletList.setProperty(walletIndex, "remove", false)
                                editWalletInAddreslist(coinList.get(coinIndex).name, walletList.get(walletIndex).address, oldLabel, false)
                                deleteFailed = 1
                                deleteErrorNr = 0
                            }
                        }
                    }
                }
            }

            Item {
                id: cancelBtn
                height: parent.height
                width: parent.width/2
                anchors.top: parent.top
                anchors.right: parent.right

                Label {
                    text: "Cancel"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: xciteMobile.name
                    font.pixelSize: parent.height/2
                    color: "#F2F2F2"
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: deleteWarning == 1

                    onPressed: {
                        click01.play()
                        detectInteraction()
                    }

                    onClicked: {
                        deleteWarning = 0
                    }
                }
            }
        }

        Rectangle {
            height: 1
            width: parent.width - 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            opacity: 0.1
        }

        Rectangle {
            height: parent.height/2 - 2
            width: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            opacity: 0.1
        }
    }

    Item {
        id: totalWalletValue
        width: valueTicker.implicitWidth + value1.implicitWidth + value2.implicitWidth
        height: value1.implicitHeight
        anchors.top: walletLabel.bottom
        anchors.topMargin: appWidth/72
        anchors.right: walletLabel.right

        Label {
            id: valueTicker
            anchors.left: value2.right
            anchors.bottom: value1.bottom
            leftPadding: appHeight/54
            text: walletList.get(walletIndex).name
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            color: themecolor
            visible: userSettings.showBalance === true
        }

        Label {
            id: value1
            anchors.left: parent.left
            anchors.verticalCenter: totalWalletValue.verticalCenter
            text: totalArray[0]
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            color: themecolor
        }

        Label {
            id: value2
            anchors.left: value1.right
            anchors.bottom: value1.bottom
            text: "." + totalArray[1]
            font.pixelSize: appHeight/27
            font.family: xciteMobile.name
            color: themecolor
        }
    }

    Rectangle {
        id: changeButton
        width: appWidth/6
        height: appHeight/27
        radius: height/2
        anchors.bottom: infoBar.top
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        border.color: themecolor
        border.width: 1
        color: "transparent"
        visible: walletListTracker == 0 && scanQRTracker == 0 && addressbookTracker == 0
        opacity: myWalletListSmall.availableWallets > 0? 1 : 0.3

        Rectangle {
            id: selectChange
            anchors.fill: parent
            radius: height/2
            color: maincolor
            opacity: 0.3
            visible: false
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            enabled: myWalletListSmall.availableWallets > 0

            onEntered: {
                selectChange.visible = true
            }

            onExited: {
                selectChange.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                walletListTracker = 1
            }
        }

        Text {
            id: changeButtonText
            text: "CHANGE WALLET"
            font.family: xciteMobile.name
            font.pixelSize: parent.height/2
            color: themecolor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: infoBar
        width: parent.width
        height: appHeight/18
        anchors.top: totalWalletValue.bottom
        anchors.topMargin: appWidth/24
        anchors.horizontalCenter: parent.horizontalCenter
        color: bgcolor

        Label {
            id: viewOnlyLabel
            text: "VIEW ONLY"
            font.family: xciteMobile.name
            font.pixelSize: parent.height/2
            color: "#E55541"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -appWidth/48
            anchors.verticalCenter: parent.verticalCenter
            visible: walletList.get(walletIndex).viewOnly
        }
    }

    Rectangle {
        id: walletArea
        width: parent.width
        anchors.top: infoBar.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: appWidth/24
        color: "transparent"
        clip: true

        Item {
            id: transactionArea
            width: (parent.width - appWidth*3/24)/2
            anchors.left: parent.left
            anchors.leftMargin: appWidth/24
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: appWidth/24
            clip: true

            Label {
                id: transactionLabel
                text: "TRANSFER"
                color: themecolor
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Controls.Switch {
                id: transferSwitch
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: transactionLabel.bottom
                anchors.topMargin: appWidth/48
                state: transferSwitchState == 0 ? "off" : "on"
                switchActive: coinIndex < 3 && !walletList.get(walletIndex).viewOnly && addressbookTracker == 0
                visible: transactionSend == 0
            }

            Text {
                id: activeText
                text: "RECEIVE"
                anchors.right: transferSwitch.left
                anchors.rightMargin: font.pixelSize/2
                anchors.verticalCenter: transferSwitch.verticalCenter
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                color: transferSwitch.switchOn ? "#757575" : maincolor
                visible: transactionSend == 0
            }

            Text {
                id: viewText
                text: "SEND"
                anchors.left: transferSwitch.right
                anchors.leftMargin: font.pixelSize/2
                anchors.verticalCenter: transferSwitch.verticalCenter
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                color: transferSwitch.switchOn ? maincolor : "#757575"
                visible: transactionSend == 0

                Label {
                    id: advancedSendLabel
                    text: "advanced"
                    anchors.left: parent.right
                    anchors.leftMargin: parent.font.pixelSize*2
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: xciteMobile.name
                    font.pixelSize: parent.font.pixelSize*2/3
                    color: transferSwitch.switchOn ? themecolor : "#757575"

                    Rectangle {
                        id: advancedSelector
                        width: parent.width
                        height: 1
                        color: maincolor
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        anchors.topMargin: parent.font.pixelSize/2
                        visible: false
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            enabled: transferSwitch.switchOn

                            onEntered: {
                                advancedSelector.visible = true
                            }

                            onExited: {
                                advancedSelector.visible = false
                            }

                            onPressed: {
                                click01.play()
                                detectInteraction()
                            }

                            onClicked: {
                                advancedTXList.clear()
                                advancedTransferTracker = 1
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: qrArea
                height: parent.height*2/3
                width: height
                anchors.top: transferSwitch.bottom
                anchors.topMargin: appWidth/96
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                visible: !transferSwitch.switchOn

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.width: 1
                    border.color: themecolor
                    opacity: 0.1
                }

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: appHeight/72
                    text: "Your wallet ADDRESS"
                    font.pixelSize: appHeight/36
                    font.family: xciteMobile.name
                    color: themecolor
                }

                Rectangle {
                    id: qrPlaceholder
                    width: parent.width/2
                    height: width
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: appWidth/24
                    color: "white"
                    border.color: themecolor
                    border.width: 1

                    Image {
                        width: parent.width*0.95
                        height: parent.height*0.95
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: "image://QZXing/encode/" + walletList.get(walletIndex).address
                        cache: false
                    }
                }

                Item {
                    width: parent.width*0.8
                    height: addressHashLabel.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: appHeight/36

                    Label {
                        id: addressHashLabel
                        width: parent.width - clipBoard1.width
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        text: walletList.get(walletIndex).address
                        maximumLineCount: 2
                        wrapMode: Text.WrapAnywhere
                        font.pixelSize: appHeight/54
                        font.family: xciteMobile.name
                        color: themecolor
                        rightPadding: appHeight/36
                    }

                    Image {
                        id: clipBoard1
                        source: darktheme == true? "qrc:/icons/clipboard_icon_light01.png" : "qrc:/icons/clipboard_icon_dark01.png"
                        height: appHeight/27
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: addressHashLabel.verticalCenter
                        anchors.left: addressHashLabel.right

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"

                            MouseArea {
                                anchors.fill: parent

                                onClicked: {
                                    if (copy2clipboard == 0) {
                                        copyText2Clipboard(addressHashLabel.text)
                                        copy2clipboard = 1
                                        addressCopied = 1
                                        timer.start()
                                    }
                                }
                            }
                        }
                    }

                    DropShadow {
                        z: 12
                        anchors.fill: textPopup
                        source: textPopup
                        horizontalOffset: 0
                        verticalOffset: 4
                        radius: 12
                        samples: 25
                        spread: 0
                        color: "black"
                        opacity: 0.4
                        transparentBorder: true
                        visible: textPopup.visible
                    }

                    Item {
                        id: textPopup
                        width: popupClipboard.width
                        height: popupClipboardText.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        visible: copy2clipboard == 1 && addressCopied == 1

                        Rectangle {
                            id: popupClipboard
                            height: appHeight/27
                            width: popupClipboardText.width + appHeight/18
                            color: "#42454F"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Label {
                            id: popupClipboardText
                            text: "Address copied!"
                            font.family: xciteMobile.name
                            font.pixelSize: appHeight/54
                            color: "#F2F2F2"
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }

            Item {
                id: sendArea
                width: appWidth/6*1.5
                height: sendAmount.height + keyInput.height + keyInput.anchors.topMargin + scanQrButton.height + scanQrButton.anchors.topMargin + referenceInput.height + referenceInput.anchors.topMargin + sendButton.height*2 + sendButton.anchors.topMargin
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: transferSwitch.bottom
                anchors.topMargin: appWidth/96
                visible: transferSwitch.switchOn
                         && transactionSend == 0
                         && walletList.get(walletIndex).viewOnly === false

                Mobile.AmountInput {
                    id: sendAmount
                    height: appHeight/18
                    width: parent.width
                    anchors.top: parent.top
                    placeholder: "AMOUNT"
                    color: themecolor
                    textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                    font.pixelSize: height/2
                    validator: DoubleValidator {bottom: 0; top: ((walletList.get(walletIndex).balance))}
                    mobile: 1
                    calculator: walletList.get(walletIndex).name === "XTEST"? 0 : 1
                    onTextChanged: {
                        commaArray = sendAmount.text.split(',')
                        if (commaArray[1] !== undefined) {
                            detectComma = 1
                        }
                        else {
                            detectComma = 0
                        }
                        if (detectComma == 1){
                            replaceComma = sendAmount.text.replace(",",".")
                            transferArray = replaceComma.split('.')
                            if (transferArray[1] !== undefined) {
                                precision = transferArray[1].length
                            }
                            else {
                                precision = 0
                            }
                        }
                        else {
                            replaceComma = sendAmount.text
                            transferArray = sendAmount.text.split('.')
                            if (transferArray[1] !== undefined) {
                                precision = transferArray[1].length
                            }
                            else {
                                precision = 0
                            }
                        }
                        detectInteraction()
                    }
                }

                Text {
                    id: calculated
                    text: calculatedAmount
                    anchors.left: sendAmount.left
                    anchors.top: sendAmount.bottom
                    anchors.topMargin: 3
                    visible: false
                    onTextChanged: {
                        sendAmount.text = calculated.text
                    }
                }

                Label {
                    text: "Input amount too low"
                    color: "#FD2E2E"
                    anchors.left: sendAmount.left
                    anchors.leftMargin: 5
                    anchors.top: sendAmount.bottom
                    anchors.topMargin: 1
                    font.pixelSize: appHeight/45
                    font.family: xciteMobile.name
                    visible: precision <= 8
                             && (walletList.get(walletIndex).name === "XBY"? inputAmount < 1 : (walletList.get(walletIndex).name === "XFUEL"? inputAmount < 1 : (walletList.get(walletIndex).name === "XTEST"? inputAmount < 1 : inputAmount < 0)))
                }

                Label {
                    text: "Insufficient funds"
                    color: "#FD2E2E"
                    anchors.left: sendAmount.left
                    anchors.leftMargin: 5
                    anchors.top: sendAmount.bottom
                    anchors.topMargin: 1
                    font.pixelSize: appHeight/45
                    font.family: xciteMobile.name
                    visible: (walletList.get(walletIndex).name === "XBY" || walletList.get(walletIndex).name === "XFUEL" || walletList.get(walletIndex).name === "XTEST")? inputAmount >= walletList.get(walletIndex).balance - 1 : inputAmount > walletList.get(walletIndex).balance - 1
                                                                                                                                                                           && precision <= 8
                }

                Label {
                    text: "Too many decimals"
                    color: "#FD2E2E"
                    anchors.left: sendAmount.left
                    anchors.leftMargin: 5
                    anchors.top: sendAmount.bottom
                    anchors.topMargin: 1
                    font.pixelSize: appHeight/45
                    font.family: xciteMobile.name
                    visible: precision > 8
                }

                Controls.TextInput {
                    id: keyInput
                    text: ""
                    height: appHeight/18
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: sendAmount.bottom
                    anchors.topMargin: height/2
                    placeholder: "WALLET ADDRESS"
                    color: themecolor
                    textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                    font.pixelSize: height/2
                    mobile: 1
                    validator: RegExpValidator { regExp: /[0-9A-Za-z]+/ }
                    onTextChanged: {
                        detectInteraction()
                        checkAddress()
                    }
                }

                Label {
                    id: addressWarning
                    text: "Invalid address format!"
                    color: "#FD2E2E"
                    anchors.left: keyInput.left
                    anchors.leftMargin: 5
                    anchors.top: keyInput.bottom
                    anchors.topMargin: 1
                    font.pixelSize: appHeight/45
                    font.family: xciteMobile.name
                    visible: keyInput.text != ""
                             && invalidAddress == 1
                }

                Rectangle {
                    id: scanQrButton
                    width: (parent.width*0.9) / 2
                    height: appHeight/27
                    radius: height/2
                    anchors.top: keyInput.bottom
                    anchors.topMargin: height
                    anchors.left: keyInput.left
                    border.color: themecolor
                    border.width: 1
                    color: "transparent"

                    Rectangle {
                        id: selectQr
                        anchors.fill: parent
                        radius: height/2
                        color: maincolor
                        opacity: 0.3
                        visible: false
                    }

                    MouseArea {
                        anchors.fill: scanQrButton
                        hoverEnabled: true

                        onEntered: {
                            selectQr.visible = true
                        }

                        onExited: {
                            selectQr.visible = false
                        }

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            scanQRTracker = 1
                            scanning = "scanning..."
                        }
                    }

                    Text {
                        id: qrButtonText
                        text: "SCAN QR"
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/2
                        color: themecolor
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle {
                    id: addressBookButton
                    width: (parent.width*0.9) / 2
                    height: appHeight/27
                    radius: height/2
                    anchors.top: keyInput.bottom
                    anchors.topMargin: height
                    anchors.right: keyInput.right
                    border.color: themecolor
                    border.width: 1
                    color: "transparent"

                    Rectangle {
                        id: selectAddress
                        anchors.fill: parent
                        radius: height/2
                        color: maincolor
                        opacity: 0.3
                        visible: false
                    }

                    Text {
                        id: addressButtonText
                        text: "ADDRESS BOOK"
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/2
                        color: themecolor
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: addressBookButton
                        hoverEnabled: true

                        onEntered: {
                            selectAddress.visible = true
                        }

                        onExited: {
                            selectAddress.visible = false
                        }

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            addressbookTracker = 1
                            selectedCoin = walletList.get(walletIndex).name
                        }
                    }
                }

                Controls.TextInput {
                    id: referenceInput
                    height: appHeight/18
                    width: parent.width
                    placeholder: "REFERENCE"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: scanQrButton.bottom
                    anchors.topMargin: appHeight/27
                    color: themecolor
                    textBackground: darktheme == true? "#0B0B09" : "#FFFFFF"
                    font.pixelSize: height/2
                    mobile: 1
                    onTextChanged: detectInteraction()
                }

                Rectangle {
                    id: sendButton
                    width: appWidth/6
                    height: appHeight/27
                    radius: height/2
                    color: "transparent"
                    border.width: 1
                    border.color: (invalidAddress == 0
                                   && keyInput.text !== ""
                                   && sendAmount.text !== ""
                                   && (walletList.get(walletIndex).name === "XBY" || walletList.get(walletIndex).name === "XFUEL" || walletList.get(walletIndex).name.text === "XTEST")? inputAmount >= 1 : inputAmount > 0
                                                                                                                                                                                         && precision <= 8
                                                                                                                                                                                         && inputAmount <= (walletList.get(walletIndex).balance)) ? themecolor : "#727272"
                    anchors.top: referenceInput.bottom
                    anchors.topMargin: height
                    anchors.horizontalCenter: referenceInput.horizontalCenter

                    Rectangle {
                        id: selectSend
                        anchors.fill: parent
                        radius: height/2
                        color: maincolor
                        opacity: 0.3
                        visible: false
                    }

                    Text {
                        id: sendButtonText
                        text: "SEND"
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/2
                        color: parent.border.color
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: sendButton
                        hoverEnabled: true
                        enabled: invalidAddress == 0
                                 && keyInput.text !== ""
                                 && sendAmount.text !== ""
                                 && (walletList.get(walletIndex).name === "XBY" || walletList.get(walletIndex).name === "XFUEL" || walletList.get(walletIndex).name.text === "XTEST")? inputAmount >= 1 : inputAmount > 0
                                                                                                                                                                                       && precision <= 8
                                                                                                                                                                                       && inputAmount <= ((walletList.get(walletIndex).balance) - 1)
                                                                                                                                                                                       && (network == "xtrabytes" || network == "xfuel" || network == "testnet")

                        onEntered: {
                            selectSend.visible = true
                        }

                        onExited: {
                            selectSend.visible = false
                        }

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            txFailError = ""
                            selectNetwork = true
                            createTx = true
                            setNetwork(network)
                        }

                        Connections {
                            target: xUtility

                            onNewNetwork: {
                                if (selectNetwork == true && advancedTransferTracker == 0 && pageTracker == 0) {
                                    coinListTracker = 0
                                    walletListTracker = 0
                                    selectNetwork = false
                                    var t = new Date().toLocaleString(Qt.locale(),"hh:mm:ss .zzz")
                                    var msg = "UI - send coins - target:" + keyInput.text + ", amount:" +  sendAmount.text + ", private key: ********************"
                                    xPingTread.append({"message": msg, "inout": "out", "author": myUsername, "time": t})
                                    sendCoins(keyInput.text + "-" +  sendAmount.text + " " +  sendAmount.text + " " +  walletList.get(walletIndex).privatekey)
                                }
                            }

                            onBadNetwork: {
                                if (selectNetwork == true && advancedTransferTracker == 0 && pageTracker == 0) {
                                    badNetwork = 1
                                    selectNetwork = false
                                    createTx = false
                                    txFailError = "Wrong network"
                                    transactionSend = 1
                                    failedSend = 1
                                }
                            }
                        }


                        Connections {
                            target: StaticNet

                            onSendFee: {
                                if (createTx == true && advancedTransferTracker == 0 && pageTracker == 0) {
                                    notification.play()
                                    console.log("sender: " + sender_ + " receiver: " + receiver_ + " amount: " + sendAmount_)
                                    var r
                                    var splitArray = receiver_.split(';')
                                    var receiverInfo
                                    var splitReceiverInfo
                                    if (splitArray.length > 1) {
                                    }
                                    else {
                                        receiverInfo = splitArray[0]
                                        splitReceiverInfo = receiverInfo.split('-')
                                        r = splitReceiverInfo[0]
                                    }
                                    if (getAddress(walletList.get(walletIndex).name, walletList.get(walletIndex).label) === sender_) {
                                        txFee = fee_
                                        rawTX = rawTx_
                                        receivedReceiver = receiver_
                                        receivedSender = sender_
                                        usedCoins = usedCoins_
                                        receivedAmount = sendAmount_
                                        receivedLabel = ""
                                        if (splitArray.length === 1) {
                                            for (var i = 0; i < walletList.count; i ++) {
                                                if (walletList.get(i).address === r){
                                                    receivedLabel = walletList.get(i).label
                                                }
                                            }
                                        }
                                        receivedTxID = traceId_
                                        transactionSend = 1
                                        failedSend = 0
                                        createTx = false
                                    }
                                }
                            }
                            onRawTxFailed: {
                                if (createTx == true && advancedTransferTracker == 0 && pageTracker == 0) {
                                    txFailError = "Failed to create raw transaction"
                                    createTx = false
                                    failedSend = 1
                                    transactionSend = 1
                                }
                            }
                            onFundsLow: {
                                if (createTx == true && advancedTransferTracker == 0 && pageTracker == 0) {
                                    txFailError = "Funds too low"
                                    createTx = false
                                    failedSend = 1
                                    transactionSend = 1
                                }
                            }
                            onUtxoError: {
                                if (createTx == true && advancedTransferTracker == 0 && pageTracker == 0) {
                                    txFailError = "Error retrieving UTXO"
                                    createTx = false
                                    failedSend = 1
                                    transactionSend = 1
                                }
                            }
                        }
                    }
                }

                AnimatedImage {
                    id: waitingDots01
                    source: 'qrc:/gifs/loading-gif_01.gif'
                    width: 75
                    height: 50
                    anchors.horizontalCenter: sendButton.horizontalCenter
                    anchors.verticalCenter: sendButton.verticalCenter
                    playing: createTx == true
                    visible: createTx == true
                }
            }

            Rectangle {
                width: 1
                anchors.top: parent.top
                anchors.topMargin: appWidth/48
                anchors.bottom: parent.bottom
                anchors.bottomMargin: appWidth/24
                anchors.right: parent.right
                color: themecolor
                opacity: 0.1
            }

            Item {
                id: confirmTransaction
                anchors.top: transactionLabel.bottom
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: appWidth/24
                visible: transactionSend == 1
                         && requestSend == 0
                         && failedSend == 0

                Text {
                    id: sendingLabel
                    text: "SENDING:"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: font.pixelSize/2
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: themecolor
                }

                Item {
                    id:amount
                    implicitWidth: confirmationAmount.implicitWidth + confirmationAmount1.implicitWidth + confirmationAmount2.implicitWidth + appHeight/36
                    implicitHeight: confirmationAmount.implicitHeight
                    anchors.bottom: sendingLabel.bottom
                    anchors.right: parent.right
                }

                Text {
                    id: confirmationAmount
                    text: walletList.get(walletIndex).name
                    anchors.top: amount.top
                    anchors.right: amount.right
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: themecolor
                }

                Text {
                    property var amountArray: receivedAmount.split('.')
                    id: confirmationAmount1
                    text: amountArray[1] !== undefined?  ("." + amountArray[1]) : ".0000"
                    anchors.bottom: confirmationAmount.bottom
                    anchors.right: confirmationAmount.left
                    anchors.rightMargin: appHeight/54
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: themecolor
                }

                Text {
                    property var amountArray: receivedAmount.split('.')
                    id: confirmationAmount2
                    text: amountArray[0]
                    anchors.top: confirmationAmount.top
                    anchors.right: confirmationAmount1.left
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: themecolor
                }

                Text {
                    id: to
                    text: "TO:"
                    anchors.left: parent.left
                    anchors.top: sendingLabel.bottom
                    anchors.topMargin: appHeight/54
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: themecolor
                }

                Text {
                    property var receiverArray: receivedReceiver.split(';')
                    property var countReceivers: receiverArray.length
                    property var splitReceiver: receiverArray[0].split('-')
                    property var receiverInfo: countReceivers === 1? splitReceiver[0] : countReceivers.toLocaleString(Qt.locale("en_US"), "f", 0)
                    id: confirmationAddress
                    text: countReceivers === 1? getContact(coinID.text, receiverInfo) : receiverInfo + " receivers"
                    anchors.bottom: to.bottom
                    anchors.right: parent.right
                    anchors.left: to.right
                    anchors.leftMargin: font.pixelSize
                    horizontalAlignment: Text.AlignRight
                    elide: Text.ElideRight
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: themecolor
                }

                Text {
                    id: confirmationAddressName
                    text: "(" + receivedLabel + ")"
                    anchors.top: confirmationAddress.bottom
                    anchors.topMargin: font.pixelSize/3
                    anchors.right: parent.right
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: themecolor
                    visible: receivedLabel != ""
                }

                Text {
                    id: reference
                    text: "REF.:"
                    anchors.left: parent.left
                    anchors.top: confirmationAddressName.bottom
                    anchors.topMargin: appHeight/36
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: themecolor
                }

                Text {
                    id: referenceText
                    text: referenceInput.text !== ""? referenceInput.text : "no reference"
                    anchors.bottom: reference.bottom
                    anchors.right: parent.right
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    font.italic: referenceInput.text !== ""
                    color: themecolor
                }

                Text {
                    id: feeLabel
                    text: "TX FEE:"
                    anchors.left: parent.left
                    anchors.top: reference.bottom
                    anchors.topMargin: appHeight/54
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: themecolor
                }

                Item {
                    id:feeAmount
                    implicitWidth: confirmationFeeAmount.implicitWidth + confirmationFeeAmount1.implicitWidth + confirmationFeeAmount2.implicitWidth + appHeight/36
                    implicitHeight: confirmationAmount.implicitHeight
                    anchors.bottom: feeLabel.bottom
                    anchors.right: parent.right
                }

                Text {
                    id: confirmationFeeAmount
                    text: walletList.get(walletIndex).name
                    anchors.top: feeAmount.top
                    anchors.right: feeAmount.right
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: themecolor
                }

                Text {
                    property int dec: coinIndex < 3? 4 : 8
                    property string transferFee: txFee.toLocaleString(Qt.locale("en_US"), "f", dec)
                    property var feeArray: transferFee.split('.')
                    id: confirmationFeeAmount1
                    text: feeArray[1] !== undefined?  ("." + feeArray[1]) : ".0000"
                    anchors.bottom: confirmationFeeAmount.bottom
                    anchors.right: confirmationFeeAmount.left
                    anchors.rightMargin: font.pixelSize
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: themecolor
                }

                Text {
                    property int dec: coinIndex < 3? 4 : 8
                    property string transferFee: txFee.toLocaleString(Qt.locale("en_US"), "f", decimals)
                    property var feeArray: transferFee.split('.')
                    id: confirmationFeeAmount2
                    text: feeArray[0]
                    anchors.top: confirmationFeeAmount.top
                    anchors.right: confirmationFeeAmount1.left
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: themecolor
                }

                Rectangle {
                    id: confirmTX
                    width: parent.width*0.9/2
                    height: appHeight/27
                    radius: height/2
                    anchors.left: parent.left
                    anchors.top: confirmationFeeAmount.bottom
                    anchors.topMargin: height
                    color: "transparent"
                    border.width: 1
                    border.color: themecolor

                    Rectangle {
                        id: selectConfirm
                        anchors.fill: parent
                        radius: height/2
                        color: maincolor
                        opacity: 0.3
                        visible: false
                    }

                    Text {
                        id: confirmButtonText
                        text: "CONFIRM"
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/2
                        color: parent.border.color
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: confirmTX
                        hoverEnabled: true

                        onEntered: {
                            selectConfirm.visible = true
                        }

                        onExited: {
                            selectConfirm.visible = false
                        }

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            transactionInProgress = true
                            if (userSettings.pinlock === true){
                                pincodeTracker = 1
                            }
                            else {
                                timer3.start()
                            }
                        }

                        Timer {
                            id: timer3
                            interval: pincodeTracker == 1? 1000 : 100
                            repeat: false
                            running: false

                            onTriggered: {
                                var dataModelParams = {"xdapp":network,"method":"sendrawtransaction","payload":rawTX,"id":receivedTxID}
                                var paramsJson = JSON.stringify(dataModelParams)
                                dicomRequest(paramsJson)
                                var t = new Date().toLocaleString(Qt.locale(),"hh:mm:ss .zzz")
                                var msg = "UI - confirming TX: " + paramsJson
                                xPingTread.append({"message": msg, "inout": "out", "author": myUsername, "time": t})
                                console.log("request TX broadcast: " + paramsJson)
                                var total = Number.fromLocaleString(Qt.locale("en_US"),replaceComma)
                                var totalFee = Number.fromLocaleString(Qt.locale("en_US"),txFee)
                                var totalUsed = Number.fromLocaleString(Qt.locale("en_US"),usedCoins)
                                transactionList.append({"requestID":receivedTxID,"txid":"","coin":walletList.get(walletIndex).name,"address":receivedSender,"receiver":receivedReceiver,"amount":total,"fee":totalFee,"used":totalUsed})
                                transactionSend = 0
                                failedSend = 0
                                transactionInProgress = false
                                rawTX = ""
                                txFee = 0
                                receivedAmount = ""
                                receivedLabel = ""
                                receivedReceiver = ""
                                receivedSender = ""
                                receivedTxID = ""
                                usedCoins = ""
                                keyInput.text = ""
                                sendAmount.text = ""
                            }
                        }

                        Connections {
                            target: UserSettings

                            onPincodeCorrect: {
                                if (pincodeTracker == 1 && transferTracker == 1 && advancedTransferTracker == 0) {
                                    timer3.start()
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: cancelTX
                    width: parent.width*0.9/2
                    height: appHeight/27
                    radius: height/2
                    anchors.right: parent.right
                    anchors.top: confirmationFeeAmount.bottom
                    anchors.topMargin: height
                    color: "transparent"
                    border.width: 1
                    border.color: themecolor

                    Rectangle {
                        id: cancelConfirm
                        anchors.fill: parent
                        radius: height/2
                        color: maincolor
                        opacity: 0.3
                        visible: false
                    }

                    Text {
                        id: cancelButtonText
                        text: "CANCEL"
                        font.family: xciteMobile.name
                        font.pixelSize: parent.height/2
                        color: parent.border.color
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: cancelTX
                        hoverEnabled: true

                        onEntered: {
                            cancelConfirm.visible = true
                        }

                        onExited: {
                            cancelConfirm.visible = false
                        }

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            transactionSend = 0
                            failedSend = 0
                            rawTX = ""
                            txFee = 0
                            receivedAmount = ""
                            receivedLabel = ""
                            receivedReceiver = ""
                            receivedSender = ""
                            receivedTxID = ""
                            usedCoins = ""
                        }
                    }
                }
            }

            Item {
                id: transferFailed
                height: failedIcon.height + failedIconLabel.height + failedIconLabel.anchors.topMargin + failedErrorLabel.height +failedErrorLabel.anchors.topMargin + closeFail.height + closeFail.anchors.topMargin
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: appWidth/24
                anchors.verticalCenter: parent.verticalCenter
                visible: transactionSend == 1
                         && failedSend == 1

                Image {
                    id: failedIcon
                    source: darktheme == true? 'qrc:/icons/mobile/failed-icon_01_light.svg' : 'qrc:/icons/mobile/failed-icon_01_dark.svg'
                    width: appWidth/24
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: transferFailed.modalTop
                }

                Label {
                    id: failedIconLabel
                    text: "Transaction failed!"
                    anchors.top: failedIcon.bottom
                    anchors.topMargin: failedIcon.height/2
                    anchors.horizontalCenter: failedIcon.horizontalCenter
                    color: themecolor
                    font.pixelSize: appHeight/36
                    font.family: xciteMobile.name
                }

                Label {
                    id: failedErrorLabel
                    text: txFailError
                    anchors.top: failedIconLabel.bottom
                    anchors.topMargin: font.pixelSize/2
                    anchors.horizontalCenter: failedIcon.horizontalCenter
                    color: themecolor
                    font.pixelSize: appHeight/45
                    font.family: xciteMobile.name
                }

                Rectangle {
                    id: closeFail
                    width: appWidth/6
                    height: appHeight/27
                    radius: height/2
                    anchors.top: failedErrorLabel.bottom
                    anchors.topMargin: height*1.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    border.width: 1
                    border.color: themecolor

                    Rectangle {
                        id: selectClose
                        anchors.fill: parent
                        radius: height/2
                        color: maincolor
                        opacity: 0.3
                        visible: false
                    }

                    Text {
                        id: closeButtonText
                        text: "OK"
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
                            selectClose.visible = true
                        }

                        onExited: {
                            selectClose.visible = false
                        }

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            failedSend = 0
                            transactionSend = 0
                            rawTX = ""
                            txFee = 0
                            receivedAmount = ""
                            receivedLabel = ""
                            receivedReceiver = ""
                            receivedSender = ""
                            receivedTxID = ""
                            usedCoins = ""
                        }
                    }
                }
            }
        }

        Item {
            id: historyArea
            width: (parent.width - appWidth*3/24)/2
            anchors.right: parent.right
            anchors.rightMargin: appWidth/12
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: appWidth/24
            clip: true

            Label {
                id: historyLabel
                text: "TRANSACTIONS"
                color: themecolor
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                anchors.top: parent.top
                anchors.horizontalCenter: historyListArea.horizontalCenter
            }

            Controls.Switch {
                id: historySwitch
                anchors.horizontalCenter: historyListArea.horizontalCenter
                anchors.top: historyLabel.bottom
                anchors.topMargin: appWidth/48
                state: "off"
                switchActive: coinIndex < 3
            }

            Text {
                id: confirmedText
                text: "CONFIRMED"
                anchors.right: historySwitch.left
                anchors.rightMargin: font.pixelSize/2
                anchors.verticalCenter: historySwitch.verticalCenter
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                color: historySwitch.switchOn ? "#757575" : maincolor
            }

            Text {
                id: pendingText
                text: "PENDING"
                anchors.left: historySwitch.right
                anchors.leftMargin: font.pixelSize/2
                anchors.verticalCenter: historySwitch.verticalCenter
                font.pixelSize: appHeight/36
                font.family: xciteMobile.name
                color: historySwitch.switchOn ? maincolor : "#757575"
            }

            Image {
                id: refreshButton
                source: darktheme == true? "qrc:/icons/refresh_icon_light-01.png" : "qrc:/icons/refresh_icon_dark-01.png"
                height: historySwitch.height
                fillMode: Image.PreserveAspectFit
                anchors.right: historyListArea.right
                anchors.verticalCenter: historySwitch.verticalCenter
                visible: coinIndex < 3 && historySwitch.state == "off"
                rotation : 0

                property bool updating: loadTransactionsInitiated

                onUpdatingChanged: {
                    if (!updating) {
                        refreshButton.rotation = 0
                    }
                }

                Timer {
                    interval: 100
                    repeat: true
                    running: refreshButton.updating

                    onTriggered: {
                        refreshButton.rotation += 15
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    radius: width/2
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            loadTransactionsInitiated = true
                            click01.play()
                            detectInteraction()
                            newHistory = 1
                            updateTransactions(walletList.get(walletIndex).name, walletList.get(walletIndex).address, currentPage)
                        }
                    }
                }
            }

            Rectangle {
                id: historyListArea
                height: parent.height*2/3
                anchors.left: parent.left
                anchors.leftMargin: appWidth/24
                anchors.right: parent.right
                anchors.top: historySwitch.bottom
                anchors.topMargin: appWidth/96
                color: "transparent"
                clip: true

                Desktop.HistoryList {
                    id: myHistory
                    anchors.top: parent.top
                    visible: historySwitch.state == "off" && historyDetailsCollected == true && coinIndex < 3
                }



                Desktop.PendingList {
                    id: myPending
                    anchors.top: parent.top
                    visible: historySwitch.state == "on" && coinIndex < 3
                }
            }

            Item {
                z: 3
                width: popupExplorerBusy.width
                height: 50
                anchors.horizontalCenter: historyListArea.horizontalCenter
                anchors.verticalCenter: historyListArea.verticalCenter
                visible: explorerBusy == true && explorerPopup == 1

                Rectangle {
                    id: popupExplorerBusy
                    height: popupExplorerText.font.pixelSize*2
                    width: popupExplorerText.width + popupClipboardText.font.pixelSize*2
                    color: "#34363D"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                Label {
                    id: popupExplorerText
                    text: "Explorer is busy. Try again"
                    font.family: xciteMobile.name
                    font.pixelSize: appHeight/54
                    color: "#E55541"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                Timer {
                    repeat: false
                    running: explorerPopup == 1
                    interval: 2000

                    onTriggered: explorerPopup = 0
                }
            }

            Rectangle {
                z: 3
                anchors.fill: historyListArea
                color: "black"
                opacity: 0.50
                visible: historyDetailsCollected = false

                MouseArea {
                    anchors.fill: parent
                }
            }

            AnimatedImage  {
                z: 3
                id: waitingDots
                source: 'qrc:/gifs/loading-gif_01.gif'
                width: 75
                height: 50
                anchors.horizontalCenter: historyListArea.horizontalCenter
                anchors.verticalCenter: historyListArea.verticalCenter
                playing: historyDetailsCollected == false && coinIndex < 3
                visible: historyDetailsCollected == false && coinIndex < 3
            }

            Label {
                z: 3
                text: "Not available for this coion"
                font.family: xciteMobile.name
                font.pixelSize: appHeight/54
                color: themecolor
                anchors.horizontalCenter: historyListArea.horizontalCenter
                anchors.verticalCenter: historyListArea.verticalCenter
                visible: coinIndex > 2
            }

            Label {
                id: historyFirst
                text: "FIRST"
                anchors.left: historyListArea.left
                anchors.top: historyListArea.bottom
                anchors.topMargin: font.pixelSize
                font.pixelSize: appHeight/54
                font.family: xciteMobile.name
                color: themecolor
                font.letterSpacing: 2
                visible: currentPage > 2 && historySwitch.state == "off"

                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height + parent.font.pixelSize/2
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            loadTransactionsInitiated = true
                            currentPage = 1
                            newHistory = 1
                            updateTransactions(walletList.get(walletIndex).name, walletList.get(walletIndex).address, currentPage)
                        }
                    }
                }
            }

            Label {
                id: historyPrevious
                text: "PREVIOUS"
                anchors.left: currentPage == 2? historyListArea.left : historyFirst.right
                anchors.leftMargin: currentPage == 2? 0 : font.pixelSize
                anchors.top: historyListArea.bottom
                anchors.topMargin: font.pixelSize
                font.pixelSize: appHeight/54
                font.family: xciteMobile.name
                color: themecolor
                font.letterSpacing: 2
                visible: currentPage !== 1 && historySwitch.state == "off"

                Rectangle {
                    anchors.left: historyPrevious.left
                    anchors.right: historyPrevious.right
                    anchors.verticalCenter: historyPrevious.verticalCenter
                    height: historyPrevious.height + historyPrevious.font.pixelSize/2
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            loadTransactionsInitiated = true
                            currentPage = currentPage - 1
                            newHistory = 1
                            updateTransactions(walletList.get(walletIndex).name, walletList.get(walletIndex).address, currentPage)
                        }
                    }
                }
            }

            Label {
                id: pageCount
                text: currentPage + " of " + transactionPages
                anchors.horizontalCenter: historyListArea.horizontalCenter
                anchors.top: historyListArea.bottom
                anchors.topMargin: font.pixelSize
                font.pixelSize: appHeight/54
                font.family: xciteMobile.name
                color: themecolor
                visible: transactionPages > 0 && historySwitch.state == "off"
            }

            Label {
                id: historyNext
                text: "NEXT"
                anchors.right: currentPage === transactionPages - 1? historyListArea.right : historyLast.left
                anchors.rightMargin: currentPage === transactionPages - 1? 0 : font.pixelSize
                anchors.top: historyListArea.bottom
                anchors.topMargin: font.pixelSize
                font.pixelSize: appHeight/54
                font.family: xciteMobile.name
                color: themecolor
                font.letterSpacing: 2
                visible: currentPage < transactionPages && historySwitch.state == "off"

                Rectangle {
                    anchors.left: historyNext.left
                    anchors.right: historyNext.right
                    anchors.verticalCenter: historyNext.verticalCenter
                    height: historyNext.height + historyNext.font.pixelSize/2
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            loadTransactionsInitiated = true
                            currentPage = currentPage + 1
                            newHistory = 1
                            updateTransactions(walletList.get(walletIndex).name, walletList.get(walletIndex).address, currentPage)
                        }
                    }
                }
            }

            Label {
                id: historyLast
                text: "LAST"
                anchors.right: historyListArea.right
                anchors.top: historyListArea.bottom
                anchors.topMargin: font.pixelSize
                font.pixelSize: appHeight/54
                font.family: xciteMobile.name
                color: themecolor
                font.letterSpacing: 2
                visible: currentPage < transactionPages - 1 && historySwitch.state == "off"

                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height + parent.font.pixelSize/2
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            click01.play()
                            detectInteraction()
                        }

                        onClicked: {
                            loadTransactionsInitiated = true
                            currentPage = transactionPages
                            newHistory = 1
                            updateTransactions(walletList.get(walletIndex).name, walletList.get(walletIndex).address, currentPage)
                        }
                    }
                }
            }

            Connections {
                target: explorer

                onUpdateTransactions: {
                    if (historyTracker === 1) {
                        loadTransactions(transactions);
                        newHistory = 0
                        loadTransactionsInitiated = false
                    }
                }
            }
        }

        Rectangle {
            anchors.fill: parent.fill
            color: bgcolor
            visible: deleteFailed == 1

            Item {
                width: parent.width
                height: failedDeleteIcon.height + failedDeleteIcon.anchors.topMargin + deleteFailedLabel.height + deleteFailedLabel.anchors.topMargin + closeFailDelete.height + closeFailDelete.anchors.topMargin
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

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
                    width: appWidth/3
                    maximumLineCount: 3
                    wrapMode: Text.WordWrap
                    text: "Failed to delete your address! Try again."
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
                        font.pixelSize: parent.height/2
                        color: parent.border.color
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
                            deleteErrorNr = 0
                            deleteFailed = 0
                            deletingWallet = false
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        anchors.fill: closeAddressList
        radius: height/2
        color: bgcolor
        opacity: 0.9
    }

    Rectangle {
        id: closeAddressList
        width: appWidth/48
        height: width
        radius: height/2
        color: "transparent"
        border.width: 1
        border.color: themecolor
        anchors.right: addressBookArea.right
        anchors.bottom: addressBookArea.top
        anchors.bottomMargin: height/2
        visible: addressbookTracker == 1

        Item {
            width: parent.width*0.6
            height: width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: 45

            Rectangle {
                width: parent.width
                height: 1
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                height: parent.height
                width: 1
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            id: closeAddressSelect
            anchors.fill: parent
            radius: height/2
            color: maincolor
            opacity: 0.3
            visible: false
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                closeAddressSelect.visible = true
            }

            onExited: {
                closeAddressSelect.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                addressbookTracker = 0
            }
        }
    }

    DropShadow {
        anchors.fill: addressBookArea
        source: addressBookArea
        horizontalOffset: 4
        verticalOffset: -4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.3
        transparentBorder: true
    }

    Rectangle {
        id: addressBookArea
        width: appWidth/3
        height: myAddressBookPicklist.addressCount*appHeight/15 < parent.height/2? myAddressBookPicklist.addressCount*appHeight/15 : parent.height/2
        color: "#2A2C31"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: appWidth/24
        state: addressbookTracker == 0 ? "down" : advancedTransferTracker == 0? "up" : "down"
        clip: true

        states: [
            State {
                name: "up"
                PropertyChanges { target: addressBookArea; anchors.bottomMargin: appWidth/24}
            },
            State {
                name: "down"
                PropertyChanges { target: addressBookArea; anchors.bottomMargin: -addressBookArea.height}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: addressBookArea; properties: "anchors.bottomMargin"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]

        Desktop.AddressBookPicklist {
            id: myAddressBookPicklist
            anchors.top: parent.top

            onAddressSelectedChanged: {
                if (addressSelected) {
                    keyInput.text = selectedAddress
                }
            }
        }
    }

    Rectangle {
        anchors.fill: closeWalletList
        radius: height/2
        color: bgcolor
        opacity: 0.9
    }

    Rectangle {
        id: closeWalletList
        width: appWidth/48
        height: width
        radius: height/2
        color: "transparent"
        border.width: 1
        border.color: themecolor
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        anchors.bottom: selectWalletArea.top
        anchors.bottomMargin: height/2
        visible: walletListTracker == 1 && pageTracker == 0

        Item {
            width: parent.width*0.6
            height: width
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: 45

            Rectangle {
                width: parent.width
                height: 1
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                height: parent.height
                width: 1
                color: themecolor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            id: closeSelect
            anchors.fill: parent
            radius: height/2
            color: maincolor
            opacity: 0.3
            visible: false
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                closeSelect.visible = true
            }

            onExited: {
                closeSelect.visible = false
            }

            onPressed: {
                click01.play()
                detectInteraction()
            }

            onClicked: {
                walletListTracker = 0
            }
        }
    }

    DropShadow {
        anchors.fill: selectWalletArea
        source: selectWalletArea
        horizontalOffset: 4
        verticalOffset: -4
        radius: 12
        samples: 25
        spread: 0
        color: "black"
        opacity: 0.3
        transparentBorder: true
    }

    Rectangle {
        id: selectWalletArea
        width: appWidth/3
        height: myWalletListSmall.walletCount*appHeight/15 < parent.height/2? myWalletListSmall.walletCount*appHeight/15 : parent.height/2
        color: "#2A2C31"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: appWidth/12
        state: walletListTracker == 0 && pageTracker == 0? "down" : "up"
        clip: true

        states: [
            State {
                name: "up"
                PropertyChanges { target: selectWalletArea; anchors.bottomMargin: appWidth/24}
            },
            State {
                name: "down"
                PropertyChanges { target: selectWalletArea; anchors.bottomMargin: -selectWalletArea.height}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: selectWalletArea; properties: "anchors.bottomMargin"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]

        Desktop.WalletListSmall {
            id: myWalletListSmall
            anchors.top: parent.top
            onlyView: false
            coinFilter: getName(coinIndex)
        }
    }

    Item {
        id: scannerArea
        height: walletArea.height
        width: (walletArea.width - appWidth*3/24)/2
        anchors.left: walletArea.left
        anchors.leftMargin: appWidth/24
        anchors.top: walletArea.top
        state: scanQRTracker == 1 && advancedTransferTracker == 0? "up" : "down"

        onStateChanged: {
            if (advancedTransferTracker == 0) {
                if (scanQRTracker == 0 && qrFound == false) {
                    selectedAddress = ""
                    publicKey.text = "scanning..."
                }
                if (state == "up") {
                    scanTimer.restart()
                }
            }
        }

        states: [
            State {
                name: "up"
                PropertyChanges { target: scannerArea; anchors.topMargin: 0}
            },
            State {
                name: "down"
                PropertyChanges { target: scannerArea; anchors.topMargin: scannerArea.height + appWidth/24}
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { target: scannerArea; properties: "anchors.bottomMargin"; duration: 300; easing.type: Easing.InOutCubic}
            }
        ]
    }

    Rectangle {
        id: qrScanner
        width: scannerArea.width
        height: scannerArea.height
        color: bgcolor
        anchors.horizontalCenter: scannerArea.horizontalCenter
        anchors.top: scannerArea.top

        Timer {
            id: scanTimer
            interval: 15000
            repeat: false
            running: false

            onTriggered: {
                scanQRTracker = 0
                publicKey.text = "scanning..."
            }
        }

        Timer {
            id: timer1
            interval: 1000
            repeat: false
            running: false

            onTriggered:{
                scanQRTracker = 0
                publicKey.text = "scanning..."
                qrFound = false
            }
        }

        Camera {
            id: camera
            position: Camera.FrontFace
            cameraState: cameraPermission === true? ((transferTracker == 1 && advancedTransferTracker == 0) ? (scanQRTracker == 1 ? Camera.ActiveState : Camera.LoadedState) : Camera.UnloadedState) : Camera.UnloadedState
            focus {
                focusMode: Camera.FocusContinuous
                focusPointMode: CameraFocus.FocusPointAuto
            }

            onCameraStateChanged: {
                console.log("camera status: " + camera.cameraStatus)
            }
        }

        Rectangle {
            width: scannerBg.width*1.05
            height: scannerBg.height*1.05
            color: bgcolor
            border.width: 2
            border.color: themecolor
            anchors.horizontalCenter: scannerBg.horizontalCenter
            anchors.verticalCenter: scannerBg.verticalCenter
        }

        Rectangle {
            id: scannerBg
            width: appWidth*5/18
            height: appHeight/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            color: "transparent"
            clip: true

            Label {
                text: "activating camera..."
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: scanFrame.verticalCenter
                color: "#f2f2f2"
                font.family: xciteMobile.name
                font.pixelSize: appHeight/36
                font.italic: true

            }

            VideoOutput {
                id: videoOutput
                source: camera
                width: parent.width
                fillMode: VideoOutput.PreserveAspectCrop
                autoOrientation: true
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalcenter
                filters: [
                    qrFilter
                ]
            }

            Text {
                id: scanQRLabel
                text: "SCAN QR CODE"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: font.pixelSize
                font.pixelSize: appHeight/27
                font.family: xciteMobile.name
                color: "#f2f2f2"
            }

            Rectangle {
                id: scanFrame
                width: parent.width*0.5
                height: width
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"
                border.width: 1
                border.color: "#f2f2f2"
            }

            Label {
                id: pubKey
                text: "ADDRESS"
                anchors.top: scanFrame.bottom
                anchors.topMargin: appHeight/36
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#f2f2f2"
                font.family: xciteMobile.name
                font.pixelSize: appHeight/36
                font.letterSpacing: 1
            }

            Label {
                id: publicKey
                text: scanning
                width: parent.width
                padding: appHeight/45
                maximumLineCount: 3
                wrapMode: Text.WrapAnywhere
                horizontalAlignment: Text.AlignHCenter
                anchors.top: pubKey.bottom
                anchors.topMargin: font.pixelSize/2
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#f2f2f2"
                font.family: xciteMobile.name
                font.pixelSize: appHeight/45
                font.italic: publicKey.text == "scanning..."

            }
        }

        QZXingFilter {
            id: qrFilter
            decoder {
                enabledDecoders: QZXing.DecoderFormat_QR_CODE
                onTagFound: {
                    scanTimer.stop()
                    console.log(tag);
                    scanning = ""
                    publicKey.text = tag
                    keyInput.text = publicKey.text
                    timer1.start()
                }
                tryHarder: true

            }

            captureRect: {
                // setup bindings
                videoOutput.contentRect;
                videoOutput.sourceRect;
                return videoOutput.mapRectToSource(videoOutput.mapNormalizedRectToItem(Qt.rect(
                                                                                           0.125, 0.125, 0.75, 0.75
                                                                                           )));
            }
        }
    }

    Rectangle {
        height: appWidth/24
        width: parent.width
        anchors.bottom: parent.bottom
        color: darktheme == true? "#14161B" : "#FDFDFD"
    }

    Timer {
        id: timer
        interval: 2000
        repeat: false
        running: false

        onTriggered: {
            addressCopied = 0
            copy2clipboard = 0
            closeAllClipboard = true
        }
    }
}
