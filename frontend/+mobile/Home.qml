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
        // load settings

        // load wallets
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

        // load contacts from account
        loadContactList();


        // load addresses from account
        loadAddressList();

        // add own wallets to addresslist
        addWalletsToAddressList();

        // load transaction history from account
        loadHistoryList()

        // calculate total balance for all wallets
        sumBalance()

        // open wallet view
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
