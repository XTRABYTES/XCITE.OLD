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
        goodbey = 0

        walletID = walletList.count
        contactID = contactList.count
        addressID = addressList.count
        //txID = transactionList.count

        // finish account setup
        if (userSettings.accountCreationCompleted === false) {
            mainRoot.pop()
            mainRoot.push("../InitialSetup.qml")
        }
        // continue to wallet
        else {
            sumBalance()
            sumXBY()
            sumXFUEL()
            sumXTest()
            sumBTC()
            sumETH()
            checkNotifications()
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

           var datamodelWallet = []
            var datamodelPending = []

            for (var i = 0; i < walletList.count; ++i) {
                datamodelWallet.push(walletList.get(i))
            };
            for (var e = 0; e < pendingList.count; ++e) {
                datamodelPending.push(pendingList.get(e))
            };

            var walletListJson = JSON.stringify(datamodelWallet);
            var pendingListJson = JSON.stringify(datamodelPending);

            updateBalanceSignal(walletListJson, "all");
            checkTxStatus(pendingListJson);

            mainRoot.push("../DashboardForm.qml")
            selectedPage = "home"
        }
    }
}
