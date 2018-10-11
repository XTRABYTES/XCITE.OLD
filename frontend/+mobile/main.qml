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
import QtQml 2.11

ApplicationWindow {

    property bool isNetworkActive: false
    property string receivingAddress: "BiJeija103JfjQWpdkl230fjFEI3019JKl"
    property string receivingAddressXFUEL: "F6xCY2wNyE7KwkWcUqeZVTy6WvciHYb5Eq"
    property string receivingAddressBTC: "15q3aKVcrkCYFA3bGYn1uyZzVyHigXra1s"
    property string receivingAddressETH: "0x9de2bb59edc421c141a6ba1253703d2beddc3612"

    property string nameXBY: "XBY"
    property string labelXBY: "MAIN"
    property real balanceXBY: 1268426.36 // wallet.balance
    property real unconfirmedXBY: 0
    property real valueXBY: 0.03587
    property real btcValueXBY: 0.00000475
    property real percentageXBY: 23.47

    property string nameXFUEL: "XFUEL"
    property string labelXFUEL: "MAIN"
    property real balanceXFUEL: 35948.3594 // wallet.balance
    property real unconfirmedXFUEL: 0
    property real valueXFUEL: 0.03587
    property real btcValueXFUEL: 0.00000475
    property real percentageXFUEL: 23.47

    property string nameBTC: "BTC"
    property string labelBTC: "MAIN"
    property real balanceBTC: 2.6492 // wallet.balance
    property real unconfirmedBTC: 0.3658
    property real valueBTC: 6660
    property real btcValueBTC: 1
    property real percentageBTC: 0.59

    property string nameETH: "ETH"
    property string labelETH: "MAIN"
    property real balanceETH: 32.9845 // wallet.balance
    property real unconfirmedETH: 8.3654
    property real valueETH: 226.03
    property real btcValueETH: 0.03451249
    property real percentageETH: -2.36

    id: xcite

    property string address2: "BM39fjwf093JF329f39fJFfa03987fja32"
    property string name2: "Posey"
    property string label2: "Main"

    property string address3: "Bx33fjwf023JxoP9f39fJFfa0398wqWeJ9"
    property string name3: "Nrocy"
    property string label3: "Main"

    property string address4: "B2o3fjwf02WIKoP9f3wxvmJFfa03wqWexc"
    property string name4: "Enervey"
    property string label4: "Main"

    property string address5: "Bkf3019jzmkFAJowaj392JAFAlafj032jJ"
    property string name5: "Danny"
    property string label5: "Main"

    property int appsTracker: 0
    property int transferTracker: 0
    property int addressTracker: 0
    property int addAddressTracker: 0
    property int addCoinTracker: 0
    property int picklistTracker: 0
    property int newCoinPicklist: 0
    property int newCoinSelect: 0
    property int addressIndex: 0
    property int currencyIndex: 0
    property int totalLines: 4
    property int totalAddresses: countAddresses()
    property int totalWallets: countWallets()

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

    ListModel {
        id: addressList
        ListElement {
            address: ""
            name: ""
            label: ""
            logo: ''
            coin: ""
            favorite: 0
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
            favorite: 0
            active: 1
        }
    }

    Component.onCompleted: {

        addressList.setProperty(0, "address", receivingAddress);
        addressList.setProperty(0, "name", "My address");
        addressList.setProperty(0, "label", "MAIN");
        addressList.setProperty(0, "logo", '../icons/XBY_card_logo_colored_05.svg');
        addressList.setProperty(0, "coin", "XBY");
        addressList.setProperty(0, "favorite", 0);
        addressList.append({"address": address2, "name": name2, "label": label2, "logo": '../icons/XBY_card_logo_colored_05.svg', "coin": "XBY", "favorite": 0});
        addressList.append({"address": address3, "name": name3, "label": label3, "logo": '../icons/XBY_card_logo_colored_05.svg', "coin": "XBY", "favorite": 0});
        addressList.append({"address": address4, "name": name4, "label": label4, "logo": '../icons/XFUEL_card_logo_colored_07.svg', "coin": "XFUEL", "favorite": 0});
        addressList.append({"address": address5, "name": name5, "label": label5, "logo": '../icons/XFUEL_card_logo_colored_07.svg', "coin": "XFUEL", "favorite": 0});

        currencyList.setProperty(0, "name", "XBY");
        currencyList.setProperty(0, "label", "MAIN");
        currencyList.setProperty(0, "logo", '../icons/XBY_card_logo_colored_05.svg');
        currencyList.setProperty(0, "address", receivingAddress);
        currencyList.setProperty(0, "balance", balanceXBY);
        currencyList.setProperty(0, "unconfirmedCoins", unconfirmedXBY);
        currencyList.setProperty(0, "coinValue", valueXBY);
        currencyList.setProperty(0, "coinValueBTC", btcValueXBY);
        currencyList.setProperty(0, "percentage", percentageXBY);
        currencyList.setProperty(0, "active", 1);
        currencyList.setProperty(0, "favorite", 0);
        console.log(currencyList.get(0).name);
        currencyList.append({"name": "XFUEL", "label": "MAIN", "logo": '../icons/XFUEL_card_logo_colored_07.svg', "address": receivingAddressXFUEL, "balance" : balanceXFUEL, "unconfirmedCoins": unconfirmedXFUEL, "coinValue": valueXFUEL, "coinValueBTC": btcValueXFUEL, "percentage": percentageXFUEL, "active": 1, "favorite": 0});
        console.log(currencyList.get(1).name);
        currencyList.append({"name": "BTC", "label": "MAIN", "logo": '../icons/BTC-color.svg', "address": receivingAddressBTC, "balance" : balanceBTC, "unconfirmedCoins": unconfirmedBTC, "coinValue": valueBTC, "coinValueBTC": btcValueBTC, "percentage": percentageBTC, "active": 1, "favorite": 0});
        console.log(currencyList.get(2).name);
        currencyList.append({"name": "ETH", "label": "MAIN", "logo": '../icons/ETH-color.svg', "address": receivingAddressETH, "balance" : balanceETH, "unconfirmedCoins": unconfirmedETH, "coinValue": valueETH, "coinValueBTC": btcValueETH, "percentage": percentageETH, "active": 1, "favorite": 0});
        console.log(currencyList.get(3).name);
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
