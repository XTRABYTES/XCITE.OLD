import QtQuick 2.0
import QtQuick.Window 2.2

Item {

    id: homepageLoader
    width: Screen.width
    height: Screen.Height

    Component.onCompleted: {
        onMarketValueChanged("USD")

        coinList.setProperty(0, "name", nameXFUEL);
        coinList.setProperty(0, "logo", 'qrc:/icons/XFUEL_card_logo_01.svg');
        coinList.setProperty(0, "coinValueBTC", btcValueXFUEL);
        coinList.setProperty(0, "percentage", percentageXFUEL);
        coinList.setProperty(0, "totalBalance", 0);
        coinList.setProperty(0, "active", true);
        coinList.setProperty(0, "coinID", coinIndex);
        coinIndex = coinIndex +1;
        coinList.append({"name": nameXBY, "logo": 'qrc:/icons/XBY_card_logo_01.svg', "coinValueBTC": btcValueXBY, "percentage": percentageXBY, "totalBalance": 0, "active": true, "coinID": coinIndex});
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

        loadContactList ();

        addWalletsToAddressList();

        sumBalance()
    }

    Rectangle {
        anchors.fill: parent
        color: "#14161B"
    }

    Timer {
        id: timer
        interval: 3000
        repeat: true
        running: loginTracker == 1

        onTriggered: sumBalance()
    }

    DashboardForm {
        id: dashBoard
        visible: loginTracker == 1
        state: loginTracker == 0? "off" : "on"

        states: [
                State {
                    name: "on"
                    PropertyChanges { target: dashBoard; opacity: 1 }
                },
                State {
                    name: "off"
                    PropertyChanges { target: dashBoard; opacity: 0 }
                }
        ]

        transitions: Transition {
                NumberAnimation { target: dashBoard; properties: "opacity"; duration: 500; easing.type: Easing.OutCubic}
        }
    }
}
