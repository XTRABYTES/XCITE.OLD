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
    id: xcite
    flags: Qt.Window | Qt.FramelessWindowHint | ((Qt.platform.os !== "ios" && Qt.platform.os !== "android")? Qt.X11BypassWindowManagerHint : 0) | ((Qt.platform.os !== "ios" && Qt.platform.os !== "android")? Qt.WindowStaysOnTopHint : 0)
    width: appWidth
    height: appHeight
    title: qsTr("XCITE")
    color: darktheme === "false"? "#F2F2F2" : "#14161B"
    visible: true

    Image {
        id: xbyLogo
        source: 'qrc:/logos/xby_logo_tm.png'
        width: parent.width - 100
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
        coinList.setProperty(0, "active", userSettings.xfuel);
        coinList.setProperty(0, "testnet", false );
        coinList.setProperty(0, "xby", 1);
        coinList.setProperty(0, "coinID", 0);
        coinList.append({"name": nameXBY, "fullname": "xtrabytes", "logo": 'qrc:/icons/XBY_card_logo_01.svg', "logoBig": 'qrc:/icons/XBY_logo_big.svg', "coinValueBTC": btcValueXBY, "percentage": percentageXBY, "totalBalance": 0, "active": userSettings.xby, "testnet" : false, "xby": 1,"coinID": 1});
        coinList.append({"name": "XTEST", "fullname": "testnet", "logo": 'qrc:/icons/TESTNET_card_logo_01.svg', "logoBig": 'qrc:/icons/TESTNET_logo_big.svg', "coinValueBTC": 0, "percentage": 0, "totalBalance": 0, "active": userSettings.xtest, "testnet" : true, "xby": 1,"coinID": 2});
        coinList.append({"name": "BTC", "fullname": "bitcoin", "logo": 'qrc:/icons/BTC_card_logo_01.svg', "logoBig": 'qrc:/icons/BTC_logo_big.svg', "coinValueBTC": btcValueBTC, "percentage": percentageBTC, "totalBalance": 0, "active": userSettings.btc, "testnet" : false, "xby": 0,"coinID": 3});
        coinList.append({"name": "ETH", "fullname": "ethereum", "logo": 'qrc:/icons/ETH_card_logo_01.svg', "logoBig": 'qrc:/icons/ETH_logo_big.svg', "coinValueBTC": btcValueETH, "percentage": percentageETH, "totalBalance": 0, "active": userSettings.eth, "testnet" : false, "xby": 0,"coinID": 4});

        applicationList.setProperty(0, "name", "X-CHAT");
        applicationList.setProperty(0, "icon_white", 'qrc:/icons/mobile/xchat-icon_01_white.svg');
        applicationList.setProperty(0, "icon_black", 'qrc:/icons/mobile/xchat-icon_01_black.svg');
        applicationList.append({"name": "X-CHANGE", "icon_white": 'qrc:/icons/mobile/xchange-icon_02_white.svg', "icon_black": 'qrc:/icons/mobile/xchange-icon_04_black.svg'});
        applicationList.append({"name": "X-VAULT", "icon_white": 'qrc:/icons/mobile/xvault-icon_02_white.svg', "icon_black": 'qrc:/icons/mobile/xvault-icon_02_black.svg'});
        applicationList.append({"name": "X-GAMES", "icon_white": 'qrc:/icons/mobile/games-icon_ph_white.svg', "icon_black": 'qrc:/icons/mobile/games-icon_ph_black.svg'});
        applicationList.append({"name": "CONSOLE", "icon_white": 'qrc:/icons/mobile/ping-icon_01_white.svg', "icon_black": 'qrc:/icons/mobile/ping-icon_01_black.svg'});

        txStatusList.setProperty(0, "type", "confirmed");
        txStatusList.append({"type": "pending"});


        tttButtonList.setProperty(0, "number", "1");
        tttButtonList.setProperty(0, "played", false);
        tttButtonList.setProperty(0, "player", "");
        tttButtonList.setProperty(0, "online", false);
        tttButtonList.setProperty(0, "confirmed", false);
        for (var i = 2; i < 10; i ++) {
            tttButtonList.append({"number": Number(i).toLocaleString(), "played": false, "player": "", "online": false, "confirmed": false})
        }

        scoreList.setProperty(0, "game", "ttt");
        scoreList.setProperty(0, "player", "computer");
        scoreList.setProperty(0, "win", 0);
        scoreList.setProperty(0, "lost", 0);
        scoreList.setProperty(0, "draw", 0);

        gamesList.clear();

        xChatOnline.clear();

        xChatUsers.clear();

        xChatServers.clear();

        clearUtxoList();

        requestQueue();

        alertList.clear();
        alertList.append({"date": "", "origin": "", "message": "", "remove": true});

        transactionList.clear();
        transactionList.append({"requestID": "","txid": "","coin": "","address": "","receiver": "","amount": 0, "fee": 0, "used": 0});

        findAllMarketValues()

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
    property real doubbleButtonWidth: appWidth - 56
    property string myOS: Qt.platform.os
    property int appHeight: Screen.width > Screen.height? (miniatureTracker == 0? 800 : 200) : ((myOS == "android" || myOS == "ios")? Screen.height : (miniatureTracker == 0? 800 : 200))
    property int appWidth: Screen.width > Screen.height? 400 : ((myOS == "android" || myOS == "ios")? Screen.width : 400)
    property int previousX: 0
    property int previousY: 0
    property variant notAllowed: ["<del>","</del>","<s>","</s>","<strong>","</strong>", "<br>","<p>","</p>","</font>","<h1>","</h1>","<h2>","</h2>","<h3>","</h3>","<h4>","</h4>","<h5>","</h5>","<h6>","</h6>","a href=","img src=","ol type=","ul type=","<li>","</li>","<pre>","</pre>","&gt","&lt","&amp"]

    // Global setting, editable
    property bool darktheme: userSettings.theme !== "dark"? false : true
    property string fiatTicker: userSettings.defaultCurrency == 0? "$" : userSettings.defaultCurrency == 1? "€" : userSettings.defaultCurrency == 2? "£" : "₿"
    property string myUsername: ""
    property string selectedPage: ""
    property string status: "online"
    property bool isNetworkActive: false
    property int pingSNR: 0
    property string queueName: ""

    // Trackers - pages
    property int loginTracker: 0
    property int importTracker: 0
    property int restoreTracker: 0
    property int pageTracker: 0
    property int logoutTracker: 0
    property int addWalletTracker: 0
    property int createWalletTracker: 0
    property int viewOnlyTracker: 0
    property int importKeyTracker: 0
    property int appsTracker: 0
    property int coinTracker: 0
    property int walletTracker: 0
    property int addActive: 0
    property int addViewOnly: 0
    property int transferTracker: 0
    property int historyTracker: 0
    property int addCoinTracker: 0
    property int addressTracker: 0
    property int addAddressTracker: 0
    property int deleteAddressTracker: 0
    property int contactTracker: 0
    property int addContactTracker: 0
    property int editContactTracker: 0
    property int deleteContactTracker: 0
    property int deleteWalletTracker: 0
    property int walletListTracker: 0
    property int addressbookTracker: 0
    property int scanQRTracker: 0
    property int tradingTracker: 0
    property int balanceTracker: 0
    property int calculatorTracker: 0
    property int addressQRTracker: 0
    property int pictureTracker: 0
    property int pincodeTracker: 0
    property int changePasswordTracker: 0
    property int portfolioTracker: 0
    property int walletDetailTracker: 0
    property int transactionDetailTracker: 0
    property int backupTracker: 0
    property int debugTracker: 0
    property int xvaultTracker: 0
    property int xchangeTracker: 0
    property int xchatTracker: 0
    property int xgamesTracker: 0
    property int tttTracker: 0
    property int miniatureTracker: 0
    property int pingTracker: 0
    property int updatePendingTracker: 0
    property int failedPendingTracker: 0
    property int newBalanceTracker: 0
    property int clickToLogout: 0

    // Trackers - features
    property int interactionTracker: 0
    property int coinListTracker: 0
    property int currencyTracker: 0
    property int cellTracker: 0
    property int tagListTracker: 0
    property int dndTracker: 0
    property int screenshotTracker: 0
    property int soundTracker: 0
    property int xchatSettingsTracker: 0
    property int xchatNetworkTracker: 0
    property int xchatUserTracker: 0
    property int xChatQuoteTracker: 0
    property int xChatLinkTracker: 0
    property int xChatImageTracker: 0
    property int xChatLargeImageTracker: 0
    property int inviteTracker: 0
    property int leaderBoardTracker: 0
    property int tttHubTracker: 0

    // Global variables
    property int started: 0
    property int sessionStart: 0
    property int sessionTime: 0
    property int sessionClosed: 0
    property int standBy: 0
    property bool inActive: false
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
    property int viewForScreenshot: 0
    property bool transactionInProgress: false
    property string scannedAddress: ""
    property string selectedAddress: ""
    property string currentAddress: ""
    property var calculatedAmount: ""
    property string scanningKey: ""
    property string scanning: "scanning..."
    property string typing: ""
    property bool checkingSessionID: false
    property bool loginInitiated: false
    property bool importInitiated: false
    property bool restoreInitiated: false
    property bool createAccountInitiated: false
    property bool saveAccountInitiated: false
    property string addressbookName: ""
    property string addressbookHash: ""
    property int addressIndex: 0
    property bool addingAddress: false
    property bool saveAddressInitiated: false
    property bool editingAddress: false
    property bool deletingAddress: false
    property int contactIndex: 0
    property bool addingContact: false
    property bool editingContact: false
    property bool deletingContact: false
    property int walletIndex: 1
    property bool editingWallet: false
    property bool deletingWallet: false
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
    property bool savePinInitiated: false
    property bool checkPinInitiated: false
    property bool clearPinInitiated: false
    property bool changeVolumeInitiated: false
    property bool changeSystemVolumeInitiated: false
    property bool changeBalanceVisibleInitiated: false
    property bool clearAllInitiated: false
    property int clearAll: 0
    property int pinOK: 0
    property int pinError: 0
    property bool savePasswordInitiated: false
    property int requestSend: 0
    property bool newAccount: false
    property real changeBalance: 0
    property string notificationDate: ""
    property bool walletAdded: false
    property bool alert: false
    property bool updatingWalletsNotif: false
    property bool testNet: false
    property bool saveCurrency: false
    property int oldCurrency: 0
    property int currencyChangeFailed: 0
    property string oldLocale: ""
    property int oldDefaultCurrency: 0
    property string oldTheme: ""
    property bool oldPinlock: false
    property bool oldLocalKeys: false
    property bool oldBalanceVisible: true
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
    property bool loadTransactionsInitiated: false
    property bool transactionDetailsCollected: false
    property bool historyDetailsCollected: false
    property int transactionPages: 0
    property int currentPage: 0
    property string transactionNR: ""
    property string transactionTimestamp: ""
    property bool transactionDirection: false
    property real transactionAmount: 0
    property string transactionConfirmations: ""
    property string transactionID: ""
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
    property string selectedXChatServer: ""
    property bool pingingXChat: false
    property int pingTimeRemain: 60
    property string xChatMessage: ""
    property bool newMessages: false
    property bool messageAdded: false
    property bool xChatScrolling: false
    property int xChatID: 1
    property int xChatTag: 0
    property int xChatFilterResults: 0
    property string dndUser: ""
    property variant messageArray
    property string tagFilter: ""
    property string xchatLink: ""
    property string url2Copy: ""
    property int urlCopy2Clipboard: 0
    property int xChatClipBoard: 0
    property bool urlFormat: false
    property string xchatImage: ""
    property string xchatLargeImage: ""
    property string xchatQuote: ""
    property bool quoteAdded: false
    property bool linkAdded: false
    property bool imageAdded: false
    property string longMessage: ""
    property string shortMessage: ""
    property bool sendTyping: true
    property bool xChatConnection: false
    property bool xChatConnecting: false
    property bool xChatDisconnected: false
    property bool checkingXchat: false
    property bool tagMeChangeInitiated: false
    property bool tagEveryoneChangeInitiated: false
    property bool dndChangeInitiated: false
    property bool tttGameStarted: false
    property bool tttYourTurn: false
    property bool tttFinished: false
    property bool tttquit: false
    property string tttCurrentGame: ""
    property string tttPlayer:""
    property bool alertTtt: false
    property int gameError: 0
    property bool loadingGame: false
    property string inviteGame: ""
    property string invitedPlayer: ""
    property int playerNotAvailable: 0
    property string selectedApp: ""
    property string copiedConsoleText: ""
    property string failedTX: ""


    // Signals
    signal loginSuccesfulSignal(string username, string password)
    signal loginFailed()
    signal marketValueChangedSignal(string currency)
    signal findAllMarketValues()
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
    signal restoreAccount(string username, string password)
    signal exportAccount(string walletlist)
    signal updateBalanceSignal(string walletlist, string wallets)
    signal createKeyPair(string network)
    signal importPrivateKey(string network, string privKey)
    signal helpMe()
    signal xChatSend(string usr, string platform, string status, string msg , string link, string image, string quote)
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
    signal checkWriteAccess()
    signal checkTxStatus(string pendinglist)
    signal changePassword(string oldPassword, string newPassword)
    signal xChatTypingSignal(string user, string route, string status)
    signal checkXChatSignal()
    signal pingXChatServers()
    signal xChatReconnect()
    signal xchatPopup(string author, string msg)
    signal downloadImage(string url)
    signal tttSetUsername(string username)
    signal tttGetScore()
    signal tttResetScore(string win, string lost, string draw)
    signal tttNewGame()
    signal tttQuitGame()
    signal tttButtonClicked(string button)
    signal tttGetMoveID(string move)
    signal tttNewMove(string player, string move)
    signal tttcreateGameId(string me, string opponent)
    signal sendGameToQueue(string user, string game, string gameID, string move)
    signal confirmGameSend(string user, string game, string gameID, string move, string moveID)
    signal sendGameInvite(string user, string opponent, string game, string gameID)
    signal confirmGameInvite(string user, string opponent, string game, string gameID, string accept)
    signal dicomRequest(string params)
    signal clearUtxoList()
    signal requestQueue()
    signal setQueue(string queue)

    onTttCurrentGameChanged: {
        if (tttCurrentGame != "") {
            tttPlayer = findOpponent(tttCurrentGame)
        }
    }

    // Keyboard shortcuts
    Shortcut {
        sequence: "Alt+M"
        onActivated: minimizeApp()
    }

    Shortcut {
        sequence: "Alt+Down"
        onActivated: {
            if (myOS !== "android" || myOS !== "ios") {
                miniatureTracker = 0
            }
        }
    }

    Shortcut {
        sequence: "Alt+Up"
        onActivated: {
            if (myOS !== "android" || myOS !== "ios") {
                miniatureTracker = 1
            }
        }
    }

    Shortcut {
        sequence: "Alt+Left"
        onActivated: {
            if (myOS !== "android" || myOS !== "ios") {
                backButtonPressed()
            }
        }
    }

    Shortcut {
        sequence: "Alt+Q"
        onActivated: {
            if (myOS !== "android" || myOS !== "ios") {
                sessionStart = 0
                sessionTime = 0
                manualLogout = 1
                logoutTracker = 1
            }
        }
    }

    // functions
    function openApplication(app) {
        if (app === "X-CHAT") {
            status = userSettings.xChatDND == true? "dnd" : status
            xChatTypingSignal(myUsername,"addToOnline", status)
            xchatTracker = 1
            selectedApp = ""
        }
        if (app === "X-CHANGE") {
            xchangeTracker = 1
            selectedApp = ""
        }
        if (app === "X-VAULT") {
            xvaultTracker = 1
            selectedApp = ""
        }
        if (app === "X-GAMES") {
            xgamesTracker = 1
            selectedApp = ""
        }
        if (app === "CONSOLE") {
            pingTracker = 1
            selectedApp = ""
        }
    }

    function moveWindowX(dx) {
        xcite.setX(xcite.x + dx)
    }

    function moveWindowY(dy) {
        xcite.setY(xcite.y + dy)
    }

    function minimizeApp() {
        if (myOS !== "android" || myOS !== "ios") {
            showMinimized()
        }
    }

    function backButtonPressed() {
        if (logoutTracker == 0 && pincodeTracker == 0 && changePasswordTracker == 0 && miniatureTracker == 0) {
            if (networkError == 1) {
                networkError = 0
            }
            else if (selectedPage == "onBoarding") {
                if (loginTracker == 1 && !loginInitiated) {
                    loginTracker = 0
                }
                else if (importTracker == 1 && !importInitiated) {
                    importTracker = 0
                }
                else if (restoreTracker == 1 && !restoreInitiated) {
                    restoreTracker = 0
                }
            }
            else if (selectedPage == "home") {
                if (appsTracker == 1) {
                    appsTracker = 0
                }
                else if (addCoinTracker == 1) {
                    addCoinTracker = 0
                }

                else if (historyTracker == 1) {
                    if (transactionDetailTracker == 1) {
                        transactionDetailTracker = 0
                    }
                    else {
                        historyTracker = 0
                    }
                }
                else if (addContactTracker == 1 && !addingContact) {
                    addContactTracker = 0
                }
                else if (editContactTracker == 1 && !editingContact && !deletingContact) {
                    if (deleteContactTracker == 1) {
                        deleteContactTracker = 0
                    }
                    else   {
                        editContactTracker = 0
                    }
                }
                else if (addAddressTracker == 1 && !addingAddress && !saveAddressInitiated) {
                    addAddressTracker = 0
                }
                else if (addressTracker == 1 && !editingAddress && !deletingAddress) {
                    if (deleteAddressTracker == 1) {
                        deleteAddressTracker = 0
                    }
                    else {
                        addressTracker = 0
                    }
                }
                else if (walletDetailTracker == 1 && !editingWallet && !deletingWallet) {
                    if (deleteWalletTracker == 1) {
                        deleteWalletTracker = 0
                    }
                    else {
                        walletDetailTracker = 0
                    }
                }

                else if (portfolioTracker == 1) {
                    portfolioTracker = 0
                }
                else if (scanQRTracker == 1) {
                    // nothing yet
                }
                else if (transferTracker == 1) {
                    if (calculatorTracker == 1) {
                        calculatorTracker =0
                    }
                    else if (addressbookTracker == 1) {
                        addressbookTracker = 0
                    }
                    else if (scanQRTracker == 1) {
                        scanQRTracker = 0
                    }
                    else if (viewForScreenshot == 1) {
                        viewForScreenshot = 0
                    }

                    else if (transactionInProgress == false){
                        transferTracker = 0
                    }
                }
                else if (coinTracker == 1 && pageTracker == 0) {
                    countWallets()
                    coinTracker = 0
                }
                else if (contactTracker == 1 && pageTracker == 1) {
                    contactTracker = 0
                }
                else if (addressQRTracker == 1 && pageTracker == 1) {
                    addressQRTracker = 0
                }

                else {
                    if (clickToLogout == 0) {
                        clickToLogout = 1
                    }
                    else {
                        clickToLogout = 0
                        sessionStart = 0
                        sessionTime = 0
                        manualLogout = 1
                        logoutTracker = 1
                    }
                }
            }
            else if (selectedPage == "wallet") {
                // nothing yet
            }
            else if (selectedPage == "apps") {
                if (xchangeTracker == 0 && xchatTracker == 0 && xvaultTracker == 0 && xgamesTracker == 0 && pingTracker == 0) {
                    appsTracker = 0
                    selectedPage = "home"
                    mainRoot.pop()
                }
                else if (pingTracker == 1 && networkError == 0) {
                    pingTracker = 0
                }

                else if (xgamesTracker == 1 && networkError == 0) {
                    if (inviteTracker == 1) {
                        inviteTracker = 0
                    }
                    else if (tttTracker == 1) {
                        if (tttHubTracker == 1) {
                            tttHubTracker = 0
                            tttquit = false
                        }
                        else if (leaderBoardTracker == 1) {
                            leaderBoardTracker = 0
                        }
                        else {
                            tttTracker = 0
                        }
                    }
                    else {
                        xgamesTracker = 0
                    }
                }

                else if (xvaultTracker == 1 && networkError == 0) {
                    xvaultTracker =0
                }
                else if (xchangeTracker == 1 && networkError == 0) {
                    xchangeTracker = 0
                }
                else if (xchatTracker == 1 && networkError == 0) {
                    if (xchatSettingsTracker == 1) {
                        if (!tagMeChangeInitiated && !tagEveryoneChangeInitiated && !dndChangeInitiated) {
                            xchatSettingsTracker = 0
                        }
                    }
                    else if (xchatNetworkTracker == 1) {
                        xchatNetworkTracker = 0
                    }
                    else if (xchatUserTracker == 1) {
                        xchatUserTracker = 0
                    }
                    else if (xChatImageTracker == 1) {
                        xChatImageTracker = 0
                    }
                    else if (xChatLinkTracker == 1) {
                        xChatLinkTracker = 0
                    }
                    else if (xChatQuoteTracker == 1) {
                        xChatQuoteTracker = 0
                    }
                    else if (xChatLargeImageTracker == 1) {
                        xChatLargeImageTracker = 0
                    }
                    else if (xChatClipBoard == 1) {
                        xChatClipBoard = 0
                    }

                    else {
                        xchatTracker = 0
                        dndTracker = 0
                    }
                }
            }
            else if (selectedPage == "backup") {
                if (screenshotTracker == 0) {
                    backupTracker = 0
                    selectedPage = "home"
                    mainRoot.pop()
                }
                else if (screenshotTracker == 1) {
                    screenshotTracker = 0
                }
            }
            else if (selectedPage == "settings") {
                if (debugTracker == 1) {
                    debugTracker = 0
                }
                else if (!changeVolumeInitiated && ! changeSystemVolumeInitiated && !clearAllInitiated && !saveCurrency && !saveSound) {
                    currencyTracker = 0
                    soundTracker = 0
                    selectedPage = "home"
                    mainRoot.pop()
                }
            }
            else if (selectedPage == "notif" && updatingWalletsNotif == false) {
                selectedPage = "home"
                mainRoot.pop()
            }
        }
    }

    function isIphoneX() {
        if (Qt.platform.os === "ios"){
            switch(appHeight * Screen.devicePixelRatio) {
            case 1792: //("iPhone_XR");
            case 2436: //("iPhone_X_XS");
            case 2688: //("iPhone_XRS_MAX");
                return true;
            default: //("not an iPhone X");
                return false;
            }
        }
        else {
            //("not an iPhone");
            return false;
        }
    }

    function updateBalance(coin, address, balance) {
        var balanceAlert
        var difference
        var newBalance
        changeBalance = 0

        for(var i = 0; i < walletList.count; i ++) {
            if (walletList.get(i).name === coin) {
                if (walletList.get(i).address === address) {
                    newBalance = parseFloat(balance);
                    if (!isNaN(newBalance)){
                        if (newBalance !== walletList.get(i).balance) {
                            console.log("updating balance for " + coin + " " + address + ": " + balance)
                            newBalanceTracker = 0
                            changeBalance = newBalance - walletList.get(i).balance
                            if (changeBalance > 0) {
                                difference = "increased"
                            }
                            else {
                                difference = "decreased"
                                newBalancePending(coin, address)
                            }
                            newBalanceTracker = 1
                            walletList.setProperty(i, "balance", newBalance)
                            balanceAlert = "Your balance has " + difference + " with:<br><b>" + changeBalance + "</b>" + " " + (walletList.get(i).name)
                            alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : balanceAlert, "origin" : (walletList.get(i).name + " " + walletList.get(i).label), "remove": false})
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

    function confirmTransaction(coin, address, txid) {
        for (var u = 0; u <pendingList.count; u ++) {
            if (pendingList.get(u).coin === coin && pendingList.get(u).address === address && pendingList.get(u).txid === txid) {
                pendingList.setProperty(u, "value", "confirmed")
            }
        }
        for (var i = 0; i < transactionList.count; i ++) {
            if (transactionList.get(i).txid === txid) {
                var b = ""
                for (var a = 0; a < walletList.count; a ++ ) {
                    if (walletList.get(a).name === coin && walletList.get(a).address === address) {
                        b = walletList.get(a).label
                    }
                }
                if (b === "") {
                    b = transactionList.get(i).address
                }
                var c = ""
                for (var e = 0; e < addressList.count; e ++ ) {
                    if (addressList.get(e).coin === coin && addressList.get(e).address === transactionList.get(i).receiver) {
                        if(addressList.get(e).fullName !== undefined) {
                            c = addressList.get(e).fullName + " " + addressList.get(e).label
                        }
                        else {
                            c = addressList.get(e).label
                        }
                    }
                }
                if (c === "") {
                    c = transactionList.get(i).receiver
                }
                var h = Number(transactionList.get(i).amount).toLocaleString(Qt.locale("en_US"))
                var l = transactionList.get(i).amount
                var k = Number(transactionList.get(i).fee).toLocaleString(Qt.locale("en_US"))
                var m = transactionList.get(i).used
                var o = Number(transactionList.get(i).used).toLocaleString(Qt.locale("en_US"))
                var d = "Confirmed transaction of " + h + transactionList.get(i).coin + " (fee: " + k + transactionList.get(i).coin + ") to " + c
                alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : d, "origin" : coin + " " + b, "remove": false})
                alert = true
                notification.play()
            }
        }
    }

    function updatePending(coin, address, txid, result) {
        for (var u = 0; u < pendingList.count; u ++){
            if(pendingList.get(u).coin === coin) {
                if(pendingList.get(u).address === address) {
                    if(pendingList.get(u).txid === txid) {
                        if(result === "true" || result === "confirmed") {
                            pendingList.setProperty(u,"value",result)
                        }
                    }
                }
            }
        }
    }

    function pendingUnconfirmed(coin, address, txid, result) {
        for (var i = 0; i < pendingList.count; i ++){
            if(pendingList.get(i).coin === coin && pendingList.get(i).value === "false") {
                if(pendingList.get(i).address === address) {
                    if(pendingList.get(i).txid === txid) {
                        if(pendingList.get(i).check >= 10) {
                            pendingList.setProperty(i,"value",result)
                            failedTX = txid
                            failedPendingTracker = 0
                            var addressname = getLabelAddress(coin, address)
                            var cancelAlert = "transaction canceled: " + txid
                            alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : cancelAlert, "origin" : coin + " " + addressname, "remove": false})
                            alert = true
                            notification.play()
                            failedPendingTracker = 1
                        }
                    }
                }
            }
        }
    }

    function countWallets() {
        totalWallets = 0
        if (coinTracker == 0) {
            for(var i = 0; i < coinList.count; i ++) {
                if (coinList.get(i).active === 1) {
                    totalWallets += 1
                }
            }
        }
        else {
            var name = getName(coinIndex)
            for(var e = 0; e < walletList.count; e ++){
                if (walletList.get(e).name === name) {
                    totalWallets += 1
                }
            }
        }

        return totalWallets
    }

    function coinWalletLines(coin) {
        totalCoinWallets = 0
        for(var i = 0; i < walletList.count; i ++) {
            if (walletList.get(i).name === coin) {
                if (walletList.get(i).remove === false) {
                    totalCoinWallets += 1
                }
            }
        }
    }

    function resetFavorites(coin) {
        for(var i = 0; i < walletList.count; i ++) {
            if (walletList.get(i).name === coin) {
                walletList.setProperty(i, "favorite", false)
            }
        }
    }

    function countAddresses() {
        totalAddresses = 0
        for(var i = 0; i < walletList.count; i ++) {
            totalAddresses += 1
        }
        return totalAddresses
    }

    function countAddressesContact(contactID) {
        var contactAddresses = 0
        for(var i = 0; i < addressList.count; i ++) {
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
        for(var i = 0; i < walletList.count; i ++) {
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

    function newBalancePending(coin, address) {
        for (var i = 0; i < pendingList.count; i ++) {
            if (pendingList.get(i).coin === coin && pendingList.get(i).address === address && pendingList.get(i).value !== "confirmed") {
                confirmTransaction(coin, address, pendingList.get(i).txid)
            }
        }
    }

    function pendingCoins(coin, address) {
        var pending = 0
        for (var i = 0; i < pendingList.count; i ++) {
            if (pendingList.get(i).coin === coin && pendingList.get(i).address === address && pendingList.get(i).value !== "confirmed" && pendingList.get(i).value !== "rejected") {
                pending += pendingList.get(i).used
            }
        }
        return pending
    }

    function unconfirmedTx(coin, address) {
        var unconfirmed = 0
        for (var i = 0; i < pendingList.count; i ++) {
            if (pendingList.get(i).coin === coin && pendingList.get(i).address === address && pendingList.get(i).value !== "confirmed" && pendingList.get(i).value !== "rejected") {
                unconfirmed += pendingList.get(i).amount
                unconfirmed += getFee(coin, pendingList.get(i).txid)
            }
        }
        return unconfirmed
    }

    function getFee(coin, txid) {
        var fee = 0
        for (var e = 0; e < transactionList.count; e ++) {
            if (coin === transactionList.get(e).coin && txid === transactionList.get(e).txid) {
                fee = transactionList.get(e).fee
            }
        }
        return fee
    }

    function sumXBY() {
        totalXBY =0
        for(var i = 0; i < walletList.count; i ++) {
            if (walletList.get(i).name === "XBY" && walletList.get(i).include === true && walletList.get(i).remove === false) {
                totalXBY += walletList.get(i).balance
            }
        }
        return totalXBY
    }

    function sumXFUEL() {
        totalXFUEL = 0
        for(var i = 0; i < walletList.count; i ++) {
            if (walletList.get(i).name === "XFUEL" && walletList.get(i).include === true && walletList.get(i).remove === false) {
                totalXFUEL += walletList.get(i).balance
            }
        }
        return totalXFUEL
    }

    function sumXTest() {
        totalXFUELTest = 0
        for(var i = 0; i < walletList.count; i ++) {
            if (walletList.get(i).name === "XTEST" && walletList.get(i).include === true && walletList.get(i).remove === false) {
                totalXFUELTest += walletList.get(i).balance
            }
        }
        return totalXFUELTest
    }

    function sumBTC() {
        totalBTC = 0
        for(var i = 0; i < walletList.count; i ++) {
            if (walletList.get(i).name === "BTC" && walletList.get(i).include === true && walletList.get(i).remove === false) {
                totalBTC += walletList.get(i).balance
            }
        }
        return totalBTC
    }

    function sumETH() {
        totalETH = 0
        for(var i = 0; i < walletList.count; i ++) {
            if (walletList.get(i).name === "ETH" && walletList.get(i).include === true && walletList.get(i).remove === false) {
                totalETH += walletList.get(i).balance
            }
        }
        return totalXFUEL
    }

    function sumCoinTotal(coin) {
        var coinTotal = 0
        for(var i = 0; i < walletList.count; i ++) {
            if (walletList.get(i).name === coin && walletList.get(i).include === true && walletList.get(i).remove === false) {
                coinTotal += walletList.get(i).balance
            }
        }
        return coinTotal
    }

    function sumCoinUnconfirmed(coin) {
        var unconfirmedTotal = 0
        for(var i = 0; i < walletList.count; i ++) {
            if (walletList.get(i).name === coin && walletList.get(i).include === true && walletList.get(i).remove === false) {
                unconfirmedTotal += unconfirmedTotal + walletList.get(i).unconfirmedCoins
            }
        }
        return unconfirmedTotal
    }

    function coinConversion(coin, quantity) {
        var converted = 0
        for(var i = 0; i < coinList.count; i ++) {
            if (coinList.get(i).name === coin) {
                converted = (quantity * coinList.get(i).coinValueBTC * valueBTC)
            }
        }
        return converted
    }

    function getLogo(coin) {
        var logo = ''
        for(var i = 0; i < coinList.count; i ++) {
            if (coinList.get(i).name === coin) {
                logo = coinList.get(i).logo
            }
        }
        return logo
    }

    function getTestnet(coin) {
        testNet = false
        for(var i = 0; i < coinList.count; i ++) {
            if (coinList.get(i).name === coin) {
                testNet = coinList.get(i).testnet
            }
        }
        return testNet
    }

    function getLogoBig(coin) {
        var logo = ''
        for(var i = 0; i < coinList.count; i ++) {
            if (coinList.get(i).name === coin) {
                logo = coinList.get(i).logoBig
            }
        }
        return logo
    }

    function getName(coin) {
        var name = ""
        for(var i = 0; i < coinList.count; i ++) {
            if (coinList.get(i).coinID === coin) {
                name = coinList.get(i).name
            }
        }
        return name
    }

    function getFullName(coin) {
        var name = ""
        for(var i = 0; i < coinList.count; i ++) {
            if (coinList.get(i).coinID === coin) {
                name = coinList.get(i).fullname
            }
        }
        return name
    }

    function getPercentage(coin) {
        var percentage = 0
        for(var i = 0; i < coinList.count; i ++) {
            if (coinList.get(i).name === coin) {
                percentage = coinList.get(i).percentage
            }
        }
        return percentage
    }

    function getValue(coin) {
        var value = 0
        for(var i = 0; i < coinList.count; i ++) {
            if (coinList.get(i).name === coin) {
                value = coinList.get(i).coinValueBTC
            }
        }
        return value
    }

    function getPrivKey(coin, label) {
        var privKey = ""
        for(var i = 0; i < walletList.count; i ++) {
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
        for(var i = 0; i < walletList.count; i ++) {
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
        for(var i = 0; i < walletList.count; i ++) {
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
        for(var i = 0; i < walletList.count; i ++) {
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
        for (var i = 0; coinList.count; i ++) {
            if (coinList.get(i).name === coin) {
                selectedCoin= coinList.get(i).coinID
            }
        }
    }

    function defaultWallet(coin) {
        var balance = 0
        var wallet = 0
        var favorite = false
        for(var i = 0; i < walletList.count; i ++){
            if (walletList.get(i).name === coin){
                if (favorite === false) {
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
                        else if (wallet === 0) {
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
        for(var i = 0; i < coinList.count; i ++) {
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
        var count = 0
        for (var i = 0; i < alertList.count; i ++) {
            if(alertList.get(i).remove === false) {
                count = count +1
            }
        }
        if (count > 0) {
            alert = true
        }
        else {
            alert = false
        }
    }

    function clearAlertList() {
        for (var i = 0; i < alertList.count; i ++) {
            alertList.setProperty(i, "remove", true)
        }
        alert = false
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

    // X-CHAT

    function dndNotification (user) {
        dndUser = user
        dndTracker = 1
    }

    function getUserStatus(user) {
        var userStatus = ""
        for(var i = 0; i < xChatUsers.count; i ++) {
            if (user === xChatUsers.get(i).username) {
                userStatus = xChatUsers.get(i).status
            }
        }

        return userStatus
    }

    function xChatTyping(user, route, status){
        xChatTypingSignal(user, route, status)
    }

    function loadOnlineUsers(online) {
        xChatOnline.clear()
        if (typeof online !== "undefined") {
            var obj = JSON.parse(online);
            for (var i in obj){
                var data = obj[i];
                xChatOnline.append(data)
            }
            for (var a = 0; a < xChatOnline.count; a ++) {
                xChatOnline.setProperty(a,"newUser",true)
            }
            for (var u = 0; u < xChatUsers.count; u ++) {
                xChatUsers.setProperty(u,"updated",false)
            }
            for (var e = 0; e < xChatUsers.count; e ++) {
                var user = xChatUsers.get(e).username
                for (var o = 0; o < xChatOnline.count; o ++) {
                    if (user === xChatOnline.get(o).username) {
                        xChatUsers.setProperty(e,"date",xChatOnline.get(o).date)
                        xChatUsers.setProperty(e,"time",xChatOnline.get(o).time)
                        xChatUsers.setProperty(e,"status",xChatOnline.get(o).status)
                        xChatUsers.setProperty(e,"updated",true)
                        xChatOnline.setProperty(o,"newUser",false)
                    }
                }
            }
            for (var y = 0; y < xChatOnline.count; y ++) {
                var act = xChatOnline.get(y).newUser
                if (act === true) {
                    var userID = xChatOnline.get(y).username
                    xChatUsers.append({"username":userID, "date":xChatOnline.get(y).date, "time":xChatOnline.get(y).time, "status":xChatOnline.get(y).status, "active":true, "updated": true, "noCapitals": userID.toLowerCase()})
                }
            }
            for (var b = 0; b < xChatUsers.count; b ++) {
                var updated = xChatUsers.get(b).updated
                if (updated === false) {
                    xChatUsers.setProperty(b,"status","offline")
                }
            }
        }
    }

    function updateServerResponseTime(server, responseTime, serverStatus) {
        if(xChatServers.count != 0) {
            var serverFound = false
            for (var i = 0; i < xChatServers.count; i ++) {
                if (server === xChatServers.get(i).name) {
                    xChatServers.setProperty(i, "responseTime", responseTime)
                    xChatServers.setProperty(i, "serverStatus", serverStatus)
                    xChatServers.setProperty(i, "updated", true)
                    serverFound = true
                }
            }
            if(!serverFound) {
                xChatServers.append({"name": server, "responseTime": responseTime, "serverStatus": serverStatus, "updated": true})
            }
        }
        else {
            xChatServers.append({"name": server, "responseTime": responseTime, "serverStatus": serverStatus, "updated": true})
        }
    }

    function updateServerStatus() {
        for (var i = 0; i < xChatServers.count; i ++) {
            if (!xChatServers.get(i).updated) {
                xChatServers.setProperty(i, "serverStatus", "down")
                xChatServers.setProperty(i, "updated", true)
            }
        }
    }

    function resetServerUpdateStatus () {
        for (var i = 0; i < xChatServers.count; i ++) {
            xChatServers.setProperty(i, "updated", false)
        }
    }

    function addQuote(user, message) {
        var remove = ["<font color='#0ED8D2'><b>","<font color='#5E8BFF'><b>","</b></font>"]
        for(var o = 0; o < remove.length; o ++) {
            var u = new RegExp( remove[o], "gi")
            message = message.replace(u, "")
        }
        xchatQuote = user + ": " + message
        quoteAdded = true
    }

    // X-GAMES
    function findLastMove(game, gameID) {
        var lastMoveNR = ""
        var lastMove = ""
        var moveID = 0
        for (var i = 0; i < movesList.count; i ++) {
            if (movesList.get(i).game === game && movesList.get(i).gameID === gameID){
                moveID = Number.fromLocaleString(movesList.get(i).moveID)
                if (moveID > lastMoveNR) {
                    lastMoveNR = moveID
                    lastMove = movesList.get(i).move
                }
            }
        }
        return lastMove;
    }

    function findLastMoveID(game, gameID) {
        var lastMoveNR = 0
        var moveID = 0
        for (var i = 0; i < movesList.count; i ++) {
            if (movesList.get(i).game === game && movesList.get(i).gameID === gameID){
                moveID = Number.fromLocaleString(movesList.get(i).moveID)
                if (moveID > lastMoveNR) {
                    lastMoveNR = moveID
                }
            }
        }
        return lastMoveNR;
    }

    function findGameNr(gameID) {
        var gameNR = ""
        var gameIDArray = gameID.split(':')
        gameNR = gameIDArray[2]
        return gameNR;
    }

    function findOpponent(gameID) {
        var opponent = ""
        var gameIDArray = gameID.split(':')
        if (gameIDArray[0] === myUsername) {
            opponent = gameIDArray[1]
        }
        if (gameIDArray[1] === myUsername) {
            opponent = gameIDArray[0]
        }
        return opponent;
    }

    function findInviter(gameID, place) {
        var gameIDArray = gameID.split(':')
        var inviter = ""
        if (place === 1) {
            inviter = gameIDArray[0]
        }
        else if (place === 2) {
            inviter = gameIDArray[1]
        }
        return inviter;
    }

    function checkForUserScore(player, game) {
        var exists = false
        for (var i = 0; i < scoreList.count; i ++) {
            if (scoreList.get(i).game === game && scoreList.get(i).player === player) {
                exists = true
            }
        }
        if (!exists) {
            scoreList.append({"game": game, "player": player, "win": 0, "lost": 0, "draw": 0})
        }
    }

    function checkIfMoveExists(game, gameID, player, move, moveID) {
        var opponent = findOpponent(gameID)
        for(var o = 0; o < gamesList.count; o ++) {
            if(gamesList.get(o).game === game && gamesList.get(o).gameID === gameID) {
                gamesList.setProperty(o, "started", true)
            }
        }

        var exists = false
        for(var i = 0; i < movesList.count; i ++) {
            if(movesList.get(i).game === game && movesList.get(i).gameID === gameID && movesList.get(i).moveID === moveID){
                exists = true
            }
        }

        if(!exists){
            console.log("move does not exist")
            console.log("adding move for: " + player + " to movesList, game: " + game + ", move: " + move + ", moveID: " + moveID)
            movesList.append({"game": game, "gameID": gameID, "player": player, "move": move, "moveID": moveID, "confirmed": false});
        }
        else {
            console.log("move exists")
        }

        if (opponent !== "computer" || loadingGame === true) {
            console.log("sending move to back end")
            newMove(game, gameID, player, move)
        }

        if (player !== myUsername) {
            console.log("send confirmation to opponent")
            confirmGameSend(myUsername, game, gameID,  move, moveID)
            confirmMove(game, gameID, move, moveID)
        }
    }

    function newMove(game, gameID, player, move) {
        var gameNR = findGameNr(gameID)
        console.log("playing new move: " + move + " for player: " + player)
        for (var i = 0; i < gamesList; i ++) {
            if(gamesList.get(i).game === game && gamesList.get(i).gameID === gameID) {
                console.log("mark game as started")
                gamesList.setProperty(i, "started", true)
            }
        }
        if (game === "ttt") {
            console.log("convert move to button")
            var number = Number.fromLocaleString(move) - 1;
            console.log("move: " + move + " to nr: " + number)
            if (game === "ttt" && gameID === tttCurrentGame) {
                tttNewMove(player, move)
                if (player !== myUsername) {
                    tttButtonList.setProperty(number, "confirmed", true);
                }
                if(player !== myUsername && loadingGame !== true) {
                    notification.play()
                    if (tttTracker !== 1) {
                        alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : player + " has made a new move in Tic Tact Toe in game #" + gameNR, "origin" : "X-GAMES", "remove": false})
                        alert = true
                    }
                }
            }
        }
    }

    function confirmMove(game, gameID, move, moveID) {
        var number = (Number.fromLocaleString(move) - 1);
        for (var i = 0; i < movesList.count; i ++) {
            if (movesList.get(i).game === game && movesList.get(i).gameID === gameID && movesList.get(i).moveID === moveID) {
                movesList.setProperty(i, "confirmed", true)
                if (game === "ttt" && gameID === tttCurrentGame) {
                    tttButtonList.setProperty(number, "confirmed", true);
                }
            }
        }
    }

    function correctUser(user, gameID) {
        var opponent = false
        var gameIDArray = gameID.split(':')
        if (gameIDArray[0] === user) {
            opponent = true
        }
        if (gameIDArray[1] === user) {
            opponent = true
        }
        return opponent;
    }

    function isMyGame(gameID) {
        var gameIDArray = gameID.split(':')
        var isMine = false
        if (gameIDArray[0] === myUsername) {
            isMine = true
        }
        if (gameIDArray[1] === myUsername) {
            isMine = true
        }

        return isMine;
    }

    function inviteSent(game, gameID) {
        for (var i = 0; i < gamesList.count; i ++) {
            if (gamesList.get(i).game === game && gamesList.get(i).gameID === gameID) {
                gamesList.setProperty(i, "invited", true)
            }
        }
    }

    function getGameName(game) {
        var gameName = ""
        if (game === "ttt" ) {
            gameName = "Tic Tac Toe"
        }
        return gameName
    }

    function checkIfInviteExists(game, gameID) {
        var gameNR = findGameNr(gameID)
        var gameName = getGameName(game)
        var exists = false
        var opponent = findOpponent(gameID)
        for (var i = 0; i < gamesList.count; i ++) {
            if(gamesList.get(i).game === game && gamesList.get(i).gameID === gameID) {
                exists = true
            }
        }
        if(!exists) {
            notification.play()
            gamesList.append({"game": game, "gameID": gameID, "invited": true, "accepted": false, "started": false, "finished": false})
            alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : opponent + " has has invited you to play a game of " + gameName + " #" + gameNR, "origin" : "X-GAMES", "remove": false})
            alert = true
        }
        else {
            notification.play()
            alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : opponent + " send you a reminder for his invite to play " + gameName + " #" + gameNR, "origin" : "X-GAMES", "remove": false})
            alert = true
        }
    }

    function acceptGameInvite(user, game, gameID, accept) {
        console.log("accept game initiated")
        var gameName = getGameName(game)
        var player = findOpponent(gameID)
        for(var i = 0; i < gamesList.count; i ++) {
            if (gamesList.get(i).game === game && gamesList.get(i).gameID === gameID) {
                console.log("game found")
                if(accept === "true") {
                    gamesList.setProperty(i, "accepted", true)
                    checkForUserScore(player, game)
                    console.log("game accepted")
                    if (user !== myUsername) {
                        notification.play()
                        alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : player + " accepted your invite for " + gameName, "origin" : "X-GAMES", "remove": false})
                        alert = true
                    }
                    else {
                        confirmGameInvite(myUsername, player, game, gameID, "true")
                    }
                }
                else if (accept === "false") {
                    gamesList.remove(i, 1)
                    console.log("game rejected")
                    if (user !== myUsername) {
                        notification.play()
                        alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : player + " did not accept your invite for " + gameName, "origin" : "X-GAMES", "remove": false})
                        alert = true
                    }
                    else {
                        confirmGameInvite(myUsername, player, game, gameID, "false")
                    }
                }
            }
        }
    }

    function removeGame(game, gameID) {
        for(var i = 0; i < gamesList.count; i ++) {
            if (gamesList.get(i).game === game && gamesList.get(i).gameID === gameID) {
                gamesList.remove(i, 1)
            }
        }
        removeMoves(game, gameID)
    }

    function removeMoves(game, gameID) {
        for(var o = 0; o < movesList.count; o ++) {
            if (movesList.get(o).game === game && movesList.get(o).gameID === gameID) {
                console.log("removing move from movesList")
                movesList.remove(o, 1)
                o = o - 1
            }
        }
    }

    function updateScore(game, player, wn, lst, drw) {
        for (var i = 0; i < scoreList.count; i ++) {
            if(scoreList.get(i).game === game && scoreList.get(i).player === player) {
                var currentWin = scoreList.get(i).win
                var currentLost = scoreList.get(i).lost
                var currentDraw = scoreList.get(i).draw
                scoreList.setProperty(i, "win", currentWin + wn)
                scoreList.setProperty(i, "lost", currentLost + lst)
                scoreList.setProperty(i, "draw", currentDraw + drw)
                var newWin = scoreList.get(i).win
                var newLost = scoreList.get(i).lost
                var newDraw = scoreList.get(i).draw
            }
        }
        loadScore(game, player)
    }

    function loadScore(game, player) {
        if (game === "ttt") {
            tttResetScore(0, 0, 0)
            for (var i = 0; i < scoreList.count; i ++) {
                if (scoreList.get(i).game === game && scoreList.get(i).player === player) {
                    var win = scoreList.get(i).win
                    var lost = scoreList.get(i).lost
                    var draw = scoreList.get(i).draw
                    tttResetScore(win, lost, draw)
                }
            }
            tttGetScore()
        }
        loadingGame = false
    }

    function getTurn(game, gameID) {
        var opponent = findOpponent(gameID)
        if (opponent === "computer") {
            return true;
        }
        else {
            var gameIDArray = gameID.split(':')
            if (gameIDArray[0] === myUsername) {
                return true;
            }
            else {
                return false;
            }
        }
    }

    function gameStarted(game, gameID) {
        var started = false
        for(var i = 0; i < gamesList.count; i ++) {
            if (gamesList.get(i).game === game && gamesList.get(i).gameID === gameID) {
                if (gamesList.get(i).started){
                    started = true
                    return started;
                }
                else {
                    return started
                }
            }
        }
    }

    function isAccepted(game, gameID) {
        var accepted = false
        for (var i = 0; i < gamesList.count; i ++) {
            if (gamesList.get(i).game === game && gamesList.get(i).gameID === gameID) {
                if (gamesList.get(i).accepted === true) {
                    accepted = true
                }
                else {
                    accepted = false
                }
            }
        }
        console.log("current game is accepted: " + accepted)
        return accepted;
    }

    function isFinished(game, gameID) {
        var finished = false
        if (gameID === "") {
            finished = true
        }
        else {
            for (var i = 0; i < gamesList.count; i ++) {
                if (gamesList.get(i).game === game && gamesList.get(i).gameID === gameID) {
                    if (gamesList.get(i).finished === true) {
                        finished = true
                    }
                    else {
                        finished = false
                    }
                }
            }
        }
        console.log("current game is finished: " + finished)
        return finished;
    }

    function initializeTtt() {
        var opponent = ""
        for (var i = 0; i < gamesList.count; i ++) {
            if (gamesList.get(i).game === "ttt" && gamesList.get(i).gameID !== "" && gamesList.get(i).finished === false) {
                opponent = findOpponent(gamesList.get(i).gameID)
                if (opponent === "computer") {
                    console.log("found ongoing tic tac toe game against computer")
                    tttCurrentGame = gamesList.get(i).gameID
                }
                else {
                    console.log("no ongoing game against computer found")
                }
            }
        }
        if (tttCurrentGame !== "") {
            console.log("loading existing tic tac toe game against computer")
            playGame("ttt", tttCurrentGame)
        }
        else {
            console.log("creating new tic tac toe game against computer")
            tttcreateGameId(myUsername,"computer")
        }
        for (var e = 0; e < tttButtonList.count; e ++) {
            tttButtonList.setProperty(e, "online", false)
        }
    }

    function playGame(game, gameID){
        loadingGame = true
        console.log("initiate load game")
        var player = findOpponent(gameID)
        console.log("opponent: " + player)
        if (game === "ttt") {
            tttCurrentGame = gameID
            console.log("gameID: " + tttCurrentGame)
            tttYourTurn = getTurn(game, gameID)
            console.log("my turn: " + tttYourTurn)
            console.log("loading game")
            tttLoadGame(game, gameID)
            console.log("loading score initiated")
            loadScore(game, player)
            tttHubTracker = 0
            if (tttTracker == 0 && xgamesTracker == 1) {
                tttTracker = 1
            }
        }
    }

    function tttLoadGame(game, gameID) {
        console.log("load ttt game started")
        console.log("reset ttt board")
        var opponent = findOpponent(gameID)
        tttNewGame()
        console.log("setting online/offline")
        for (var e = 0; e < tttButtonList.count; e ++) {
            if (opponent === "computer") {
                tttButtonList.setProperty(e, "online", false)
            }
            else {
                tttButtonList.setProperty(e, "online", true)
            }
        }
        console.log("replay existing moves")
        for (var i = 0; i < movesList.count; i ++) {
            if (movesList.get(i).game === game && movesList.get(i).gameID === gameID) {
                var player = movesList.get(i).player
                var move = movesList.get(i).move
                tttNewMove(player, move)
            }
        }
        console.log("confirming existing moves")
        var lastMove = findLastMoveID(game, gameID)
        for (var o = 0; o < movesList.count; o ++) {
            if (movesList.get(o).game === game && movesList.get(o).gameID === gameID && movesList.get(o).moveID !== lastMove) {
                var number = (Number.fromLocaleString(movesList.get(o).move) - 1)
                tttButtonList.setProperty(number, "confirmed", true)
            }
        }
    }

    function getScore(player, game, result) {
        var score = 0
        for (var i = 0; i < scoreList.count; i ++) {
            if (scoreList.get(i).player === player && scoreList.get(i).game === game) {
                if (result === "win") {
                    score = scoreList.get(i).win
                }
                if (result === "lost") {
                    score = scoreList.get(i).lost
                }
                if (result === "draw") {
                    score = scoreList.get(i).draw
                }
            }
        }
        return score;
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
            userSettings.btc = settingsLoaded.btc === "true";
            userSettings.eth = settingsLoaded.eth === "true";
            userSettings.sound = settingsLoaded.sound;
            userSettings.volume = settingsLoaded.volume;
            userSettings.systemVolume = settingsLoaded.systemVolume;
            userSettings.tagMe = settingsLoaded.tagMe !== undefined? settingsLoaded.tagMe === "true" : true;
            userSettings.tagEveryone = settingsLoaded.tagEveryone !== undefined? settingsLoaded.tagEveryone === "true" : true
            userSettings.xChatDND = settingsLoaded.xChatDND !== undefined? settingsLoaded.xChatDND === "true" : false
            userSettings.showBalance = settingsLoaded.showBalance !== undefined? settingsLoaded.showBalance === "true" : true
            coinList.setProperty(0, "active", userSettings.xfuel);
            coinList.setProperty(1, "active", userSettings.xby);
            coinList.setProperty(2, "active", userSettings.xtest);
            coinList.setProperty(3, "active", userSettings.btc);
            coinList.setProperty(4, "active", userSettings.eth);
        }
    }

    function loadTransactions(transactions){
        if (typeof transactions !== "undefined") {
            historyList.clear();
            var obj = JSON.parse(transactions);
            for (var i in obj){
                var data = obj[i];
                historyList.append(data);
            }
        }
    }

    function loadTransactionAddresses(inputs, outputs){
        if (typeof inputs !== "undefined") {
            inputAddresses.clear();
            var objInput = JSON.parse(inputs);
            for (var i in objInput){
                var dataInput = objInput[i];
                inputAddresses.append(dataInput);
            }
        }
        if (typeof outputs !== "undefined") {
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

        for (var i = 0; i < walletList.count; i ++){
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

        for (var i = 0; i < walletList.count; i ++){
            dataModelWallet.push(walletList.get(i))
        }
        for (var e = 0; e < addressList.count; e ++){
            datamodelAddress.push(addressList.get(e))
        }
        for (var o = 0; o < contactList.count; o ++){
            datamodelContact.push(contactList.get(o))
        }
        for (var u = 0; u < pendingList.count; u ++){
            if (pendingList.get(u).value !== "confirmed" && pendingList.get(u).value !== "rejected") {
                datamodelPending.push(pendingList.get(u))
            }
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

    function  etList() {
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
            if (favorite === true) {
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

        for (var i = 0; i < walletList.count; i ++){
            dataModelWallet.push(walletList.get(i))
        }
        for (var e = 0; e < addressList.count; e ++){
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
        userSettings.tagMe = true
        userSettings.tagEveryone = true
        userSettings.xChatDND = false
        userSettings.showBalance = true
    }

    function initialiseLists() {
        addressList.append({"contact": 0, "address": "", "label": "", "logo": '', "coin": "", "favorite": 0, "active": false, "uniqueNR": 0, "remove": true})

        contactList.append({"firstName": "", "lastName": "", "photo": '', "telNR": "", "cellNR": "", "mailAddress": "", "chatID": "", "favorite": false, "active": false, "contactNR": 0, "remove": true})

        walletList.append({"name": "", "label": "", "address": "", "privatekey" : "", "publickey" : "" ,"balance" : 0, "unconfirmedCoins": 0, "active": false, "favorite": false, "viewOnly" : false, "walletNR": 0, "remove": true})

    }

    // loggin out
    function logOut() {
        xChatTypingSignal(myUsername,"addToOnline", "offline");
        updateToAccount()
    }

    // check for user interaction
    function detectInteraction() {
        inActive = false;
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
            checkingSessionID = false
            if (sessionAlive === "false" && goodbey == 0 && manualLogout == 0 && autoLogout == 0) {
                console.log("session ID check failed")
                networkLogout = 1
                logoutTracker = 1
                sessionStart = 0
                sessionClosed = 1
            }
            else if (sessionAlive === "no_internet") {
                console.log("session ID check - no internet")
            }
            else if (sessionAlive == "no_response") {
                console.log("session ID check - no response")
            }
            else {
                console.log("session ID check passed")
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

        onNoInternet: {
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
                transactionDetailsCollected = true
            }
        }

        onUpdateBalance: {
            updateBalance(coin, address, balance)
        }

        onWalletChecked: {
            explorerBusy = false
        }

        onTxidExists: {
            updatePending(coin, address, txid, result)
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
            if (inActive == false) {
                timerCount = timerCount + 1
                if (timerCount == 4) {
                    balanceCheck = "all"
                    timerCount = 0
                }
                else {
                    balanceCheck = "xby"
                }

                //clearWalletList()
                var datamodelWallet = []
                for (var i = 0; i < walletList.count; ++i) {
                    if (walletList.get(i).remove === false) {
                        datamodelWallet.push(walletList.get(i))
                    }
                };
                var walletListJson = JSON.stringify(datamodelWallet)
                explorerBusy = true
                updateBalanceSignal(walletListJson, balanceCheck);
            }
        }

        onDetailsCollected: {
            explorerBusy = false
        }
        onNoInternet: {
            explorerBusy = false
        }
    }

    Connections {
        target: xGames

        // X-GAME related functions
        onNewMoveReceived: {
            gameError = 0
            if(isMyGame(gameID) && correctUser(player, gameID)) {
                checkIfMoveExists(game, gameID, player, move, moveID)
            }
        }

        onNewMoveConfirmed: {
            gameError = 0
            if(isMyGame(gameID) && correctUser(player, gameID) && player !== myUsername) {
                confirmMove(game, gameID, move, moveID)
            }
        }

        onNewGameInvite: {
            gameError = 0
            if(isMyGame(gameID) && player1 !== myUsername) {
                if (correctUser(player2, gameID)) {
                    checkIfInviteExists(game, gameID)
                }
            }
        }

        onResponseGameInvite: {
            gameError = 0
            if(isMyGame(gameID) && correctUser(user, gameID) && user !== myUsername ) {
                acceptGameInvite(user, game, gameID, accept)
            }
        }

        onGameCommandFailed: {
            gameError = 1
        }
    }

    Connections {
        target: xChat

        onXchatSuccess: {
            addMessageToThread.sendMessage({"author": author, "date": date, "time": time, "device": device, "msg": message, "link": link, "image": image, "quote": quote, "msgID": msgID, "me": myUsername.trim(), "tagMe": userSettings.tagMe, "tagEveryone": userSettings.tagEveryone, "dnd": userSettings.xChatDND})
        }

        onXchatConnectionSuccess: {
            networkError = 0
            networkAvailable = 1
            gameError = 0
            if (xChatConnection == false) {
                xChatConnection = true
                xChatDisconnected = false
                xChatConnecting = false
                if (!pingingXChat) {
                    pingTimeRemain = -1
                    pingingXChat = true
                    resetServerUpdateStatus();
                    pingXChatServers();
                    updateServerStatus();
                }
            }
        }

        onXchatConnectionFail: {
            xChatConnection = false
            xChatConnecting = false
            xChatDisconnected = true
        }

        onXchatConnecting: {
            networkError = 0
            networkAvailable = 1
            xChatDisconnected = false
            xChatConnection = false
            xChatConnecting = true
        }

        onXchatStateChanged: {
            if(!xChatConnection) {
                resetServerUpdateStatus();
                updateServerStatus();
            }
        }

        onXchatNoInternet: {
            networkError = 1
            networkAvailable = 0
            resetServerUpdateStatus();
            updateServerStatus();
        }

        onXchatInternetOk: {
            networkAvailable = 1
        }

        onOnlineUsersSignal:{
            loadOnlineUsers(online)
        }
        onClearOnlineNodeList: {
            xChatServers.clear()
        }

        onServerResponseTime: {
            updateServerResponseTime(server, responseTime, serverStatus)
        }

        onSelectedXchatServer: {
            selectedXChatServer = server
            checkingXchat = false
            pingingXChat = false
            pingTimeRemain = 60
        }

        onXChatServerDown: {
            for (var i = 0; i < xChatServers.count; i ++) {
                if (server === xChatServers.get(i).name) {
                    xChatServers.setProperty(i, "serverStatus", serverStatus)
                }
            }
        }

        onXchatResponseSignal: {
            if (pingTracker != 1){
                var t = new Date().toLocaleString(Qt.locale(),"hh:mm:ss .zzz")
                console.log("replyTime: " + t)
                var a = text
                var b = a.split(' ')
                if (b[0] === "dicom") {
                    xPingTread.append({"message": text, "inout": "in", "author": "staticNet", "time": t})
                }
                if (b[0] === "backend") {
                    xPingTread.append({"message": text, "inout": "in", "author": "XCITE", "time": t})
                }
            }
        }
    }

    Connections {
        target: broker
        onSelectedXchatServer: {
            selectedXChatServer = server
        }

        onXchatConnectionSuccess: {
            networkError = 0
            networkAvailable = 1
            gameError = 0
            if (xChatConnection == false) {
                xChatConnection = true
                xChatDisconnected = false
                xChatConnecting = false
                if (!pingingXChat) {
                    pingTimeRemain = -1
                    pingingXChat = true
                    resetServerUpdateStatus();
                    pingXChatServers();
                    updateServerStatus();
                }
            }
        }

        onXchatConnectionFail: {
            xChatConnection = false
            xChatConnecting = false
            xChatDisconnected = true
        }


        onXchatInternetOk: {
            networkAvailable = 1
        }

    }

    Connections {
        target: tictactoe

        onGameFinished: {
            console.log("game finished")
            var opponent = findOpponent(tttCurrentGame)
            for (var i = 0; i < tttButtonList.count; i ++) {
                tttButtonList.setProperty(i, "played", true)
            }
            for (var o = 0; o < gamesList.count; o ++) {
                if (gamesList.get(o).game === "ttt" && gamesList.get(o).gameID === tttCurrentGame) {
                    gamesList.setProperty(o, "finished", true)
                    if (opponent === "computer") {
                        removeGame("ttt", tttCurrentGame)
                    }
                }
            }
            if (loadingGame === false) {
                if(result === "win") {
                    console.log("you win")
                    updateScore("ttt", opponent, 1, 0, 0)
                }
                else if (result === "loose") {
                    console.log("you loose")
                    updateScore("ttt", opponent, 0, 1, 0)
                }
                else if (result === "draw") {
                    console.log("it's a draw")
                    updateScore("ttt", opponent, 0, 0, 1)
                }
            }
            loadScore("ttt", tttPlayer)
            tttFinished = true
            tttCurrentGame = ""
        }

        onPlayersChoice: {
            console.log("player's choice: " + btn1)
            for (var i = 0; i < tttButtonList.count; i ++) {
                if (tttButtonList.get(i).number === btn1) {
                    tttButtonList.setProperty(i, "player", myUsername)
                    tttButtonList.setProperty(i, "played", true)
                }
            }
        }

        onOpponentsChoice: {
            console.log("opponent's choice: " + btn2)
            var opponent = findOpponent(tttCurrentGame)
            for (var i = 0; i < tttButtonList.count; i ++) {
                if (tttButtonList.get(i).number === btn2) {
                    tttButtonList.setProperty(i, "player", opponent)
                    tttButtonList.setProperty(i, "played", true)
                }
            }
        }

        onComputersChoice: {
            console.log("computer's choice: " + btn2)
            var opponent = findOpponent(tttCurrentGame)
            for (var i = 0; i < tttButtonList.count; i ++) {
                if (tttButtonList.get(i).number === btn2) {
                    tttButtonList.setProperty(i, "player", "opponent")
                    tttButtonList.setProperty(i, "played", true)
                }
            }
            if (opponent === "computer") {
                checkIfMoveExists("ttt", tttCurrentGame, "computer", btn2, moveID)
                confirmMove("ttt", tttCurrentGame, btn2, moveID)
            }
        }

        onBlockButton: {
        }

        onClearBoard: {
            var opponent = findOpponent(tttCurrentGame)
            for (var i = 0; i < tttButtonList.count; i ++) {
                tttButtonList.setProperty(i, "online", false)
                tttButtonList.setProperty(i, "played", false)
                tttButtonList.setProperty(i, "player", "")
                tttButtonList.setProperty(i, "confirmed", false)
            }
            if (opponent === "computer" && loadingGame === false) {
                console.log("removing moves for game against computer from movesList")
                for (var o = 0; o < movesList.count; o ++) {
                    if (movesList.get(o).game === "ttt" && movesList.get(o).gameID === tttCurrentGame) {
                        movesList.remove(o, 1)
                    }
                }
            }
            console.log("board cleared")
        }

        onGameQuit: {
            for (var i = 0; i < tttButtonList.count; i ++) {
                tttButtonList.setProperty(i, "online", false)
                tttButtonList.setProperty(i, "played", false)
                tttButtonList.setProperty(i, "player", "")
                tttButtonList.setProperty(i, "confirmed", false)
            }
        }

        onNewGameID: {
            console.log("new gameID: " + gameID)
            var gameIDArray = gameID.split(':')
            var opponent = gameIDArray[1]
            gamesList.append({"game": "ttt", "gameID": gameID, "invited": false, "accepted": false, "started": false, "finished": false})
            if (opponent !== "computer") {
                sendGameInvite(myUsername, opponent, "ttt", gameID)
                inviteSent("ttt", gameID)
            }
            else {
                for (var i = 0; i < gamesList.count; i ++) {
                    if (gamesList.get(i).game === "ttt" && gamesList.get(i).gameID === gameID) {
                        gamesList.setProperty(i, "invited", true)
                        gamesList.setProperty(i, "accepted", true)
                    }
                }
                if (tttTracker == 0 && xgamesTracker == 1) {
                    tttCurrentGame = gameID
                    playGame("ttt", tttCurrentGame)
                    tttYourTurn = true
                    tttTracker = 1
                }
            }
        }

        onNewMoveID: {
            checkIfMoveExists("ttt", tttCurrentGame, myUsername, move, moveID)
            tttButtonClicked(move)
            confirmMove("ttt", tttCurrentGame, move, moveID)
        }

        onYourTurn: {
            console.log("your turn: " + turn)
            tttYourTurn = turn
        }
    }

    Connections {
        target: Qt.application

        onStateChanged: {
            if (Qt.application.state === Qt.ApplicationActive) {
                inActive = false
                checkSessionId()
                //   xChatReconnect();
                status = "online";
                marketValueTimer.restart()
                explorerTimer1.restart()
                loginTimer.restart()
                networkTimer.restart()
                findAllMarketValues()
                var datamodelWallet = []

                for (var i = 0; i < walletList.count; i ++) {
                    datamodelWallet.push(walletList.get(i))
                };
                var walletListJson = JSON.stringify(datamodelWallet)
                updateBalanceSignal(walletListJson, "all");
                checkingSessionID = false
            }
            else {
                inActive = true
                if (Qt.application.state === Qt.ApplicationSuspended) {
                    status = "offline"
                }
                else {
                    status = "idle"
                }
            }
            xChatTypingSignal(myUsername,"addToOnline", status);
        }
    }

    Connections {
        target: StaticNet

        onTxSuccess: {
            for (var i = 0; i < transactionList.count; i ++) {
                if (transactionList.get(i).requestID === id) {
                    transactionList.setProperty(i, "txid", msg)
                    var b = ""
                    var j = ""
                    for (var a = 0; a < walletList.count; a ++ ) {
                        if (walletList.get(a).name === transactionList.get(i).coin && walletList.get(a).address === transactionList.get(i).address) {
                            b = walletList.get(a).label
                            j = walletList.get(a).address
                        }
                    }
                    if (b === "") {
                        b = transactionList.get(i).address
                    }
                    var c = ""
                    for (var e = 0; e < addressList.count; e ++ ) {
                        if (addressList.get(e).coin === transactionList.get(i).coin && addressList.get(e).address === transactionList.get(i).receiver) {
                            if(addressList.get(e).fullName !== undefined) {
                                c = addressList.get(e).fullName + " " + addressList.get(e).label
                            }
                            else {
                                c= addressList.get(e).label
                            }
                        }
                    }
                    if (c === "") {
                        c = transactionList.get(i).receiver
                    }

                    var h = Number(transactionList.get(i).amount).toLocaleString(Qt.locale("en_US"))
                    var l = transactionList.get(i).amount
                    var k = Number(transactionList.get(i).fee).toLocaleString(Qt.locale("en_US"))
                    var m = transactionList.get(i).used
                    var o = Number(transactionList.get(i).used).toLocaleString(Qt.locale("en_US"))
                    pendingList.append({"coin": transactionList.get(i).coin, "address": j, "txid": msg, "amount": l, "used": m, "value": "false", "check": 0})
                    updatePendingTracker = 1
                    var d = "Accepted transaction of " + h + transactionList.get(i).coin + " (fee: " + k + transactionList.get(i).coin + ") to " + c
                    alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : d, "origin" : "STATIC-net", "remove": false})
                    alert = true
                    notification.play()
                    updatePendingTracker = 0
                    updateToAccount()
                }
            }
        }

        onTxFailed: {
            for (var i = 0; i < transactionList.count; i ++) {
                if (transactionList.get(i).requestID === id) {
                    var b = ""
                    for (var a = 0; a < walletList.count; a ++ ) {
                        if (walletList.get(a).name === transactionList.get(i).coin && walletList.get(a).address === transactionList.get(i).address) {
                            b = walletList.get(a).label
                        }
                    }
                    if (b === "") {
                        b = transactionList.get(i).address
                    }
                    var c = ""
                    for (var e = 0; e < addressList.count; e ++ ) {
                        if (addressList.get(e).coin === transactionList.get(i).coin && addressList.get(e).address === transactionList.get(i).receiver) {
                            if(addressList.get(e).fullName !== undefined) {
                                c = addressList.get(e).fullName + " " + addressList.get(e).label
                            }
                            else {
                                c= addressList.get(e).label
                            }
                        }
                    }
                    if (c === "") {
                        c = transactionList.get(i).receiver
                    }
                    var h = Number(transactionList.get(i).amount).toLocaleString(Qt.locale("en_US"))
                    var l = transactionList.get(i).amount
                    var d = "Rejected transaction of " + h + " " + transactionList.get(i).coin + " to " + c
                    alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : d, "origin" : "STATIC-net", "remove": false})
                    alert = true
                    notification.play()
                }
            }
        }

        onReturnQueue: {
            queueName = queue_
        }
    }

    // Workerscripts

    WorkerScript {
        id: addMessageToThread
        source:'qrc:/Controls/+mobile/addMessage.js'

        onMessage: {
            var playNotif = false
            for (var b = 0; b < xChatUsers.count; b ++) {
                if (xChatUsers.get(b).username === messageObject.author) {
                    if (messageObject.msg !== "") {
                        xChatTread.append({"author" : messageObject.author, "device" : messageObject.device, "date" : messageObject.date + " at " + messageObject.time, "message" : messageObject.msg, "ID" : xChatID, "tag": messageObject.tag, "webLink": messageObject.link, "image": messageObject.image, "quote": messageObject.quote, "timeID": messageObject.msgID})
                        xChatID = xChatID + 1
                        if(xChatScrolling) {
                            newMessages = true
                        }

                        if (miniatureTracker == 1 || xchatTracker == 0 || inActive == true) {
                            xchatPopup(messageObject.author, messageObject.msg)
                            if ((myOS !== "android" || myOS !== "ios") && messageObject.author !== myUsername) {
                                playNotif = true
                            }
                        }
                    }
                    if (messageObject.tag === 1 && messageObject.author !== myUsername) {
                        playNotif = true
                        if (xchatTracker == 0 || inActive == true) {
                            alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : messageObject.author + " has mentioned you", "origin" : "X-CHAT", "remove": false})
                            alert = true
                        }
                    }
                    if (messageObject.tag === 2 && messageObject.author !== myUsername) {
                        playNotif = true
                        if (xchatTracker == 0 || inActive == true) {
                            alertList.append({"date" : new Date().toLocaleDateString(Qt.locale("en_US"),"MMMM d yyyy") + " at " + new Date().toLocaleTimeString(Qt.locale(),"HH:mm"), "message" : "An important message for everyone", "origin" : "X-CHAT", "remove": false})
                            alert = true
                        }
                    }
                }
            }
            if (playNotif) {
                notification.play()
                playNotif = false
            }
        }
    }

    // Listmodels

    ListModel {
        id: applicationList
        ListElement {
            name: ""
            icon_white: 'qrc:/icons/mobile/blank_app-icon_white.svg'
            icon_black: 'qrc:/icons/mobile/blank_app-icon_black.svg'
        }
    }

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
            used: 0
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
            remove: false
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

    ListModel {
        id: xChatTread
        ListElement {
            message: ""
            author: ""
            date: ""
            device: ""
            tag: 0
            ID: 0
            webLink: ""
            image: ""
            quote: ""
            timeID: ""
        }
    }

    ListModel {
        id: xChatOnline
        ListElement {
            date: ""
            status: ""
            time: ""
            username:""
            newUser: false
        }
    }

    ListModel {
        id: xChatUsers
        ListElement {
            date: ""
            status: ""
            time: ""
            username:""
            updated: false
        }
    }

    ListModel {
        id: xChatServers
        ListElement {
            name: ""
            responseTime: ""
            serverStatus: "down"
            updated: false
        }
    }

    ListModel {
        id: tttButtonList
        ListElement {
            number: ""
            played: false
            player: ""
            online: false
            confirmed: false
        }
    }

    ListModel {
        id: gamesList
        ListElement {
            game: ""
            gameID: ""
            invited: false
            accepted: false
            started: false
            finished: false
        }
    }

    ListModel {
        id: movesList
        ListElement {
            game: ""
            gameID: ""
            player: ""
            move: ""
            moveID: ""
            confirmed: false
        }
    }

    ListModel {
        id: scoreList
        ListElement {
            game: ""
            player: ""
            win: 0
            lost: 0
            draw: 0
        }
    }

    ListModel {
        id: xPingTread
        ListElement {
            message:""
            inout: ""
            author: ""
            time: ""
        }
    }

    ListModel {
        id: transactionList
        ListElement {
            requestID:""
            txid: ""
            coin: ""
            address: ""
            receiver: ""
            amount: 0
            fee: 0
            used: 0
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
        property bool tagMe: true
        property bool tagEveryone: true
        property bool xChatDND: false
        property bool showBalance: true

        onThemeChanged: {
            darktheme = userSettings.theme == "dark"? true : false
        }

        onXChatDNDChanged: {
            status = userSettings.xChatDND == true? "dnd" : "online"
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
        //id: network
        //handler: wallet
    }

    // sounds
    SoundEffect {
        id: click01
        source: "qrc:/sounds/click_02.wav"
        volume: selectedSystemVolume == 0? 0 : 0.15
    }

    SoundEffect {
        id: notification
        source: userSettings.sound == 0? 'qrc:/sounds/Bonjour.wav' : (userSettings.sound == 1? 'qrc:/sounds/Hello.wav': (userSettings.sound == 2? 'qrc:/sounds/hola.wav' :(userSettings.sound == 3? 'qrc:/sounds/Servus.wav' : 'qrc:/sounds/Szia.wav')))
        volume: selectedVolume == 0? 0 : (selectedVolume == 1? 0.15 : (selectedVolume == 2? 0.4 : 0.75))
    }

    SoundEffect {
        id: succesSound
        source: "qrc:/sounds/Succes.wav"
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
        source: "qrc:/sounds/swipe.wav"
        volume: selectedSystemVolume == 0? 0 : 0.2
    }

    // timers

    Timer {
        id: checkXchatConnection
        interval: 10000
        repeat: true
        running: true

        onTriggered: {
            checkXChatSignal();
        }
    }

    Timer {
        id: xChatConnectingTimer
        interval: 35000
        repeat: true
        running: xChatConnecting === true && inActive == false

        onTriggered: {
            // xChatReconnect()
        }
    }

    Timer {
        id: checkXchatPing
        interval: 1000
        repeat: true
        running: pingTimeRemain > 0 && inActive == false && xchatNetworkTracker == 1

        onTriggered: {
            pingTimeRemain = pingTimeRemain - 1
            if (pingTimeRemain == 0) {
                if (xChatConnection && !pingingXChat) {
                    pingTimeRemain = -1
                    pingingXChat = true
                    resetServerUpdateStatus();
                    pingXChatServers();
                    updateServerStatus();
                    pingingXChat = false
                }
            }
        }
    }

    Timer {
        id: sendXchatConnection
        interval: inActive == false? 60000 : 300000
        repeat: true
        running: true

        onTriggered: {
            xChatTypingSignal(myUsername,"addToOnline", status);
        }
    }

    Timer {
        id: checkIfIdle
        interval: 300000
        repeat: true
        running: inActive == false

        onTriggered: {
            if (userSettings.xChatDND == false) {
                status = "idle"
                xChatTypingSignal(myUsername,"addToOnline", status);
            }
        }
    }

    Timer {
        id: urlCopyTimer
        interval: 2000
        repeat: false
        running: urlCopy2Clipboard == 1

        onTriggered: {
            urlCopy2Clipboard = 0
            url2Copy == ""
        }
    }

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
        running: sessionStart == 1 && inActive == false
        onTriggered:  {
            findAllMarketValues()
        }
    }

    Timer {
        id: explorerTimer1
        interval: inActive == false? 15000 : 30000
        repeat: true
        running: sessionStart == 1
        onTriggered:  {
            var datamodelPending = []
            for (var e = 0; e < pendingList.count; e ++) {
                if(pendingList.get(e).value === "false" || pendingList.get(e).value === "true") {
                    if (pendingList.get(e).value === "false") {
                        var checks = pendingList.get(e).check
                        pendingList.setProperty(e, "check", checks + 1)
                    }

                    datamodelPending.push(pendingList.get(e))
                }
            };
            var pendingListJson = JSON.stringify(datamodelPending)

            if (explorerBusy == false) {
                checkTxStatus(pendingListJson);
            };
        }
    }

    Timer {
        id: loginTimer
        interval: 30000
        repeat: true
        running: sessionStart == 1 && inActive == false

        onTriggered: {
            if (interactionTracker == 1) {
                sessionTime = 0
                interactionTracker = 0
            }
            else {
                sessionTime = sessionTime +1
                if (sessionTime >= 10){
                    sessionTime = 0
                    status = "idle"
                    inActive = true
                    xChatTypingSignal(myUsername,"addToOnline", status);
                }
            }
        }
    }

    Timer {
        id: networkTimer
        interval: 60000
        repeat: true
        running: sessionStart == 1 && inActive == false

        onTriggered: {
            if (checkingSessionID == false) {
                checkingSessionID = true
                console.log("checking session ID")
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
        anchors.fill: parent
        initialItem:
            Component{
            MediaPlayer {
                id: introSound
                source: "qrc:/sounds/intro_01.wav"
                volume: 1
                autoPlay: true
            }
        }
    }

    // native back button
    onClosing: {
        if (mainRoot.depth > 1) {
            close.accepted = false
            backButtonPressed()
        }
    }
}
