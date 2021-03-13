import QtQuick.Controls 2.3
import QtQuick 2.7
import QtGraphicalEffects 1.0
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
        color: "#14161B"

        Label {
            id: loadingLabel
            text: "LOADING ..."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: appHeight/24
            font.family: xciteMobile.name
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.letterSpacing: 2
        }
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
            if (myOS === "ios" || myOS === "android") {
                mainRoot.push("qrc:/+mobile/InitialSetup.qml")
            }
            else {
                mainRoot.push("qrc:/+desktop/InitialSetup.qml")
            }
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

            //reset checks for pendinglist to 0
            if (pendingList.count > 0) {
                for (var o = 0; o < pendingList.count; ++o) {
                    pendingList.setProperty(o, "checks", 0)
                }
            }

            var datamodelWallet = []
            var datamodelPending = []

            if (walletList.count !== 0) {
                for (var i = 0; i < walletList.count; ++i) {
                    if (walletList.get(i).remove === false) {
                        datamodelWallet.push(walletList.get(i))
                    }
                };
                for (var e = 0; e < pendingList.count; ++e) {
                    datamodelPending.push(pendingList.get(e))
                };

                var walletListJson = JSON.stringify(datamodelWallet);
                var pendingListJson = JSON.stringify(datamodelPending);

                updateBalanceSignal(walletListJson, "all");
                checkTxStatus(pendingListJson);
            }

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
            if (myOS == "android" || myOS == "ios") {
                mainRoot.push("qrc:/+mobile/DashboardForm.qml")
            }
            else {
                mainRoot.push("qrc:/+desktop/DashboardForm.qml")
            }

        }
    }
}
