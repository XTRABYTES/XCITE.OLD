/**
 * Filename: main.qml
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
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import Clipboard 1.0
import Qt.labs.settings 1.0

ApplicationWindow {
    property bool isNetworkActive: false

    id: xcite

    property string receivingAddress: "BiJeija103JfjQWpdkl230fjFEI3019JKl"
    property string receivingAddressXFUEL: "F6xCY2wNyE7KwkWcUqeZVTy6WvciHYb5Eq"
    property string receivingAddressBTC: "15q3aKVcrkCYFA3bGYn1uyZzVyHigXra1s"
    property string receivingAddressETH: "0x9de2bb59edc421c141a6ba1253703d2beddc3612"

    property string nameXBY: "XBY"
    property string labelXBY: "Main"
    property real balanceXBY: wallet.balance
    property real unconfirmedXBY: 0
    property real valueXBY: 0.0185 //btcValueXBY * btcmarketvalue.marketvalue
    property real btcValueXBY: 0.00000445 //xbymarketvalue.btcmarketvalue
    property real percentageXBY: 23.47

    property string nameXFUEL: "XFUEL"
    property string labelXFUEL: "Main"
    property real balanceXFUEL: 1465078.00000000 // xfuelwallet.balance
    property real unconfirmedXFUEL: 0
    property real valueXFUEL: valueXBY //btcValueXFUEL * btcmarketvalue.marketvalue
    property real btcValueXFUEL: btcValueXBY //xfuelmarketValue.btcmarketvalue
    property real percentageXFUEL: 23.47

    property real btcValueBTC: 1

    property color maincolor: "#0ED8D2"
    property bool darktheme: false

    property int onboardingTracker: 0 // check settings for real value
    property int signUpTracker: 0 // check settings for real value
    property int loginTracker: 0
    property int appsTracker: 0
    property int transferTracker: 0
    property int addressTracker: 0
    property int addAddressTracker: 0
    property int addCoinTracker: 0
    property int picklistTracker: 0
    property int newCoinPicklist: 0
    property int newCoinSelect: 0
    property int addressbookTracker: 0
    property int scanQRTracker: 0
    property int tradingTracker: 0
    property int balanceTracker: 0
    property int calculatorTracker: 0
    property int addressQRTracker: 0

    property string scannedAddress: ""
    property string selectedAddress: ""
    property var calculatedAmount: ""
    property string scanning: "scanning..."
    property string addressbookName: ""
    property string addressbookHash: ""
    property int addressIndex: 0
    property int currencyIndex: 0
    property int totalLines: 4
    property int totalAddresses: countAddresses()
    property int totalWallets: countWallets()
    property real totalBalance: 0
    property int addressID: 1
    property int walletID: 0
    property int xbyTXID: 1
    property int xfuelTXID: 1
    property int selectAddressIndex: 0

    property real doubbleButtonWidth: 273

    signal marketValueChangedSignal(string currency)
    signal localeChange(string locale)
    signal clearAllSettings

    function countWallets(){
        totalWallets = 0
        for(var i = 0; i < currencyList.count; i++) {
            if (currencyList.get(i).active === 1) {
                totalWallets += 1
            }
        }
        return totalWallets
    }

    function countAddresses(){
        totalAddresses = 0
        for(var i = 0; i < currencyList.count; i++) {
            totalAddresses += 1
        }
        return totalAddresses
    }

    function sumBalance(){
        totalBalance = 0
        for(var i = 0; i < currencyList.count; i++) {
            if (currencyList.get(i).active === 1) {
                totalBalance += (currencyList.get(i).balance * currencyList.get(i).coinValue)
            }
        }
        return totalBalance
    }

    function picklistLines(){
        totalLines = 0
        for(var i = 0; i < currencyList.count; i++) {
            totalLines += 1
        }
        return totalLines
    }

    function picklistLinesActive(){
        totalLines = 0
        for(var i = 0; i < currencyList.count; i++) {
            if (currencyList.get(i).active === 1) {
                totalLines += 1
            }
        }
        return totalLines
    }

    function onMarketValueChanged(currency) {
        marketValueChangedSignal(currency)
    }

    function loadCurrencyList() {
        // create currencyList when XCITE starts up
    }

    function loadAddressList() {

    }

    function loadXBYHistory() {

    }

    function loadXFUELHistory() {

    }

    function loadBTCHistory() {

    }

    function loadETHHistory() {

    }

    ListModel {
        id: xbyTXHistory
        ListElement {
            date: ""
            amount: 0
            txid: ""
            txpartnerHash: ""
            reference: ""
            txNR: 0
        }
    }

    ListModel {
        id: xfuelTXHistory
        ListElement {
            date: ""
            amount: 0
            txid: ""
            txpartnerHash: ""
            reference: ""
            txNR: 0
        }
    }

    ListModel {
        id: addressList
        ListElement {
            address: ""
            name: ""
            logo: ''
            coin: ""
            active: false
            favorite: 0
            uniqueNR: 0
        }
    }

    ListModel {
        id: currencyList
        ListElement {
            name: ""
            label: ""
            logo: ''
            address: ""
            balance: 0
            unconfirmedCoins: 0
            coinValue: 0
            coinValueBTC: 0
            percentage: 0
            fiatValue: 0
            favorite: 0
            active: 1
            walletNR: 0
        }
    }

    StackView {
        id: mainRoot
        initialItem: "../Login.qml"
        anchors.fill: parent
    }


    // placeholders until there is a persistent addressbook and connection to the backend
    Component.onCompleted: {

        if (signUpTracker == 0) {
            mainRoot.push("../SignUp.qml")
        }
        if (onboardingTracker == 0) {
            mainRoot.push("../Onboarding.qml")
        }

        onMarketValueChanged("USD")

        currencyList.setProperty(0, "name", "XFUEL");
        currencyList.setProperty(0, "label", "Main");
        currencyList.setProperty(0, "logo", 'qrc:/icons/XFUEL_card_logo_colored_07.svg');
        currencyList.setProperty(0, "address", receivingAddressXFUEL);
        currencyList.setProperty(0, "balance", balanceXFUEL);
        currencyList.setProperty(0, "unconfirmedCoins", unconfirmedXFUEL);
        currencyList.setProperty(0, "coinValue", valueXFUEL);
        currencyList.setProperty(0, "coinValueBTC", btcValueXFUEL);
        currencyList.setProperty(0, "percentage", percentageXFUEL);
        currencyList.setProperty(0, "fiatValue", (balanceXFUEL * valueXFUEL));
        currencyList.setProperty(0, "active", 1);
        currencyList.setProperty(0, "favorite", 1);
        currencyList.setProperty(0, "walletNR", walletID);
        walletID = walletID +1;
        currencyList.append({"name": "XBY", "label": "Main", "logo": 'qrc:/icons/XBY_card_logo_colored_05.svg', "address": receivingAddress, "balance" : balanceXBY, "unconfirmedCoins": unconfirmedXBY, "coinValue": valueXBY, "coinValueBTC": btcValueXBY, "percentage": percentageXBY, "fiatValue": (balanceXBY * valueXBY), "active": 0, "favorite": 0, "walletNR": walletID});
        walletID = walletID +1;

        addressList.append({"address": receivingAddressXFUEL, "name": "My XFUEL address", "logo": (currencyList.get(0).logo), "coin": (currencyList.get(0).name), "favorite": 1, "active": true, "uniqueNR": addressID});
        addressID = addressID + 1;
        addressList.append({"address": receivingAddress, "name": "My XBY address", "logo": (currencyList.get(1).logo), "coin": (currencyList.get(1).name), "favorite": 1, "active": false, "uniqueNR": addressID});
        addressID = addressID + 1;
    }

    visible: true

    width: Screen.width
    height: Screen.height
    title: qsTr("XCITE")
    color: "#2B2C31"

    overlay.modal: Rectangle {
        color: "#c92a2c31"
    }

    Clipboard {
        id: clipboard
    }

    Settings {
        id: settings
        property string locale: "en_us"
        property bool onboardingCompleted: true
        property string defaultCurrency: "USD"
    }

    Settings {
        id: developerSettings
        category: "developer"
        property bool skipOnboarding: true
        property bool skipLogin: true

    }

    Network {
        id: network
        handler: wallet
    }

    FontLoader {
        id: xciteMobile
        name: "Brandon Grotesque"
        //source: "qrc:/fonts/Orkney-Regular.otf"
    }

    FontLoader {
        id: xciteDesktop
        source: "qrc:/fonts/Brandon_reg.otf"
    }


}
