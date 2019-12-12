import QtQuick 2.0
import QtQuick.Window 2.2

Item {

    id: homepageLoader
    width: appWidth
    height: appHeight
    anchors.horizontalCenter: xcite.horizontalCenter
    anchors.verticalCenter: xcite.verticalCenter
    visible: false

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
            selectedPage = "initialSetup"
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
            findAllMarketValues()

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

            if (!checkingXchat){
                checkingXchat = true
                checkXChatSignal();
            }

            if (xChatConnection && !pingingXChat) {
                pingingXChat = true
                resetServerUpdateStatus();
                pingXChatServers();
                updateServerStatus();
                pingingXChat = false
            }

            xChatTypingSignal(myUsername,"addToOnline", status)

            selectedPage = "home"
            mainRoot.push("../DashboardForm.qml")
        }
    }
}
