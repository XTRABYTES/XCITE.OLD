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

    id: xcite

    property bool isNetworkActive: false
    property string receivingAddress: "BiJeija103JfjQWpdkl230fjFEI3019JKl"
    property string receivingAddressXFUEL: "F6xCY2wNyE7KwkWcUqeZVTy6WvciHYb5Eq"
    property string receivingAddressBTC: "15q3aKVcrkCYFA3bGYn1uyZzVyHigXra1s"
    property string receivingAddressETH: "0x9de2bb59edc421c141a6ba1253703d2beddc3612"

    property string nameXBY: "XBY"
    property string labelXBY: "Main"
    property real balanceXBY: wallet.balance
    property real unconfirmedXBY: 0
    property real valueXBY: marketValue.marketValue
    property real btcValueXBY: 0.00000475
    property real percentageXBY: 23.47

    property string nameXFUEL: "XFUEL"
    property string labelXFUEL: "Main"
    property real balanceXFUEL: 35948.35946158 // xfuelwallet.balance
    property real unconfirmedXFUEL: 0
    property real valueXFUEL: (valueXBY * 0.8)
    property real btcValueXFUEL: 0.00000475
    property real percentageXFUEL: 23.47

    property string nameBTC: "BTC"
    property string labelBTC: "Main"
    property real balanceBTC: 2.649232654 // btcwallet.balance
    property real unconfirmedBTC: 0.3658
    property real valueBTC: 6660
    property real btcValueBTC: 1
    property real percentageBTC: 0.59

    property string nameETH: "ETH"
    property string labelETH: "Main"
    property real balanceETH: 0 // ethwallet.balance
    property real unconfirmedETH: 0
    property real valueETH: 226.03
    property real btcValueETH: 0.03451249
    property real percentageETH: -2.36

    property string address2: "BM39fjwf093JF329f39fJFfa03987fja32"
    property string name2: "Posey"

    property string address3: "Bx33fjwf023JxoP9f39fJFfa0398wqWeJ9"
    property string name3: "Nrocy"

    property string address4: "F2o3fjwf02WIKoP9f3wxvmJFfa03wqWexc"
    property string name4: "Enervey"

    property string address5: "Fkf3019jzmkFAJowaj392JAFAlafj032jJ"
    property string name5: "Danny"

    property int appsTracker: 0
    property int transferTracker: 0
    property int addressTracker: 0
    property int addAddressTracker: 0
    property int addCoinTracker: 0
    property int picklistTracker: 0
    property int newCoinPicklist: 0
    property int newCoinSelect: 0
    property int addressbookTracker: 0
    property int tradingTracker: 0
    property int balanceTracker: 0
    property string selectedAddress: ""
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
    property int btcTXID: 1
    property int ethTXID: 1
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

    Settings {
        id: settings
        property string locale: "en_us"
        property string defaultCurrency: "USD"
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
        id: btcTXHistory
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
        id: ethTXHistory
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

    Component.onCompleted: {

        onMarketValueChanged("USD")

        currencyList.setProperty(0, "name", "XBY");
        currencyList.setProperty(0, "label", "Main");
        currencyList.setProperty(0, "logo", '../icons/XBY_card_logo_colored_05.svg');
        currencyList.setProperty(0, "address", receivingAddress);
        currencyList.setProperty(0, "balance", balanceXBY);
        currencyList.setProperty(0, "unconfirmedCoins", unconfirmedXBY);
        currencyList.setProperty(0, "coinValue", valueXBY);
        currencyList.setProperty(0, "coinValueBTC", btcValueXBY);
        currencyList.setProperty(0, "percentage", percentageXBY);
        currencyList.setProperty(0, "fiatValue", (balanceXBY * valueXBY));
        currencyList.setProperty(0, "active", 1);
        currencyList.setProperty(0, "favorite", 1);
        currencyList.setProperty(0, "walletNR", walletID);
        walletID = walletID +1;
        currencyList.append({"name": "XFUEL", "label": "Main", "logo": '../icons/XFUEL_card_logo_colored_07.svg', "address": receivingAddressXFUEL, "balance" : balanceXFUEL, "unconfirmedCoins": unconfirmedXFUEL, "coinValue": valueXFUEL, "coinValueBTC": btcValueXFUEL, "percentage": percentageXFUEL, "fiatValue": (balanceXFUEL * valueXFUEL), "active": 1, "favorite": 0, "walletNR": walletID});
        walletID = walletID +1;
        currencyList.append({"name": "BTC", "label": "Main", "logo": '../icons/BTC-color.svg', "address": receivingAddressBTC, "balance" : balanceBTC, "unconfirmedCoins": unconfirmedBTC, "coinValue": valueBTC, "coinValueBTC": btcValueBTC, "percentage": percentageBTC, "fiatValue": (balanceBTC * valueBTC), "active": 0, "favorite": 0, "walletNR": walletID});
        walletID = walletID +1;
        currencyList.append({"name": "ETH", "label": "Main", "logo": '../icons/ETH-color.svg', "address": receivingAddressETH, "balance" : balanceETH, "unconfirmedCoins": unconfirmedETH, "coinValue": valueETH, "coinValueBTC": btcValueETH, "percentage": percentageETH, "fiatValue": (balanceETH * valueETH), "active": 0, "favorite": 0, "walletNR": walletID});
        walletID = walletID +1;

        addressList.append({"address": receivingAddress, "name": "My XBY address", "logo": (currencyList.get(0).logo), "coin": (currencyList.get(0).name), "favorite": 1, "active": true, "uniqueNR": addressID});
        addressID = addressID + 1;
        addressList.append({"address": receivingAddressXFUEL, "name": "My XFUEL address", "logo": (currencyList.get(1).logo), "coin": (currencyList.get(1).name), "favorite": 1, "active": true, "uniqueNR": addressID});
        addressID = addressID + 1;
        addressList.append({"address": receivingAddressBTC, "name": "My BTC address", "logo": (currencyList.get(2).logo), "coin": (currencyList.get(2).name), "favorite": 1, "active": true, "uniqueNR": addressID});
        addressID = addressID + 1;
        addressList.append({"address": receivingAddressETH, "name": "My ETH address", "logo": (currencyList.get(3).logo), "coin": (currencyList.get(3).name), "favorite": 1, "active": true, "uniqueNR": addressID});
        addressID = addressID + 1;
        addressList.append({"address": address2, "name": name2, "logo": (currencyList.get(0).logo), "coin": (currencyList.get(0).name), "favorite": 0, "active": true, "uniqueNR": addressID});
        addressID = addressID + 1;
        addressList.append({"address": address3, "name": name3, "logo": (currencyList.get(0).logo), "coin": (currencyList.get(0).name), "favorite": 0, "active": true, "uniqueNR": addressID});
        addressID = addressID + 1;
        addressList.append({"address": address4, "name": name4, "logo": (currencyList.get(1).logo), "coin": (currencyList.get(1).name), "favorite": 0, "active": true, "uniqueNR": addressID});
        addressID = addressID + 1;
        addressList.append({"address": address5, "name": name5, "logo": (currencyList.get(1).logo), "coin": (currencyList.get(1).name), "favorite": 0, "active": true, "uniqueNR": addressID});
        addressID = addressID + 1;

        xbyTXHistory.append ({"date": "09/08", "amount": -36482.65, "txid": "48g48yj48q41tyv1y4", "txpartnerHash": "B2o3fjwf02WIKoP9f3wxvmJFfa03wqWexd", "reference": "merchandise", "txNR": xbyTXID});
        xbyTXID =  xbyTXID + 1;
        xbyTXHistory.append ({"date": "09/13", "amount": 23684, "txid": "4sd89f65d8F48H68eG4", "txpartnerHash": "B2o3fjwf02WIKoP9f3wxvmJFfa03wqWexc", "reference": "cookies", "txNR": xbyTXID});
        xbyTXID =  xbyTXID + 1;
        xbyTXHistory.append ({"date": "09/15", "amount": -3594.23, "txid": "89b488y4rrt1r99FHT1H48q4", "txpartnerHash": "BM39fjwf093JF329f39fJFfa03987fja32f", "reference": "sox", "txNR": xbyTXID});
        xbyTXID =  xbyTXID + 1;
        xbyTXHistory.append ({"date": "09/21", "amount": 6185.59, "txid": "JYT489444B8489tr98y498", "txpartnerHash": "Bx33fjwf023JxoP9f39fJFfa0398wqWeJ9", "reference": "t-shirts", "txNR": xbyTXID});
        xbyTXID =  xbyTXID + 1;

        xfuelTXHistory.append ({"date": "06/21", "amount": -45965.59, "txid": "48g48yj48q41tyv1y4", "txpartnerHash": "B2o3fjwf02WIKoP9f3wxvmJFfa03wqWexd", "reference": "merchandise", "txNR": xfuelTXID});
        xfuelTXID = xfuelTXID + 1;
        xfuelTXHistory.append ({"date": "07/10", "amount": 84494, "txid": "4sd89f65d8F48H68eG4", "txpartnerHash": "B2o3fjwf02WIKoP9f3wxvmJFfa03wqWexc", "reference": "cookies", "txNR": xfuelTXID});
        xfuelTXID = xfuelTXID + 1;
        xfuelTXHistory.append ({"date": "07/14", "amount": 4842.489, "txid": "89b488y4rrt1r99FHT1H48q4", "txpartnerHash": "Bkf3019jzmkFAJowaj392JAFAlafj032jJ", "reference": "sox", "txNR": xfuelTXID});
        xfuelTXID = xfuelTXID + 1;
        xfuelTXHistory.append ({"date": "07/21", "amount": -31856.94, "txid": "JYT489444B8489tr98y498", "txpartnerHash": "Bx33fjwf023JxoP9f39fJFfa0398wqWeJ9", "reference": "t-shirts", "txNR": xfuelTXID});
        xfuelTXID = xfuelTXID + 1;
        xfuelTXHistory.append ({"date": "08/10", "amount": 84494, "txid": "4sd89f65d8F48H68eG4", "txpartnerHash": "B2o3fjwf02WIKoP9f3wxvmJFfa03wqWexc", "reference": "cookies", "txNR": xfuelTXID});
        xfuelTXID = xfuelTXID + 1;
        xfuelTXHistory.append ({"date": "08/14", "amount": 4842.489, "txid": "89b488y4rrt1r99FHT1H48q4", "txpartnerHash": "Bkf3019jzmkFAJowaj392JAFAlafj032jJ", "reference": "sox", "txNR": xfuelTXID});
        xfuelTXID = xfuelTXID + 1;
        xfuelTXHistory.append ({"date": "08/21", "amount": -31856.94, "txid": "JYT489444B8489tr98y498", "txpartnerHash": "Bx33fjwf023JxoP9f39fJFfa0398wqWeJ9", "reference": "t-shirts", "txNR": xfuelTXID});
        xfuelTXID = xfuelTXID + 1;
        xfuelTXHistory.append ({"date": "09/10", "amount": 84494, "txid": "4sd89f65d8F48H68eG4", "txpartnerHash": "B2o3fjwf02WIKoP9f3wxvmJFfa03wqWexc", "reference": "cookies", "txNR": xfuelTXID});
        xfuelTXID = xfuelTXID + 1;
        xfuelTXHistory.append ({"date": "09/14", "amount": 4842.489, "txid": "89b488y4rrt1r99FHT1H48q4", "txpartnerHash": "Bkf3019jzmkFAJowaj392JAFAlafj032jJ", "reference": "sox", "txNR": xfuelTXID});
        xfuelTXID = xfuelTXID + 1;
        xfuelTXHistory.append ({"date": "09/21", "amount": -31856.94, "txid": "JYT489444B8489tr98y498", "txpartnerHash": "Bx33fjwf023JxoP9f39fJFfa0398wqWeJ9", "reference": "t-shirts", "txNR": xfuelTXID});
        xfuelTXID = xfuelTXID + 1;

        btcTXHistory.append ({"date": "08/21", "amount": -2.6563, "txid": "48g48yj48q41tyv1y4", "txpartnerHash": "B2o3fjwf02WIKoP9f3wxvmJFfa03wqWexd", "reference": "merchandise", "txNR": btcTXID});
        btcTXID = btcTXID + 1;
        btcTXHistory.append ({"date": "09/10", "amount": 8.4494, "txid": "4sd89f65d8F48H68eG4", "txpartnerHash": "B2o3fjwf02WIKoP9f3wxvmJFfa03wqWexc", "reference": "cookies", "txNR": btcTXID});
        btcTXID = btcTXID + 1;
        btcTXHistory.append ({"date": "09/14", "amount": 0.4842489, "txid": "89b488y4rrt1r99FHT1H48q4", "txpartnerHash": "BM39fjwf093JF329f39fJFfa03987fja32f", "reference": "sox", "txNR": btcTXID});
        btcTXID = btcTXID + 1;
        btcTXHistory.append ({"date": "09/21", "amount": -3.185694, "txid": "JYT489444B8489tr98y498", "txpartnerHash": "Bx33fjwf023JxoP9f39fJFfa0398wqWeJ9", "reference": "t-shirts", "txNR": btcTXID});
        btcTXID = btcTXID + 1;

    }

    visible: true

    width: Screen.width
    height: Screen.height
    title: qsTr("XCITE")
    color: "#2B2C31"

    overlay.modal: Rectangle {
        color: "#c92a2c31"
    }

    StackView {
        id: mainRoot
        initialItem: DashboardForm {
        }
        anchors.fill: parent
    }

    Clipboard {
        id: clipboard
    }
}
