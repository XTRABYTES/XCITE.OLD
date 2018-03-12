import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import Qt.labs.settings 1.0

import xtrabytes.xcite.xchat 1.0
import Clipboard 1.0
import "Login" as LoginComponents
import "Theme" 1.0

ApplicationWindow {
    property bool isNetworkActive: false

    id: xcite

    visible: true

    width: 940
    height: 500
    minimumWidth: 940
    minimumHeight: 500

    title: qsTr("XCITE")
    color: "#2B2C31"

    StackView {
        id: mainRoot
        anchors.fill: parent
        pushEnter: null
        pushExit: null

        Component.onCompleted: {
            this.push(developerSettings.skipLogin ? dashboardForm : loginForm)
        }
    }

    Component {
        id: dashboardForm
        DashboardForm {
        }
    }

    Component {
        id: loginForm
        LoginComponents.LoginForm {
        }
    }

    Xchat {
        id: xchat
    }

    Clipboard {
        id: clipboard
    }

    Settings {
        id: settings
        property alias x: xcite.x
        property alias y: xcite.y
        property alias width: xcite.width
        property alias height: xcite.height
        property string locale: "en_us"
    }

    Settings {
        id: developerSettings
        category: "developer"
        property bool skipLogin: false
        property string initialView: "xCite.home"
    }

    Network {
        id: network
        handler: wallet
    }

    signal xchatSubmitMsgSignal(string msg)
    signal xChatMessageReceived(string message, date datetime)
    signal localeChange(string locale)

    function xchatResponse(response) {
        xChatMessageReceived(response, new Date())
    }

    function testnetResponse(response) {
        xbyBalance = response
    }

    function walletError(status) {
        xcite.isNetworkActive = false
        modalAlert({
                       title: qsTr("NETWORK ERROR"),
                       bodyText: qsTr(status),
                       buttonText: qsTr("OK")
                   })
    }

    function walletSuccess(result) {
        modalAlert({
                       title: qsTr("SUCCESS!"),
                       bodyText: "TXID: " + qsTr(result),
                       buttonText: qsTr("OK")
                   })
    }

    function pollWallet(isInitial) {
        network.getBalance()

        if (!isInitial) {
            network.listTransactions()
            network.listAccounts()
        }
    }

    function modalAlert(options, onClose) {
        var component = Qt.createComponent("../../Controls/ModalAlert.qml")

        if (!options.width) {
            options.width = 511
        }

        if (!options.height) {
            options.height = 238
        }

        if (component.status === Component.Ready) {
            var modal = component.createObject(xcite, options)

            modal.cancelled.connect(function () {
                if (typeof onClose == 'function') {
                    onClose(modal)
                }

                modal.close()
            })

            modal.open()
        }
    }

    function confirmationModal(options, onConfirm, onCancel) {
        var component = Qt.createComponent(
                    "../../Controls/ConfirmationModal.qml")

        if (!options.width) {
            options.width = 511
        }

        if (!options.height) {
            options.height = 238
        }

        if (component.status === Component.Ready) {
            var modal = component.createObject(xcite, options)

            modal.confirmed.connect(function (inputValue) {

                if (typeof onConfirm == 'function') {
                    onConfirm(modal, inputValue)
                }

                modal.close()
            })

            modal.cancelled.connect(function () {
                if (typeof onCancel == 'function') {
                    onCancel(modal, modal.inputValue)
                }

                modal.close()
            })

            modal.open()
        }
    }
}
