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
    color: "#2A2C31"

    MediaPlayer {
        id: introSound
        source: "qrc:/sounds/intro_01.wav"
        volume: 1
        autoPlay: true
    }

    Image {
        id: xbyLogo
        source: 'qrc:/logos/xby_logo_tm.png'
        width: Screen.width - 100
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -50
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Component.onCompleted: {
        goodbey = 0
        standBy = 0

        contactID = 1
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
        //fiatCurrencies.append({"currency": "BTC", "ticker": "₿", "currencyNR": 3});

        soundList.setProperty(0, "name", "Bonjour");
        soundList.setProperty(0, "sound", 'qrc:/sounds/Bonjour.wav')
        soundList.setProperty(0, "soundNR", 0)
        soundList.append({"name": "Hello", "sound": 'qrc:/sounds/Hello.wav', "soundNR": 1});
        soundList.append({"name": "Hola", "sound": 'qrc:/sounds/hola.wav', "soundNR": 2});
        soundList.append({"name": "Servus", "sound": 'qrc:/sounds/Servus.wav', "soundNR": 3});
        soundList.append({"name": "Szia", "sound": 'qrc:/sounds/Szia.wav', "soundNR": 4});

        coinList.setProperty(0, "name", nameXFUEL);
        coinList.setProperty(0, "fullname", "xfuel");
        coinList.setProperty(0, "logo", 'qrc:/icons/XFUEL_card_logo_01.svg');
        coinList.setProperty(0, "logoBig", 'qrc:/icons/XFUEL_logo_big.svg');
        coinList.setProperty(0, "coinValueBTC", btcValueXFUEL);
        coinList.setProperty(0, "percentage", percentageXFUEL);
        coinList.setProperty(0, "totalBalance", 0);
        coinList.setProperty(0, "active", true);
        coinList.setProperty(0, "testnet", false );
        coinList.setProperty(0, "xby", 1);
        coinList.setProperty(0, "coinID", 0);
        coinList.append({"name": nameXBY, "fullname": "xtrabytes", "logo": 'qrc:/icons/XBY_card_logo_01.svg', "logoBig": 'qrc:/icons/XBY_logo_big.svg', "coinValueBTC": btcValueXBY, "percentage": percentageXBY, "totalBalance": 0, "active": true, "testnet" : false, "xby": 1,"coinID": 1});
        coinList.append({"name": "XTEST", "fullname": "testnet", "logo": 'qrc:/icons/TESTNET_card_logo_01.svg', "logoBig": 'qrc:/icons/TESTNET_logo_big.svg', "coinValueBTC": 0, "percentage": 0, "totalBalance": 0, "active": true, "testnet" : true, "xby": 1,"coinID": 2});
        coinList.append({"name": "BTC", "fullname": "bitcoin", "logo": 'qrc:/icons/BTC_card_logo_01.svg', "logoBig": 'qrc:/icons/BTC_logo_big.svg', "coinValueBTC": btcValueBTC, "percentage": percentageBTC, "totalBalance": 0, "active": true, "testnet" : false, "xby": 0,"coinID": 3});
        coinList.append({"name": "ETH", "fullname": "ethereum", "logo": 'qrc:/icons/ETH_card_logo_01.svg', "logoBig": 'qrc:/icons/ETH_logo_big.svg', "coinValueBTC": btcValueETH, "percentage": percentageETH, "totalBalance": 0, "active": true, "testnet" : false, "xby": 0,"coinID": 4});

        txStatusList.setProperty(0, "type", "confirmed");
        txStatusList.append({"type": "pending"});

        marketValueChangedSignal("btcusd");
        marketValueChangedSignal("btceur");
        marketValueChangedSignal("btcgbp");
        marketValueChangedSignal("xbybtc");
        marketValueChangedSignal("xbycha");
        marketValueChangedSignal("xflbtc");
        marketValueChangedSignal("xflcha");
        marketValueChangedSignal("btccha");
        marketValueChangedSignal("ethbtc");
        marketValueChangedSignal("ethcha");

        selectedPage = "onBoarding"
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

    onValueBTCChanged: {
        coinList.setProperty(3, "fiatValue", valueBTC);
    }

    onPercentageBTCChanged: {
        coinList.setProperty(3, "percentage", percentageBTC);
    }

    onBtcValueETHChanged: {
        coinList.setProperty(4, "coinValueBTC", btcValueETH);
        coinList.setProperty(4, "fiatValue", btcValueETH * valueBTC);
    }
    onPercentageETHChanged: {
        coinList.setProperty(4, "percentage", percentageETH);
    }

    onGoodbeyChanged: {
        if(goodbey == 1) {
            outroSound.play()
        }
    }

    // BTC information
    property real btcValueBTC: 1
    property real valueBTCUSD
    property real valueBTCEUR
    property real valueBTCGBP
    property real valueBTC: userSettings.defaultCurrency == 0? valueBTCUSD : userSettings.defaultCurrency == 1? valueBTCEUR : userSettings.defaultCurrency == 2? valueBTCGBP : btcValueBTC
    property real percentageBTC

    // Coin info
    property string nameXBY: "XBY"
    property real btcValueXBY
    property real valueXBY: btcValueXBY * valueBTC
    property real percentageXBY

    property string nameXFUEL: "XFUEL"
    property real btcValueXFUEL
    property real valueXFUEL: btcValueXFUEL * valueBTC
    property real percentageXFUEL

    property real btcValueETH
    property real valueETH: btcValueETH * valueBTC
    property real percentageETH

    // Global theme settings, non-editable
    property color maincolor: "#0ED8D2"
    property color themecolor: darktheme == true? "#F2F2F2" : "#2A2C31"
    property color bgcolor: darktheme == true? "#14161B" : "#FDFDFD"
    property real doubbleButtonWidth: Screen.width - 56
    property string myOS: "android"

    // Global setting, editable
    property bool darktheme: userSettings.theme == "dark"? true : false
    property string fiatTicker: fiatCurrencies.get(userSettings.defaultCurrency).ticker
    property string username: ""
    property string selectedPage: ""

    // Trackers
    property int interactionTracker: 0
    property int loginTracker: 0
    property int importTracker: 0
    property int logoutTracker: 0
    property int addWalletTracker: 0
    property int createWalletTracker: 0
    property int viewOnlyTracker: 0
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
    property int backupTracker: 0
    property int screenshotTracker: 0
    property int walletDetailTracker: 0
    property int portfolioTracker: 0
    property int transactionDetailTracker: 0
    property int soundTracker: 0
    property int changePasswordTracker: 0

    // Global variables
    property int sessionStart: 0
    property int sessionTime: 0
    property int sessionClosed: 0
    property int standBy: 0
    property int screenSaver: 0
    property int autoLogout: 0
    property int manualLogout: 0
    property int networkLogout: 0
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
    property string scannedAddress: ""
    property string selectedAddress: ""
    property string currentAddress: ""
    property var calculatedAmount: ""
    property string scanningKey: ""
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
    property int contactID: 1
    property int addressID: 1
    property int walletID: 1
    property int txID: 1
    property int selectAddressIndex: 0
    property int pictureID: 0
    property int currencyID: 0
    property int createPin: 0
    property int changePin: 0
    property int unlockPin: 0
    property bool pinClearInitiated: false
    property int clearAll: 0
    property int pinOK: 0
    property int pinError: 0
    property int requestSend: 0
    property bool newAccount: false
    property real changeBalance: 0
    property string notificationDate: ""
    property bool walletAdded: false
    property bool alert: false
    property bool testNet: false
    property bool saveCurrency: false
    property int oldCurrency: 0
    property int currencyChangeFailed: 0
    property string oldLocale: ""
    property int oldDefaultCurrency: 0
    property string oldTheme: ""
    property bool oldPinlock: false
    property bool oldLocalKeys: false
    property string selectedCoin: "XFUEL"
    property real totalXBY: 0
    property real totalXFUEL: 0
    property real totalXBYTest: 0
    property real totalXFUELTest: 0
    property real totalBTC: 0
    property real totalETH: 0
    property real totalXBYFiat: totalXBY * valueXBY
    property real totalXFUELFiat: totalXFUEL * valueXFUEL
    property real totalBTCFiat: totalBTC * valueBTC
    property real totalETHFiat: totalETH * valueETH
    property string historyCoin: ""
    property int transactionPages: 0
    property int currentPage: 0
    property string transactionNR: ""
    property string transactionTimestamp: ""
    property bool transactionDirection: false
    property real transactionAmount: 0
    property string transactionConfirmations: ""
    property bool saveSound: false
    property int oldSound: 0
    property int oldVolume: 1
    property int soundChangeFailed: 0
    property int volumeChangeFailed: 0
    property int selectedSound: userSettings.sound
    property int selectedVolume: userSettings.volume
    property int oldSystemVolume: 1
    property int systemVolumeChangeFailed: 0
    property int selectedSystemVolume: userSettings.systemVolume
    property int copy2clipboard: 0
    property string address2Copy: ""
    property string txid2Copy: ""
    property bool closeAllClipboard: false
    property bool cameraPermission: true
    property string statusList: ""
    property bool explorerBusy: false
    property int explorerPopup: 0
    property string balanceCheck: "all"
    property int timerCount: 0
    property real pendingXBY: 0
    property real pendingXFUEL: 0
    property real pendingXTEST: 0
    property real pendingBTC: 0
    property real pendingETH: 0

    // Signals
    signal checkOS()
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
    signal saveWalletList(string walletlist, string addresses)
    signal importAccount(string username, string password)
    signal exportAccount(string walletlist)
    signal updateBalanceSignal(string walletlist, string wallets)
    signal createKeyPair(string network)
    signal importPrivateKey(string network, string privKey)
    signal helpMe()
    signal setNetwork(string network)
    signal testTransaction(string test)
    signal updateAccount(string addresslist, string contactlist, string walletlist, string pendinglist)
    signal updateTransactions(string coin, string address, string page)
    signal checkSessionId()
    signal getDetails(string coin, string transaction)
    signal initialisePincode(string pincode)
    signal savePincode(string pincode)
    signal checkPincode(string pincode)
    signal walletUpdate(string coin, string label, string message)
    signal copyText2Clipboard(string text)
    signal sendCoins(string message)
    signal checkCamera()
    signal checkTxStatus(string pendinglist)
    signal changePassword(string oldPassword, string newPassword)

    // functions
    function updateBalance(coin, address, balance) {
        var balanceAlert
        var difference
        var newBalance
        changeBalance = 0

        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coin) {
                if (walletList.get(i).address === address) {
                    newBalance = parseFloat(balance);
                    if (!isNaN(newBalance)){
                        if (newBalance !== walletList.get(i).balance) {

                            changeBalance = newBalance - walletList.get(i).balance
                            if (changeBalance > 0) {
                                difference = "increased"
                            }
                            else {
                                difference = "decreased"
                            }

                            walletList.setProperty(i, "balance", newBalance)
                            balanceAlert = "Your balance has " + difference + " with:<br><b>" + changeBalance + "</b>" + " " + (walletList.get(i).name)
                            alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : balanceAlert, "origin" : (walletList.get(i).name + " " + walletList.get(i).label)})
                            alert = true
                            if (standBy == 1) {
                                walletUpdate(walletList.get(i).name, walletList.get(i).label, balanceAlert)
                            }
                            notification.play()
                            sumBalance()
                            sumXBY()
                            sumXFUEL()
                            sumXTest()
                            sumBTC()
                            sumETH()
                        }
                    }
                }
            }
        }
    }

    function updatePending(coin, address, txid, result) {
        console.log("updating pending list")
        console.log("checking transaction: " + coin + ", " + address + ", " + txid + ", " + result)
        for (var i = 0; i < pendingList.count; ++i){
            if(pendingList.get(i).coin === coin) {
                if(pendingList.get(i).address === address) {
                    if(pendingList.get(i).txid === txid) {
                        if(result === "true") {
                            console.log("remove pending transaction")
                            pendingList.remove(i)
                        }
                    }
                }
            }
        }
    }

    function pendingUnconfirmed(coin, address, txid, result) {
        for (var i = 0; i < pendingList.count; ++i){
            if(pendingList.get(i).coin === coin) {
                if(pendingList.get(i).address === address) {
                    if(pendingList.get(i).txid === txid) {
                        if(pendingList.get(i).check >= 40) {
                            console.log("pending transaction canceled")
                            console.log("canceled transaction: " + coin + ", " + address + ", " + txid)
                            var addressname = getLabelAddress(coin, address)
                            var cancelAlert = "transaction canceled: " + txid
                            alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : cancelAlert, "origin" : coin + " " + addressname})
                            alert = true
                            updatePending(coin, address, txid, "true")
                        }
                    }
                }
            }
        }
    }

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
            if (walletList.get(i).active === true && walletList.get(i).include === true && walletList.get(i).remove === false) {
                if (walletList.get(i).name === "XBY") {
                    totalBalance += (walletList.get(i).balance * btcValueXBY * valueBTC)
                }
                else if (walletList.get(i).name === "XFUEL") {
                    totalBalance += (walletList.get(i).balance * btcValueXFUEL * valueBTC)
                }
                else if (walletList.get(i).name === "BTC") {
                    totalBalance += (walletList.get(i).balance * valueBTC)
                }
                else if (walletList.get(i).name === "ETH") {
                    totalBalance += (walletList.get(i).balance * btcValueETH * valueBTC)
                }
            }
        }
        return totalBalance
    }

    function pendingCoins(coin, address) {
        var pending = 0
        for (var i = 0; i < pendingList.count; i++) {
            if (pendingList.get(i).coin === coin && pendingList.get(i).address === address) {
                pending += pendingList.get(i).amount
            }
        }
        return pending
    }

    function sumXBY() {
        totalXBY =0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === "XBY" && walletList.get(i).include === true && walletList.get(i).remove === false) {
                totalXBY += walletList.get(i).balance
            }
        }
        return totalXBY
    }

    function sumXFUEL() {
        totalXFUEL = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === "XFUEL" && walletList.get(i).include === true && walletList.get(i).remove === false) {
                totalXFUEL += walletList.get(i).balance
            }
        }
        return totalXFUEL
    }

    function sumXTest() {
        totalXFUELTest = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === "XTEST" && walletList.get(i).include === true && walletList.get(i).remove === false) {
                totalXFUELTest += walletList.get(i).balance
            }
        }
        return totalXFUELTest
    }

    function sumBTC() {
        totalBTC = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === "BTC" && walletList.get(i).include === true && walletList.get(i).remove === false) {
                totalBTC += walletList.get(i).balance
            }
        }
        return totalBTC
    }

    function sumETH() {
        totalETH = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === "ETH" && walletList.get(i).include === true && walletList.get(i).remove === false) {
                totalETH += walletList.get(i).balance
            }
        }
        return totalXFUEL
    }

    function sumCoinTotal(coin) {
        var coinTotal = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coin && walletList.get(i).include === true && walletList.get(i).remove === false) {
                coinTotal += walletList.get(i).balance
            }
        }
        return coinTotal
    }

    function sumCoinUnconfirmed(coin) {
        var unconfirmedTotal = 0
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coin && walletList.get(i).include === true && walletList.get(i).remove === false) {
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

    function getTestnet(coin) {
        testNet = false
        for(var i = 0; i < coinList.count; i++) {
            if (coinList.get(i).name === coin) {
                testNet = coinList.get(i).testnet
            }
        }
        return testNet
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

    function getPrivKey(coin, label) {
        var privKey = ""
        for(var i = 0; i < walletList.count; i++) {
            if (walletList.get(i).name === coin) {
                if (walletList.get(i).label === label) {
                    privKey = walletList.get(i).privatekey
                }
            }
        }
        return privKey
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

    function getCoinNR(coin) {
        selectedCoin = 0
        for (var i = 0; coinList.count; i++) {
            if (coinList.get(i).name === coin) {
                selectedCoin= coinList.get(i).coinID
            }
        }
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
                        else if (wallet == 0) {
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
                addressIndex = addressList.get(i)
            }
        }
    }

    function getContactIndex(id) {
        for(var i = 0; i < contactsList.count; i ++) {
            if (contactList.get(i).contactNR === id) {
                contactIndex = contactList.get(i)
            }
        }
    }

    function replaceName(id, first, last) {
        for(var i = 0; i < addressList.count; i ++) {
            if (addressList.get(i).contact === id) {
                contactList.setProperty(id, "fullname", last+first)
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

    function checkNotifications() {
        if (alertList.count > 1) {
            alert = true
        }
        else {
            alert = false
        }
    }

    function setMarketValue(currency, currencyValue) {
        if (!isNaN(currencyValue) && currencyValue !== "") {
            var currencyVal =  Number.fromLocaleString(Qt.locale("en_US"),currencyValue)
            if (currency === "btcusd"){
                valueBTCUSD = Number.fromLocaleString(Qt.locale("en_US"),currencyVal);
            }
            else if(currency === "btceur"){
                valueBTCEUR = Number.fromLocaleString(Qt.locale("en_US"),currencyVal);
            }
            else if(currency === "btcgbp"){
                valueBTCGBP = Number.fromLocaleString(Qt.locale("en_US"),currencyVal);
            }
            else if(currency === "xbybtc"){
                btcValueXBY = Number.fromLocaleString(Qt.locale("en_US"),currencyVal);
            }
            else if(currency === "xbycha"){
                percentageXBY = Number.fromLocaleString(Qt.locale("en_US"),currencyVal);
            }
            else if(currency === "xflbtc"){
                btcValueXFUEL = Number.fromLocaleString(Qt.locale("en_US"),currencyVal);
            }
            else if(currency === "xflcha"){
                percentageXFUEL = Number.fromLocaleString(Qt.locale("en_US"),currencyVal);
            }
            else if(currency === "btccha"){
                percentageBTC = Number.fromLocaleString(Qt.locale("en_US"),currencyVal);
            }
            else if(currency === "ethbtc"){
                btcValueETH = Number.fromLocaleString(Qt.locale("en_US"),currencyVal);
            }
            else if (currency === "ethcha"){
                percentageETH = Number.fromLocaleString(Qt.locale("en_US"),currencyVal);
            }
            sumBalance()
            sumXBY()
            sumXFUEL()
            sumXTest()
            sumBTC()
            sumETH()
        }
    }

    // Start up
    function loadContactList(contacts) {
        if (typeof contacts !== "undefined") {
            contactList.clear();
            var obj = JSON.parse(contacts);
            for (var i in obj){
                var data = obj[i];
                contactList.append(data);
            }
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
    }

    function loadWalletList(wallet) {
        if (typeof wallet !== "undefined") {
            walletList.clear();
            var obj = JSON.parse(wallet);
            for (var i in obj){
                var data = obj[i];
                walletList.append(data);
            }
        }
    }

    function loadPendingList(transactions) {
        if (typeof transactions !== "undefined") {
            pendingList.clear();
            var obj = JSON.parse(transactions);
            for (var i in obj){
                var data = obj[i];
                pendingList.append(data);
            }
        }
    }

    function loadSettings(settingsLoaded) {
        if (typeof settingsLoaded !== "undefined") {
            userSettings.accountCreationCompleted = settingsLoaded.accountCreationCompleted === "true";
            userSettings.defaultCurrency = settingsLoaded.defaultCurrency;
            userSettings.locale = settingsLoaded.locale;
            userSettings.pinlock = settingsLoaded.pinlock === "true";
            userSettings.theme = settingsLoaded.theme;
            userSettings.localKeys = settingsLoaded.localKeys === "true";
            userSettings.xby = settingsLoaded.xby === "true";
            userSettings.xfuel = settingsLoaded.xfuel === "true";
            userSettings.xtest = settingsLoaded.xtest === "true";
            userSettings.xby = settingsLoaded.btc === "true";
            userSettings.xfuel = settingsLoaded.eth === "true";
            userSettings.sound = settingsLoaded.sound;
            userSettings.volume = settingsLoaded.volume;
            userSettings.systemVolume = settingsLoaded.systemVolume;
            coinList.setProperty(0, "active", userSettings.xfuel);
            coinList.setProperty(1, "active", userSettings.xby);
            coinList.setProperty(2, "active", userSettings.xtest);
            coinList.setProperty(3, "active", userSettings.btc);
            coinList.setProperty(4, "active", userSettings.eth);
        }
    }

    function loadTransactions(transactions){
        if (typeof transactions !== "undifined") {
            historyList.clear();
            var obj = JSON.parse(transactions);
            for (var i in obj){
                var data = obj[i];
                historyList.append(data);
            }
        }
    }

    function loadTransactionAddresses(inputs, outputs){
        if (typeof inputs !== "undifined") {
            inputAddresses.clear();
            var objInput = JSON.parse(inputs);
            for (var i in objInput){
                var dataInput = objInput[i];
                inputAddresses.append(dataInput);
            }
        }
        if (typeof outputs !== "undifined") {
            outputAddresses.clear();
            var objOutput = JSON.parse(outputs);
            for (var e in objOutput){
                var dataOutput = objOutput[e];
                outputAddresses.append(dataOutput);
            }
        }
    }

    // export walletList
    function exportWallets(){
        var dataModelWallet = []

        for (var i = 0; i < walletList.count; ++i){
            dataModelWallet.push(walletList.get(i))
        }

        var walletListJson = JSON.stringify(dataModelWallet)

        exportAccount(walletListJson)
    }


    // edit account
    function updateToAccount(){
        var dataModelWallet = []
        var datamodelContact = []
        var datamodelAddress = []
        var datamodelPending = []

        for (var i = 0; i < walletList.count; ++i){
            dataModelWallet.push(walletList.get(i))
        }
        for (var e = 0; e < addressList.count; ++e){
            datamodelAddress.push(addressList.get(e))
        }
        for (var o = 0; o < contactList.count; ++o){
            datamodelContact.push(contactList.get(o))
        }
        for (var u = 0; u < pendingList.count; ++u){
            datamodelPending.push(pendingList.get(u))
        }

        var walletListJson = JSON.stringify(dataModelWallet)
        var addressListJson = JSON.stringify(datamodelAddress)
        var contactListJson = JSON.stringify(datamodelContact)
        var pendingListJson = JSON.stringify(datamodelPending)

        updateAccount(addressListJson, contactListJson, walletListJson, pendingListJson)
    }

    function editWalletInAddreslist(coin, address, label, remove) {
        for (var i = 0; i < addressList.count; i ++) {
            if (addressList.get(i).coin === coin && addressList.get(i).address === address) {
                addressList.setProperty(i, "label", label);
                addressList.setProperty(i, "remove", remove);
            }
        }
    }

    function deleteContactAddresses(contact) {
        for (var i = 0; i < addressList.count; i ++) {
            if (addressList.get(i).contact === contact) {
                addressList.setProperty(i, "remove", true);
            }
        }
    }

    function restoreContactAddresses(contact) {
        for (var i = 0; i < addressList.count; i ++) {
            if (addressList.get(i).contact === contact) {
                addressList.setProperty(i, "remove", false);
            }
        }
    }

    function clearAddressList() {
        for (var i = 0; i < addressList.count; i ++) {
            if (addressList.get(i).remove === true) {
                addressList.setProperty(i, "contact", 0);
                addressList.setProperty(i, "fullName", "");
                addressList.setProperty(i, "label", "");
                addressList.setProperty(i, "address", "");
                addressList.setProperty(i, "logo", '');
                addressList.setProperty(i, "coin", "");
                addressList.setProperty(i, "active", false);
                addressList.setProperty(i, "favorite", 0);
            }
        }
    }

    function clearContactList() {
        for (var i = 0; i < contactList.count; i ++) {
            if (contactList.get(i).remove === true) {
                contactList.setProperty(i, "firstName", "");
                contactList.setProperty(i, "lastName", "");
                contactList.setProperty(i, "photo", '');
                contactList.setProperty(i, "telNR", "");
                contactList.setProperty(i, "CellNR", "");
                contactList.setProperty(i, "mailAddress", "");
                contactList.setProperty(i, "chatID", "");
                contactList.setProperty(i, "favorite", false);
            }
        }
    }

    function clearWalletList() {
        for (var i = 0; i < walletList.count; i ++) {
            if (walletList.get(i).remove === true) {
                walletList.setProperty(i, "name", "");
                walletList.setProperty(i, "label", "");
                walletList.setProperty(i, "privatekey", "");
                walletList.setProperty(i, "publickey", "");
                walletList.setProperty(i, "address", "");
                walletList.setProperty(i, "balance", 0);
                walletList.setProperty(i, "unconfirmedCoins", 0);
                walletList.setProperty(i, "favorite", false);
                walletList.setProperty(i, "active", false);
                walletList.setProperty(i, "viewOnly", false);
                walletList.setProperty(i, "include", false);
            }
        }
    }

    function addWalletToList(coin, label, addr, pubkey, privkey, view){
        var favorite = true
        for(var o = 0; o < walletList.count; o ++) {
            if (favorite == true) {
                if (walletList.get(o).name === coin && walletList.get(o).favorite === true) {
                    favorite = false
                }
            }
        }
        walletList.append({"name": coin, "label": label, "address": addr, "privatekey" : privkey, "publickey" : pubkey ,"balance" : 0, "unconfirmedCoins": 0, "active": true, "favorite": favorite, "viewOnly" : view, "include" : true, "walletNR": walletID, "remove": false});
        walletID = walletID + 1
        addressList.append({"contact": 0, "fullname": "My addresses", "address": addr, "label": label, "logo": getLogo(coin), "coin": coin, "favorite": 0, "active": true, "uniqueNR": addressID, "remove": false});
        addressID = addressID +1;

        var dataModelWallet = []
        var datamodel = []

        for (var i = 0; i < walletList.count; ++i){
            dataModelWallet.push(walletList.get(i))
        }
        for (var e = 0; e < addressList.count; ++e){
            datamodel.push(addressList.get(e))
        }

        var walletListJson = JSON.stringify(dataModelWallet)
        var addressListJson = JSON.stringify(datamodel)

        saveWalletList(walletListJson, addressListJson)
    }

    // initialise
    function clearSettings(){
        userSettings.accountCreationCompleted = false;
        userSettings.defaultCurrency = 0;
        userSettings.theme = "dark";
        userSettings.pinlock = false;
        initialisePincode("0000");
        userSettings.locale = "en_us"
        userSettings.localKeys = false;
        userSettings.xby = true;
        userSettings.xfuel = true;
        userSettings.xtest = true;
        userSettings.btc = true;
        userSettings.eth = true;
        userSettings.sound = 0
        userSettings.volume = 1
        userSettings.systemVolume = 1
    }

    function initialiseLists() {
        addressList.append({"contact": 0, "address": "", "label": "", "logo": '', "coin": "", "favorite": 0, "active": false, "uniqueNR": 0, "remove": true})

        contactList.append({"firstName": "", "lastName": "", "photo": '', "telNR": "", "cellNR": "", "mailAddress": "", "chatID": "", "favorite": false, "active": false, "contactNR": 0, "remove": true})

        walletList.append({"name": "", "label": "", "address": "", "privatekey" : "", "publickey" : "" ,"balance" : 0, "unconfirmedCoins": 0, "active": false, "favorite": false, "viewOnly" : false, "walletNR": 0, "remove": true})

    }

    // loggin out
    function logOut () {
        updateToAccount()
    }

    // check for user interaction
    function detectInteraction() {
        if (interactionTracker == 0) {
            interactionTracker = 1
        }
    }

    // connections
    Connections {
        target: marketValue

        onMarketValueChanged: {
            setMarketValue(currency, currencyValue)
        }
    }

    Connections {
        target: UserSettings

        onSessionIdCheck: {
            if (sessionAlive === false && goodbey == 0 && manualLogout == 0 && autoLogout == 0) {
                networkLogout = 1
                logoutTracker = 1
                sessionStart = 0
                sessionClosed = 1
            }
        }

        onSaveSucceeded: {
            if (goodbey == 1) {
                Qt.quit()
            }
        }

        onSaveFailed: {
            if (goodbey == 1) {
                Qt.quit()
            }
        }

        onOSReturned: {
            myOS = os
        }

        onCameraCheckFailed: {
            cameraPermission = false
        }

        onCameraCheckPassed: {
            cameraPermission = true
        }
    }

    Connections {
        target: explorer

        onUpdateTransactionsDetails: {
            if (historyTracker == 1) {
                loadTransactionAddresses(inputs, outputs)
                transactionTimestamp = timestamp
                transactionConfirmations = confirmations
                transactionAmount = (Number.fromLocaleString(Qt.locale("en_US"),balance) )/ 100000000
                transactionDetailTracker = 1
            }
        }

        onUpdateBalance: {
            updateBalance(coin, address, balance)
        }

        onTxidExists: {
            pendingUnconfirmed(coin, address, txid, result)
        }

        onTxidConfirmed: {
            updatePending(coin, address, txid, result)
        }

        onTxidNotFound: {
            pendingUnconfirmed(coin, address, txid, result)
        }

        onExplorerBusy: {
            explorerBusy = true
        }

        onAllTxChecked: {
            explorerBusy = false
        }

        onDetailsCollected: {
            explorerBusy = false
        }
    }

    // Listmodels
    ListModel {
        id: addressList
        ListElement {
            contact: 0
            fullName: ""
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
            privatekey: ""
            publickey: ""
            balance: 0
            unconfirmedCoins: 0
            active: false
            favorite: false
            viewOnly: false
            include: false
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
            testnet: false
            xby: 0
            coinID: 0
        }
    }

    ListModel {
        id: pendingList
        ListElement {
            coin: ""
            address: ""
            txid: ""
            amount: 0
            value: ""
            check: 0
        }
    }

    ListModel {
        id: referenceList
        ListElement {
            coin: ""
            txid: ""
            reference: ""
        }
    }

    ListModel {
        id: txStatusList
        ListElement {
            type: ""
        }
    }

    ListModel {
        id: historyList
        ListElement {
            txid: ""
            direction: false
            value: ""
            confirmations: 0
            status: ""
        }
    }

    ListModel {
        id: inputAddresses
        ListElement {
            address: ""
            amount: ""
        }
    }

    ListModel {
        id: outputAddresses
        ListElement {
            address: ""
            amount: ""
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
        id: alertList
        ListElement {
            date: ""
            message: ""
            origin: ""
        }
    }

    ListModel {
        id: soundList
        ListElement {
            name: ""
            sound: 'qrc:/sounds/notification_1.wav'
            soundNR: 0
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
        property bool xby
        property bool xfuel
        property bool xtest
        property bool btc
        property bool eth
        property int sound: 0
        property int volume: 1
        property int systemVolume: 1

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

    // need to look into removing this
    Network {
        id: network
        handler: wallet
    }

    // sounds
    SoundEffect {
        id: click01
        source: "qrc:/sounds/click_02.wav"
        volume: selectedSystemVolume == 0? 0 : 0.15
    }

    SoundEffect {
        id: notification
        source: soundList.get(selectedSound).sound
        volume: selectedVolume == 0? 0 : (selectedVolume == 1? 0.15 : (selectedVolume == 2? 0.4 : 0.75))
    }

    SoundEffect {
        id: succesSound
        source: "qrc:/sounds/Success.wav"
        volume: 0.50
    }

    SoundEffect {
        id: failSound
        source: "qrc:/sounds/Fail.wav"
        volume: 0.50
    }

    SoundEffect {
        id: outroSound
        source: "qrc:/sounds/Outro.wav"
        volume: selectedSystemVolume == 0? 0 : 0.5
    }

    SoundEffect {
        id: swipe
        source: "qrc:/sounds/swipe_01.wav"
        volume: selectedSystemVolume == 0? 0 : 0.2
    }

    // timers
    Timer {
        repeat: false
        running: copy2clipboard
        interval: 2000

        onTriggered: copy2clipboard = 0
    }

    Timer {
        id: marketValueTimer
        interval: 60000
        repeat: true
        running: sessionStart == 1
        onTriggered:  {
            if (standBy == 0) {
                marketValueChangedSignal("btcusd")
                marketValueChangedSignal("btceur")
                marketValueChangedSignal("btcgbp")
                marketValueChangedSignal("xbybtc")
                marketValueChangedSignal("xbycha")
                marketValueChangedSignal("xflbtc")
                marketValueChangedSignal("xflcha")
                marketValueChangedSignal("btccha")
                marketValueChangedSignal("ethbtc")
                marketValueChangedSignal("ethcha")
            }
        }
    }

    Timer {
        id: explorerTimer1
        interval: 15000
        repeat: true
        running: sessionStart == 1
        onTriggered:  {
            timerCount = timerCount + 1
            if (timerCount == 4) {
                balanceCheck = "all"
                timerCount = 0
            }
            else {
                balanceCheck = "xby"
            }

            clearWalletList()
            var datamodelWallet = []
            var datamodelPending = []

            for (var i = 0; i < walletList.count; ++i) {
                datamodelWallet.push(walletList.get(i))
            };
            for (var e = 0; e < pendingList.count; ++e) {
                datamodelPending.push(pendingList.get(e))
            };
            var walletListJson = JSON.stringify(datamodelWallet)
            var pendingListJson = JSON.stringify(datamodelPending)

            updateBalanceSignal(walletListJson, balanceCheck);

            if (explorerBusy == false) {
                checkTxStatus(pendingListJson);
            };

            if (pendingList.count > 1) {
                for (var o = 0; 0 < pendingList.count; ++o) {
                    var times = 0
                    if (pendingList.get(o).check >= 0) {
                        times = pendingList.get(o).check
                    }
                    else {
                        pendingList.setProperty(o, "check", 0)
                        times = 0
                    }
                pendingList.setProperty(o, "check", (times + 1))
                }
            }
        }
    }

    Timer {
        id: loginTimer
        interval: 30000
        repeat: true
        running: false //sessionStart == 1

        onTriggered: {
            if (interactionTracker == 1) {
                sessionTime = 0
                interactionTracker = 0
            }
            else {
                sessionTime = sessionTime +1
                if (sessionTime >= 10){
                    sessionTime = 0
                    if (standBy == 0) {
                        standBy = 1
                        mainRoot.push("../StandBy.qml")
                    }
                }
            }
        }
    }

    Timer {
        id: networkTimer
        interval: 60000
        repeat: true
        running: sessionStart == 1

        onTriggered: {
            if (standBy == 0) {
                checkSessionId()
            }
        }
    }

    Timer {
        id: requestTimer
        interval: 5000
        repeat: true
        running: sessionStart == 1

        onTriggered: {
            checkNotifications()
            if (pinLogout == 1 && transferTracker == 0 && addAddressTracker == 0 && addContactTracker == 0 && addressTracker == 0 && editContactTracker == 0 && appsTracker == 0) {
                logoutTracker = 1
            }
        }
    }

    // Order of the pages
    StackView {
        id: mainRoot
        initialItem: "../main.qml"
        anchors.fill: parent
    }

    // native back button
    onClosing: {
        if (mainRoot.depth > 1) {
            close.accepted = false
        }
    }
}
