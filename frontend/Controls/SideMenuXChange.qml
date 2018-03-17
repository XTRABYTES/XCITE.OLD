import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "../Theme" 1.0

Rectangle {
    property string selectedView
    property string selectedModule

    Connections {
        target: dashboard
        onSelectView: {
            var parts = path.split('.')

            selectedModule = parts[0]
            selectedView = path
        }
    }

    color: Theme.panelBackground

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: moduleMenuHeight + 7
        spacing: 0

        //        Label {
        //            text: xcite.width + "," + xcite.height
        //        }
        SideMenuButton {
            name: "xChange.home"
            visible: selectedModule === 'xChange'
            imageSource: "../icons/menu-home.svg"
            labelText: qsTr("HOME")
            size: 32
        }

        SideMenuButton {
            name: "xChange.openOrders"
            visible: selectedModule === 'xChange'
            imageSource: "../icons/icon-open-orders.svg"
            labelText: qsTr("OPEN\nORDERS")

            size: 25
        }

        SideMenuButton {
            name: "xChange.orderHistory"
            visible: selectedModule === 'xChange'
            imageSource: "../icons/icon-order-history.svg"
            labelText: qsTr("ORDER\nHISTORY")

            size: 25
        }

        SideMenuButton {
            name: "xChange.marketTrades"
            visible: selectedModule === 'xChange'
            imageSource: "../icons/icon-market-trades.svg"
            labelText: qsTr("MARKET\nTRADES")
            size: 28
        }

        SideMenuButton {
            name: "xChange.orderBooks"
            visible: selectedModule === 'xChange'
            imageSource: "../icons/menu-history.svg"
            labelText: qsTr("ORDER\nBOOKS")
            size: 30
        }
    }

    ColumnLayout {
        visible: xcite.height > 600
        width: parent.width
        Layout.fillHeight: true
        Layout.minimumHeight: 200
        Layout.preferredHeight: 200
        anchors.bottomMargin: 32.5
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        spacing: 25

        SideMenuButton {
            name: "xCite.settings"
            imageSource: "../icons/menu-settings.svg"
            labelText: qsTr("SETTINGS")
            size: 32
        }

        ButtonIcon {
            id: wifiButton
            imageSource: "../icons/wifi.svg"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            isSelected: xcite.isNetworkActive
            labelText: xcite.isNetworkActive ? qsTr("ONLINE") : qsTr("OFFLINE")
            onButtonClicked: {
                if (xcite.isNetworkActive) {
                    xcite.isNetworkActive = false
                    return
                }

                confirmationModal({
                                      title: qsTr("CONNECT?"),
                                      bodyText: qsTr("Please ensure your Testnet wallet is running with RPC enabled at http://127.0.0.1:2222"),
                                      confirmText: qsTr("LET'S DO THIS!"),
                                      cancelText: qsTr("CANCEL")
                                  }, function () {
                                      xcite.isNetworkActive = !xcite.isNetworkActive
                                      pollWallet(true)
                                      network.listAccounts()
                                  })
            }
        }

        //        Switch {
        //            id: killSwitch
        //            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        //            checked: true
        //            padding: 0
        //            onClicked: {
        //                var title = killSwitch.checked ? qsTr("ACTIVATE?") : qsTr(
        //                                                     "DEACTIVATE?")
        //                confirmationModal({
        //                                      title: title,
        //                                      bodyText: qsTr("Are you sure?"),
        //                                      confirmText: qsTr("YES"),
        //                                      cancelText: qsTr("NO")
        //                                  }, null, function (modal) {
        //                                      killSwitch.checked = !killSwitch.checked
        //                                  })
        //            }
        //        }
    }

    Version {
        anchors.right: undefined
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
