import QtQuick 2.0
import QtQuick.Window 2.2

Item {

    id: homepageLoader
    width: Screen.width
    height: Screen.Height

    Rectangle {
        anchors.fill: parent
        color: "#42454F"
    }

    Component.onCompleted: {
        //load settings
        // workaround until backend connection is provided
        userSettings.locale = "en_us"
        userSettings.defaultCurrency = 0
        userSettings.theme = "dark"
        userSettings.pincode = "1234"
        userSettings.pinlock = true

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

        loadWalletList()

        // workaround until backend connection is provided
        walletList.setProperty(0, "name", nameXFUEL1);
        walletList.setProperty(0, "label", labelXFUEL1);
        walletList.setProperty(0, "address", receivingAddressXFUEL1);
        walletList.setProperty(0, "balance", balanceXFUEL1);
        walletList.setProperty(0, "unconfirmedCoins", unconfirmedXFUEL1);
        walletList.setProperty(0, "active", true);
        walletList.setProperty(0, "favorite", true);
        walletList.setProperty(0, "walletNR", walletID);
        walletList.setProperty(0, "remove", false);
        walletID = walletID +1;
        walletList.append({"name": nameXBY1, "label": labelXBY1, "address": receivingAddressXBY1, "balance" : balanceXBY1, "unconfirmedCoins": unconfirmedXBY1, "active": true, "favorite": true, "walletNR": walletID, "remove": false});
        walletID = walletID +1;
        walletList.append({"name": nameXFUEL2, "label": labelXFUEL2, "address": receivingAddressXFUEL2, "balance" : balanceXFUEL2, "unconfirmedCoins": unconfirmedXFUEL2, "active": true, "favorite": false, "walletNR": walletID, "remove": false});
        walletID = walletID +1;

        addOwnContact();

        loadContactList();
        loadAddressList();

        addWalletsToAddressList();

        sumBalance()

        mainRoot.push("../DashboardForm.qml")
        selectedPage = "home"
    }

    Timer {
        id: timer
        interval: 3000
        repeat: true
        running: true

        onTriggered: sumBalance()
    }
}
