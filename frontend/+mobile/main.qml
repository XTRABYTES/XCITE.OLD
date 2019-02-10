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
    property real valueBTCUSD: 3353.20 // replace by function to retrieve from CMC or equivalent
    property real valueBTCEUR: 2966.10 // replace by function to retrieve from CMC or equivalent
    property real valueBTCGBP: 2597.53 // replace by function to retrieve from CMC or equivalent
    property real valueBTC: userSettings.defaultCurrency == 0? valueBTCUSD : userSettings.defaultCurrency == 1? valueBTCEUR : valueBTCGBP

    // Coin info, retrieved from server
    property string nameXBY: "XBY"
    property real btcValueXBY: 0.00000445 // replace by function to retrieve from server
    property real valueXBY: btcValueXBY * valueBTC
    property real percentageXBY: 23.47 // replace by function to retrieve from server

    property string nameXFUEL: "XFUEL"
    property real btcValueXFUEL: btcValueXBY // replace by function to retrieve from server
    property real valueXFUEL: btcValueXFUEL * valueBTC
    property real percentageXFUEL: 23.47 // replace by function to retrieve from server

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
    property int loginTracker: 0
    property int addWalletTracker: 0
    property int createWalletTracker: 0
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

    // Global variables
    property int networkError: 0
    property int photoSelect: 0
    property int newCoinPicklist: 0
    property int newCoinSelect: 0
    property int newWalletPicklist: 0
    property int newWalletSelect: 0
    property int switchState: 0
    property string scannedAddress: ""
    property string selectedAddress: ""
    property string currentAddress: ""
    property var calculatedAmount: ""
    property string scanning: "scanning..."
    property string addressbookName: ""
    property string addressbookHash: ""
    property int addressIndex: 0
    property int contactIndex: 0
    property int walletIndex: 0
    property int coinIndex: 0
    property int pictureIndex: 0
    property int totalLines: 4
    property int totalAddresses: countAddresses()
    property int totalWallets: countWallets()
    property int totalCoinWallets: 0
    property real totalBalance: 0
    property int contactID: 0
    property int addressID: 1
    property int walletID: 0
    property int txID: 1
    property int selectAddressIndex: 0
    property int pictureID: 0
    property int currencyID: 0
    property int createPin: 0
    property int changePin: 0
    property int unlockPin: 0
    property int pinOK: 0
    property int pinError: 0
    property int requestSend: 0

    // Signals
    signal loginSuccesfulSignal(string username, string password)
    signal loginFailed()
    signal marketValueChangedSignal(string currency)
    signal localeChange(string locale)
    signal userLogin(string username, string password)
    signal createUser(string username, string password)
    signal userExists(string username)
    //signal userAvailable()
    signal clearAllSettings
    signal saveAddressBook(var addresses)
    signal savePincode(string pincode)
    signal checkPincode(string pincode)

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
                        if (walletList.get(i).balance > balance){
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

    // Start up functions
    function onMarketValueChanged(currency) {
        marketValueChangedSignal(currency)
    }

    function loadWalletList() {
        // create walletList when XCITE starts up
    }

    function loadContactList() {
        // read contacts from persistent data
    }

    function loadAddressList() {
        // read addresses from persistent data
    }

    function loadHistoryList() {
        // read transactionhistory from persistent data
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
            cellNr: ""
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

    // Order of the pages
    StackView {
        id: mainRoot
        initialItem: "../main.qml"
        anchors.fill: parent
    }

    Component.onCompleted: {

        mainRoot.push("../Onboarding.qml")

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
        fiatCurrencies.setProperty(0, "currencyNR", currencyID);
        currencyID = currencyID + 1
        fiatCurrencies.append({"currency": "EUR", "ticker": "€", "currencyNR": currencyID});
        currencyID = currencyID + 1
        fiatCurrencies.append({"currency": "GBP", "ticker": "£", "currencyNR": currencyID});
        currencyID = currencyID + 1

        coinList.setProperty(0, "name", nameXFUEL);
        coinList.setProperty(0, "fullname", "XFUEL");
        coinList.setProperty(0, "logo", 'qrc:/icons/XFUEL_card_logo_01.svg');
        coinList.setProperty(0, "logoBig", 'qrc:/icons/XFUEL_logo_big.svg');
        coinList.setProperty(0, "coinValueBTC", btcValueXFUEL);
        coinList.setProperty(0, "percentage", percentageXFUEL);
        coinList.setProperty(0, "totalBalance", 0);
        coinList.setProperty(0, "active", true);
        coinList.setProperty(0, "coinID", coinIndex);
        coinIndex = coinIndex +1;
        coinList.append({"name": nameXBY, "fullname": "XTRABYTES", "logo": 'qrc:/icons/XBY_card_logo_01.svg', "logoBig": 'qrc:/icons/XBY_logo_big.svg', "coinValueBTC": btcValueXBY, "percentage": percentageXBY, "totalBalance": 0, "active": true, "coinID": coinIndex});
        coinIndex = coinIndex +1;
    }

    // Global components
    Clipboard {
        id: clipboard
    }

    Settings {
        id: userSettings
        property string locale: "en_us"
        property int defaultCurrency: 0
        property string theme: "dark"
        property bool pinlock: false
        property bool accountCreationCompleted: false

        //update settings
            //onLocaleChanged: ...
            //onDefaultCurrencyChanged: ...
            //onThemeChanged: ...
            //onPinlockChanged: ...
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
}
