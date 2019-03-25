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
        txID = transactionList.count

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
            sumXBYTest()
            sumXFUELTest()
            sumBTC()
            sumETH()
            checkNotifications()
            marketValueChangedSignal("btcusd")
            marketValueChangedSignal("btceur")
            marketValueChangedSignal("btcgbp")
            marketValueChangedSignal("xbybtc")
            marketValueChangedSignal("xbycha")
            var datamodel = []
            for (var i = 0; i < walletList.count; ++i)
                datamodel.push(walletList.get(i))

            var walletListJson = JSON.stringify(datamodel)
            updateBalanceSignal(walletListJson);
            mainRoot.push("../DashboardForm.qml")
            selectedPage = "home"
        }
    }
}
