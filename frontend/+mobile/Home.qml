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

        if (newAccount == true) {
            userSettings.locale = "en_us"
            userSettings.defaultCurrency = 0
            userSettings.theme = "dark"
            userSettings.pinlock = false
        }

        // workaround until backend connection is provided
        else {
            walletList.append({"name": nameXFUEL1, "label": labelXFUEL1, "address": receivingAddressXFUEL1, "balance" : balanceXFUEL1, "unconfirmedCoins": unconfirmedXFUEL1, "active": true, "favorite": true, "walletNR": walletID, "remove": false});
            walletID = walletID +1;
            walletList.append({"name": nameXBY1, "label": labelXBY1, "address": receivingAddressXBY1, "balance" : balanceXBY1, "unconfirmedCoins": unconfirmedXBY1, "active": true, "favorite": true, "walletNR": walletID, "remove": false});
            walletID = walletID +1;
            walletList.append({"name": nameXFUEL2, "label": labelXFUEL2, "address": receivingAddressXFUEL2, "balance" : balanceXFUEL2, "unconfirmedCoins": unconfirmedXFUEL2, "active": true, "favorite": false, "walletNR": walletID, "remove": false});
            walletID = walletID +1;
        }

        sumBalance()

        // open wallet view
        if (userSettings.accountCreationCompleted === false) {
            mainRoot.pop()
            mainRoot.push("../InitialSetup.qml")
        }
        else {
            mainRoot.push("../DashboardForm.qml")
            selectedPage = "home"
        }
    }
}
