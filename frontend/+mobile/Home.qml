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
        console.log("walletID: " + walletID + ", contactID: " + contactID + ", addressID: " + addressID + ", txID: " + txID)

        // finish account setup
        if (userSettings.accountCreationCompleted === false) {
            mainRoot.pop()
            mainRoot.push("../InitialSetup.qml")
        }
        // continue to wallet
        else {
            sumBalance()
            mainRoot.push("../DashboardForm.qml")
            selectedPage = "home"
        }
    }
}
