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
import Qt.labs.folderlistmodel 2.11
import QtMultimedia 5.8
import QtGraphicalEffects 1.0

ApplicationWindow {
    property bool isNetworkActive: false

    id: xcite

    visible: true

    width: Screen.width
    height: Screen.height
    title: qsTr("XCITE")
    color: "#14161B"

    Label {
        id:helloModalLabel
        text: "HELLO"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 20
        font.family: "Brandon Grotesque"
        color: "#F2F2F2"
        font.letterSpacing: 2
    }

    Component.onDestruction: {
        interactionTracker = 0
        loginTracker = 0
        logoutTracker = 0
        addWalletTracker = 0
        createWalletTracker = 0
        appsTracker = 0
        coinTracker = 0
        walletTracker = 0
        transferTracker = 0
        historyTracker = 0
        addressTracker = 0
        contactTracker = 0
        addAddressTracker = 0
        addCoinTracker = 0
        addContactTracker = 0
        editContactTracker = 0
        coinListTracker = 0
        walletListTracker = 0
        addressbookTracker = 0
        scanQRTracker = 0
        tradingTracker = 0
        balanceTracker = 0
        calculatorTracker = 0
        addressQRTracker = 0
        pictureTracker = 0
        cellTracker = 0
        currencyTracker = 0
        pincodeTracker = 0
        debugTracker = 0
        contactID = 0
        addressID = 1
        walletID = 1
        txID = 1
        pictureID = 0
        currencyID = 0
        coinIndex = 0
        walletIndex = 1
        saveAppSettings()
        addressList.clear()
        contactList.clear()
        walletList.clear()
        clearAllSettings()
    }

    Component.onCompleted: {
        clearAllSettings()
        console.log("locale: " + userSettings.locale + ", default currency: " + userSettings.defaultCurrency + ", theme: " + userSettings.theme + ", pinlock: " + userSettings.pinlock + " account complete: " + userSettings.accountCreationCompleted + ", local keys: " + userSettings.localKeys)

        contactID = 0
        addressID = 1
        walletID = 1
        txID = 1
        pictureID = 0
        walletIndex = 1

        profilePictures.setProperty(0, "photo", 'qrc:/icons/icon-profile_01.svg');
        profilePictures.setProperty(0, "pictureNR", pictureID);
        pictureID = pictureID +1;
        profilePictures.append({"photo": 'qrc:/icons/icon-profile_02.svg', "pictureNR": pictureID});
        pictureID = pictureID +1;
        profilePictures.append({"photo": 'qrc:/icons/icon-profile_03.svg', "pictureNR": pictureID});
        pictureID = pictureID +1;
        profilePictures.append({"photo": 'qrc:/icons/icon-profile_04.svg', "pictureNR": pictureID});
        pictureID = pictureID +1;

        fiatCurrencies.setProperty(0, "currency", "USD");
        fiatCurrencies.setProperty(0, "ticker", "$");
        fiatCurrencies.setProperty(0, "currencyNR", 0);
        fiatCurrencies.append({"currency": "EUR", "ticker": "€", "currencyNR": 1});
        fiatCurrencies.append({"currency": "GBP", "ticker": "£", "currencyNR": 2});

        coinList.setProperty(0, "name", nameXFUEL);
        coinList.setProperty(0, "fullname", "XFUEL");
        coinList.setProperty(0, "logo", 'qrc:/icons/XFUEL_card_logo_01.svg');
        coinList.setProperty(0, "logoBig", 'qrc:/icons/XFUEL_logo_big.svg');
        coinList.setProperty(0, "coinValueBTC", btcValueXFUEL);
        coinList.setProperty(0, "percentage", percentageXFUEL);
        coinList.setProperty(0, "totalBalance", 0);
        coinList.setProperty(0, "active", true);
        coinList.setProperty(0, "coinID", 0);
        coinList.append({"name": nameXBY, "fullname": "XTRABYTES", "logo": 'qrc:/icons/XBY_card_logo_01.svg', "logoBig": 'qrc:/icons/XBY_logo_big.svg', "coinValueBTC": btcValueXBY, "percentage": percentageXBY, "totalBalance": 0, "active": true, "coinID": 1});

        marketValueChangedSignal("btcusd");
        marketValueChangedSignal("btceur");
        marketValueChangedSignal("btcgbp");
        marketValueChangedSignal("xbybtc");
        marketValueChangedSignal("xbycha");

        mainRoot.push("../Onboarding.qml")
    }



    onBtcValueXBYChanged: {
        coinList.setProperty(1, "coinValueBTC", btcValueXBY);
        coinList.setProperty(1, "fiatValue", btcValueXBY * valueBTC);
    }

    onPercentageXBYChanged: {
        coinList.setProperty(1, "percentage", percentageXBY);
    }

    onBtcValueXFUELChanged: {
        coinList.setProperty(0, "coinValueBTC", btcValueXFUEL);
        coinList.setProperty(0, "fiatValue", btcValueXFUEL * valueBTC);
    }

    onPercentageXFUELChanged: {
        coinList.setProperty(0, "percentage", percentageXFUEL);
    }


    // Place holder values for wallets
    property string receivingAddressXBY1: "BiJeija103JfjQWpdkl230fjFEI3019JKl"
    property string nameXBY1: nameXBY
    property string labelXBY1: "Main"
    property real balanceXBY1: wallet.balance
    property real unconfirmedXBY1: 0

    property string receivingAddressXFUEL1: "F6xCY2wNyE7KwkWcUqeZVTy6WvciHYb5Eq"
    property string nameXFUEL1: nameXFUEL
    property string labelXFUEL1: "Main"
    property real balanceXFUEL1: 1465078.00000000 // xfuelwallet.balance
    property real unconfirmedXFUEL1: 0

    property string receivingAddressXFUEL2: "FAQbF9wCFPgE37PrNHeCU4KXpHezQrgUDu"
    property string nameXFUEL2: nameXFUEL
    property string labelXFUEL2: "Test"
    property real balanceXFUEL2: 1358832.85000000 // xfuelwallet.balance
    property real unconfirmedXFUEL2: 0

    // BTC information
    property real btcValueBTC: 1
    property real valueBTCUSD
    property real valueBTCEUR
    property real valueBTCGBP
    property real valueBTC: userSettings.defaultCurrency == 0? valueBTCUSD : userSettings.defaultCurrency == 1? valueBTCEUR : valueBTCGBP

    // Coin info, retrieved from server
    property string nameXBY: "XBY"
    property real btcValueXBY
    property real valueXBY: btcValueXBY * valueBTC
    property real percentageXBY

    property string nameXFUEL: "XFUEL"
    property real btcValueXFUEL
    property real valueXFUEL: btcValueXFUEL * valueBTC
    property real percentageXFUEL

    // Global theme settings, non-editable
    property color maincolor: "#0ED8D2"
    property color themecolor: darktheme == true? "#F2F2F2" : "#2A2C31"
    property color bgcolor: darktheme == true? "#14161B" : "#FDFDFD"
    property real doubbleButtonWidth: Screen.width - 56

    // Global setting, editable
    property bool darktheme: userSettings.theme == "dark"? true : false
    property string fiatTicker: fiatCurrencies.get(userSettings.defaultCurrency).ticker
    property string username: ""
    property string selectedPage: ""

    // Trackers
    property int interactionTracker: 0
    property int loginTracker: 0
    property int logoutTracker: 0
    property int addWalletTracker: 0
    property int createWalletTracker: 0
    property int importKeyTracker: 0
    property int appsTracker: 0
    property int coinTracker: 0
    property int walletTracker: 0
    property int transferTracker: 0
    property int historyTracker: 0
    property int addressTracker: 0
    property int contactTracker: 0
    property int addAddressTracker: 0
    property int addCoinTracker: 0
    property int addContactTracker: 0
    property int editContactTracker: 0
    property int coinListTracker: 0
    property int walletListTracker: 0
    property int addressbookTracker: 0
    property int scanQRTracker: 0
    property int tradingTracker: 0
    property int balanceTracker: 0
    property int calculatorTracker: 0
    property int addressQRTracker: 0
    property int pictureTracker: 0
    property int cellTracker: 0
    property int currencyTracker: 0
    property int pincodeTracker: 0
    property int debugTracker: 0

    // Global variables
    property int sessionStart: 0
    property int sessionTime: 0
    property int sessionClosed: 0
    property int autoLogout: 0
    property int manualLogout: 0
    property int networkLogout: 0
    property int requestedLogout: 0
    property int pinLogout: 0
    property int goodbey: 0
    property int networkAvailable: 0
    property int networkError: 0
    property int photoSelect: 0
    property int newCoinPicklist: 0
    property int newCoinSelect: 0
    property int newWalletPicklist: 0
    property int newWalletSelect: 0
    property int switchState: 0
    property int notification: 0
    property string scannedAddress: ""
    property string selectedAddress: ""
    property string currentAddress: ""
    property var calculatedAmount: ""
    property string scanning: "scanning..."
    property string addressbookName: ""
    property string addressbookHash: ""
    property int addressIndex: 0
    property int contactIndex: 0
    property int walletIndex: 1
    property int coinIndex: 0
    property int pictureIndex: 0
    property int totalLines: 4
    property int totalAddresses: countAddresses()
    property int totalWallets: countWallets()
    property int totalCoinWallets: 0
    property real totalBalance: 0
    property int contactID: 0
    property int addressID: 1
    property int walletID: 1
    property int txID: 1
    property int selectAddressIndex: 0
    property int pictureID: 0
    property int currencyID: 0
    property int createPin: 0
    property int changePin: 0
    property int unlockPin: 0
    property int clearAll: 0
    property int pinOK: 0
    property int pinError: 0
    property int requestSend: 0
    property bool newAccount
    property real changeBalance: 0
    property string notificationDate: ""

    // Signals
    signal loginSuccesfulSignal(string username, string password)
    signal loginFailed()
    signal marketValueChangedSignal(string currency)
    signal localeChange(string locale)
    signal userLogin(string username, string password)
    signal createUser(string username, string password)
    signal userExists(string username)
    signal clearAllSettings()
    signal saveAddressBook(string addresses)
    signal saveContactList(string contactList)
    signal saveAppSettings()

    signal savePincode(string pincode)
    signal checkPincode(string pincode)

    // Automated functions

    function updateBalance() {
        var newBalance
        var balanceAlert
        var difference
        changeBalance = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).coin === "XBY") {
                newBalance = Number.fromLocaleString(Qt.locale("en_US"),(getbalanceXBY(walletList.get(i).address)))
            }
            else if (walletList.get(i).coin === "XFUEL") {
                newBalance = Number.fromLocaleString(Qt.locale("en_US"),(getbalanceXBY(walletList.get(i).address)))
            }
            if (newBalance !== walletList.get(i).balance) {
                changeBalance = newBalance - walletList.get(i).balance
                if (changeBalance > 0) {
                    difference = "increased"
                }
                else {
                    difference = "decreased"
                }
                walletList.setProperty(i, "balance", getbalanceXBY(walletList.get(i).address))
                if (transferTracker == 0) {
                    notification = 1
                    balanceAlert = "Your <b>" + walletList.get(i).coin + "</b> wallet <b>" + walletList.get(i).label + "</b> has " + difference + " with: <b>" + changeBalance + "</b>"
                    notificationList.append({"date" : new Date().toLocaleDateString(Qt.locale(),"dd MMM yy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HHmmsszzz"), "message" : balanceAlert, "origin" : "wallet"})
                }
            }
        }
    }

    // Global functions
    function countWallets() {
        totalWallets = 0
        if (coinTracker == 0) {
            for(var i = 0; i < coinList.count; i++) {
                if (coinList.get(i).active === 1) {
                    totalWallets += 1
                }
            }
        }
        else {
            var name = getName(coinIndex)
            for(var e = 0; e < walletList.count; e++){
                if (walletList.get(e).name === name) {
                    totalWallets += 1
                }
            }
        }

        return totalWallets
    }

    function coinWalletLines(coin) {
        totalCoinWallets = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coin) {
                if (walletList.get(i).remove === false) {
                    totalCoinWallets += 1
                }
            }
        }
    }

    function resetFavorites(coin) {
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coin) {
                walletList.setProperty(i, "favorite", false)
            }
        }
    }

    function countAddresses() {
        totalAddresses = 0
        for(var i = 0; i < walletList.count; i++) {
            totalAddresses += 1
        }
        return totalAddresses
    }

    function countAddressesContact(contactID) {
        var contactAddresses = 0
        for(var i = 0; i < addressList.count; i++) {
            if (addressList.get(i).contact === contactID) {
                if (addressList.get(i).remove === false) {
                    contactAddresses += 1
                }
            }
        }
        return contactAddresses
    }

    function sumBalance() {
        totalBalance = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).active === true) {
                if (walletList.get(i).name === "XBY") {
                    totalBalance += (walletList.get(i).balance * btcValueXBY * valueBTC)
                }
                else if (walletList.get(i).name === "XFUEL") {
                    totalBalance += (walletList.get(i).balance * btcValueXFUEL * valueBTC)
                }
            }
        }
        return (totalBalance * valueBTC)
    }

    function sumCoinTotal(coin) {
        var coinTotal = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coin) {
                coinTotal += walletList.get(i).balance
            }
        }
        return coinTotal
    }

    function sumCoinUnconfirmed(coin) {
        var unconfirmedTotal = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coin) {
                unconfirmedTotal += unconfirmedTotal + walletList.get(i).unconfirmedCoins
            }
        }
        return unconfirmedTotal
    }

    function coinConversion(coin, quantity) {
        var converted = 0
        for(var i = 0; i < coinList.count; i++) {
            if (coinList.get(i).name === coin) {
                converted = (quantity * coinList.get(i).coinValueBTC * valueBTC)
            }
        }
        return converted
    }

    function getLogo(coin) {
        var logo = ''
        for(var i = 0; i < coinList.count; i++) {
            if (coinList.get(i).name === coin) {
                logo = coinList.get(i).logo
            }
        }
        return logo
    }

    function getLogoBig(coin) {
        var logo = ''
        for(var i = 0; i < coinList.count; i++) {
            if (coinList.get(i).name === coin) {
                logo = coinList.get(i).logoBig
            }
        }
        return logo
    }

    function getName(coin) {
        var name = ""
        for(var i = 0; i < coinList.count; i++) {
            if (coinList.get(i).coinID === coin) {
                name = coinList.get(i).name
            }
        }
        return name
    }

    function getFullName(coin) {
        var name = ""
        for(var i = 0; i < coinList.count; i++) {
            if (coinList.get(i).coinID === coin) {
                name = coinList.get(i).fullname
            }
        }
        return name
    }

    function getPercentage(coin) {
        var percentage = 0
        for(var i = 0; i < coinList.count; i++) {
            if (coinList.get(i).name === coin) {
                percentage = coinList.get(i).percentage
            }
        }
        return percentage
    }

    function getValue(coin) {
        var value = 0
        for(var i = 0; i < coinList.count; i++) {
            if (coinList.get(i).name === coin) {
                value = coinList.get(i).coinValueBTC
            }
        }
        return value
    }

    function getAddress(coin, label) {
        var address = ""
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coin) {
                if (walletList.get(i).label === label) {
                    address = walletList.get(i).address
                }
            }
        }
        return address
    }

    function getWalletNR(coin, label) {
        var walletID = ""
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coin) {
                if (walletList.get(i).label === label) {
                    walletID = walletList.get(i).walletNR
                }
            }
        }
        return walletID
    }

    function getLabelAddress(coin, address) {
        var label = ""
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coin) {
                if (walletList.get(i).address === address) {
                    label = walletList.get(i).label
                }
            }
        }
        return label
    }

    function defaultWallet(coin) {
        var balance = 0
        var wallet = 0
        var favorite = false
        for(var i = 0; i < walletList.count; i++){
            if (walletList.get(i).name === coin){
                if (favorite == false) {
                    if (walletList.get(i).favorite === true){
                        balance = walletList.get(i).balance
                        wallet = walletList.get(i).walletNR
                        favorite = true
                    }
                    else {
                        if (walletList.get(i).balance > balance && walletList.get(i).viewOnly === false){
                            balance = walletList.get(i).balance
                            wallet = walletList.get(i).walletNR
                        }
                    }
                }
                else {
                    if (walletList.get(i).favorite === true){
                        if (walletList.get(i).balance > balance){
                            balance = walletList.get(i).balance
                            wallet = walletList.get(i).walletNR
                        }
                    }
                }
            }
        }
        return wallet
    }

    function coinListLines(active) {
        totalLines = 0
        for(var i = 0; i < coinList.count; i++) {
            if (active === false) {
                totalLines += 1
            }
            else if (active === true) {
                if (coinList.get(i).active === true) {
                    totalLines += 1
                }
            }
        }
        return totalLines
    }

    function getAddressIndex(id) {
        for(var i = 0; i < addressList.count; i ++) {
            if (addressList.get(i).uniqueNR === id) {
                addressIndex = addresList.get(i)
            }
        }
    }

    function getContactIndex(id) {
        for(var i = 0; i < contactsList.count; i ++) {
            if (contactsList.get(i).contactNR === id) {
                contactIndex = contactsList.get(i)
            }
        }
    }

    function getWalletIndex(id) {
        for(var i = 0; i < walletList.count; i ++) {
            if (walletList.get(i).walletNR === id) {
                walletIndex = walletList.get(i)
            }
        }
    }

    function getCoinIndex(id) {
        for(var i = 0; i < coinList.count; i ++) {
            if (coinList.get(i).coinID === id) {
                coinIndex = coinList.get(i)
            }
        }
    }

    Connections {
        target: marketValue

        onMarketValueChanged: {
            setMarketValue(currency, currencyValue)
        }
    }
    // Start up functions
    function setMarketValue(currency, currencyValue) {
        var currencyVal =  Number.fromLocaleString(Qt.locale("en_US"),currencyValue)
        if (currency === "btcusd"){
            valueBTCUSD = currencyVal;
        }else if(currency === "btceur"){
            valueBTCEUR = currencyVal;
        }else if(currency === "btcgbp"){
            valueBTCGBP = currencyVal;
        }else if(currency === "xbybtc"){
            btcValueXBY = currencyVal;
            btcValueXFUEL = currencyVal
        }else if(currency === "xbycha"){
            percentageXBY = currencyVal;
            percentageXFUEL = currencyVal;
        }

        console.log("Currency: " + currency + " And value is: " + currencyVal);
    }

    function loadLocalWallets() {
        // create walletList from local storage when XCITE starts up
    }

    function loadWalletList(wallets) {
        // create walletList from account storage when XCITE starts up
    }

    function loadContactList(contacts) {
        if (typeof contacts !== "undefined") {
            contactList.clear();
            var obj = JSON.parse(contacts);
            for (var i in obj){
                var data = obj[i];
                contactList.append(data);
            }
        }
        else {
            console.log("no contacts saved in account")
        }
    }

    function loadAddressList(addresses) {
        if (typeof addresses !== "undefined") {
            addressList.clear();
            var obj = JSON.parse(addresses);
            for (var i in obj){
                var data = obj[i];
                addressList.append(data);
            }
        }
        else {
            console.log("no addresses saved in account")
        }
    }

    function loadSettings(settingsLoaded) {
        if (typeof settingsLoaded !== "undefined") {
            userSettings.accountCreationCompleted = settingsLoaded.accountCreationCompleted === "true";
            userSettings.defaultCurrency = settingsLoaded.defaultCurrency;
            userSettings.locale = settingsLoaded.locale;
            userSettings.pinlock =  settingsLoaded.pinlock === "true";

            userSettings.theme = settingsLoaded.theme;
        }
        else {
            console.log("no settings saved in account")
        }
    }

    function clearSettings(){
        userSettings.accountCreationCompleted = false;
        userSettings.defaultCurrency = 0;
        userSettings.theme = "dark";
        userSettings.pinlock = false;
        userSettings.locale = "en_us"
        userSettings.localKeys = false;
    }

    function loadHistoryList() {
        // read transactionhistory from persistent data
    }

    // loggin out
    function logOut () {
        interactionTracker = 0
        loginTracker = 0
        logoutTracker = 0
        addWalletTracker = 0
        createWalletTracker = 0
        appsTracker = 0
        coinTracker = 0
        walletTracker = 0
        transferTracker = 0
        historyTracker = 0
        addressTracker = 0
        contactTracker = 0
        addAddressTracker = 0
        addCoinTracker = 0
        addContactTracker = 0
        editContactTracker = 0
        coinListTracker = 0
        walletListTracker = 0
        addressbookTracker = 0
        scanQRTracker = 0
        tradingTracker = 0
        balanceTracker = 0
        calculatorTracker = 0
        addressQRTracker = 0
        pictureTracker = 0
        cellTracker = 0
        currencyTracker = 0
        pincodeTracker = 0
        debugTracker = 0
        contactID = 0
        addressID = 1
        walletID = 1
        txID = 1
        pictureID = 0
        currencyID = 0
        coinIndex = 0
        walletIndex = 1
        saveAppSettings()
        addressList.clear()
        contactList.clear()
        walletList.clear()
        clearAllSettings()

        Qt.quit()
    }

    // check for user interaction
    function detectInteraction() {
        if (interactionTracker == 0) {
            interactionTracker = 1
        }
    }

    function addWalletsToAddressList() {
        for(var i = 0; i < walletList.count; i++){
            if (walletList.get(i).remove === false) {
                addressList.append({"contact": 0, "label": getLabelAddress(walletList.get(i).name, walletList.get(i).address), "address": walletList.get(i).address, "logo": getLogo(walletList.get(i).name), "coin": walletList.get(i).name, "favorite": 1, "active": walletList.get(i).active, "uniqueNR": addressID, "remove": false});
                addressID = addressID + 1
            }
        }
    }

    function addOwnContact() {
        contactList.setProperty(0, "firstName", "My addresses");
        contactList.setProperty(0, "lastName", "");
        contactList.setProperty(0, "photo", profilePictures.get(0).photo);
        contactList.setProperty(0, "telNR", "");
        contactList.setProperty(0, "cellNR", "");
        contactList.setProperty(0, "mailAddress", "");
        contactList.setProperty(0, "chatID", "");
        contactList.setProperty(0, "favorite", true);
        contactList.setProperty(0, "contactNR", contactID);
        contactList.setProperty(0, "remove", false);
        contactID = contactID + 1
    }

    // Listmodels
    ListModel {
        id: addressList
        ListElement {
            contact: 0
            label: ""
            address: ""
            logo: ''
            coin: ""
            active: false
            favorite: 0
            uniqueNR: 0
            remove: true
        }
    }

    ListModel {
        id: contactList
        ListElement {
            firstName: ""
            lastName: ""
            photo: 'qrc:/icons/icon-profile_01.svg'
            telNR: ""
            cellNR: ""
            mailAddress: ""
            chatID: ""
            favorite: false
            contactNR: 0
            remove: true
        }
    }

    ListModel {
        id: walletList
        ListElement {
            name: ""
            label: ""
            address: ""
            balance: 0
            unconfirmedCoins: 0
            // whatever other walletrelated info needed to make payments
            active: false
            favorite: false
            viewOnly: false
            walletNR: 0
            remove: true
        }
    }

    ListModel {
        id: coinList
        ListElement {
            name: ""
            fullname: ""
            logo: ''
            logoBig: ''
            coinValueBTC: 0
            fiatValue: 0
            percentage: 0
            totalBalance: 0
            active: false
            coinID: 0
        }
    }

    ListModel {
        id: transactionList
        ListElement {
            coinName: ""
            walletLabel: ""
            date: ""
            amount: 0
            txPartner: ""
            reference: ""
            txid: 0
            txNR: 0
        }
    }

    ListModel {
        id: profilePictures
        ListElement {
            photo: ''
            pictureNR: 0
        }
    }

    ListModel {
        id: fiatCurrencies
        ListElement {
            currency: ""
            ticker: ""
            currencyNR: 0
        }
    }

    ListModel {
        id: notificationList
        ListElement {
            date: ""
            message: ""
            origin: ""
        }
    }

    // Global components
    Clipboard {
        id: clipboard
    }

    Settings {
        id: userSettings
        property string locale
        property int defaultCurrency
        property string theme
        property bool pinlock
        property bool accountCreationCompleted
        property bool localKeys

        onThemeChanged: {
            darktheme = userSettings.theme == "dark"? true : false
        }
    }

    // Global fonts
    FontLoader {
        id: xciteMobile
        name: "Brandon Grotesque"
    }

    FontLoader {
        id: xciteMobileSource
        source: 'qrc:/fonts/Brandon_reg.otf'
    }

    Network {
        id: network
        handler: wallet
    }

    SoundEffect {
        id: click01
        source: "qrc:/sounds/click_02.wav"
        volume: 0.15
    }
    Timer {
        id: marketValueTimer
        interval: 60000
        repeat: true
        running: sessionStart == 1
        onTriggered:  {
            console.log("callingMarketValue");
            marketValueChangedSignal("btcusd")
            marketValueChangedSignal("btceur")
            marketValueChangedSignal("btcgbp")
            marketValueChangedSignal("xbybtc")
            marketValueChangedSignal("xbycha")

        }
    }

    Timer {
        id: loginTimer
        interval: 30000
        repeat: true
        running: sessionStart == 1

        onTriggered: {
            if (interactionTracker == 1) {
                sessionTime = 0
                interactionTracker = 0
                // reset timer on serverside
            }
            else {
                sessionTime = sessionTime +1
                console.log("Time until automatic log out: " +  (5 - (sessionTime / 2)) + " minute(s)")
                if (sessionTime >= 10){
                    sessionTime = 0
                    sessionStart = 0
                    // show pop up that you will be logged out if you do not interact
                    autoLogout = 1
                    logoutTracker = 1
                }
            }
        }
    }

    Timer {
        id: networkTimer
        interval: 30000
        repeat: true
        running: sessionStart == 1

        onTriggered: {
            // check if there is a connection to the accounts server and if the session is still open

            // if connection is available -> networkAvailable = 0
            // if connection is not available -> networkAvailable = networkAvailable + 1
            // if networkAvailable >= 4 -> networkLogout = 1 && logoutTracker = 1
            if (sessionClosed == 1) {
                sessionStart = 0
                sessionClosed = 1
                logoutTracker = 1
            }
        }
    }

    Timer {
        id: requestTimer
        interval: 5000
        repeat: true
        running: sessionStart == 1

        onTriggered: {
            if (requestedLogout == 1 && transferTracker == 0 && addAddressTracker == 0 && addContactTracker == 0 && addressTracker == 0 && editContactTracker == 0 && appsTracker == 0) {
                logoutTracker = 1
            }
        }
    }

    // simulated logout request
    Timer {
        id: requestLogoutTimer
        interval: 150000
        repeat: false
        running: sessionStart == 1

        onTriggered: {
            console.log("log out request sent!")
            requestedLogout = 1
        }
    }

    // simulated session closed by server
    Timer {
        id: sessionClosedTimer
        interval: 300000
        repeat: false
        running: sessionStart == 1

        onTriggered: {
            console.log("Session closed by server")
            sessionClosed = 1
        }
    }

    Timer {
        id: timer
        interval: 15000
        repeat: true
        running: sessionStart == 1

        onTriggered: {
            // retrieve balance from blockexplorer
            // retrieve coinvalue from CMC
            sumBalance()
        }
    }
    // Order of the pages
    StackView {
        id: mainRoot
        initialItem: "../main.qml"
        anchors.fill: parent
    }

    onClosing: {
        if (mainRoot.depth > 1) {
            close.accepted = false
        }
    }
}
