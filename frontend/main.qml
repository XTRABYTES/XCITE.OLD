/**
 * Filename: main.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import Qt.labs.settings 1.0

import xtrabytes.xcite.xchat 1.0
import Clipboard 1.0
import "Onboarding" as Onboarding
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
            var idealHeight = (screen.height * 0.7) > 800 ? (screen.height * 0.7) : 800
            var idealWidth = (screen.width * 0.7) > 1000 ? (screen.width * 0.7) : 1000

            var h = Math.min(screen.height - 100, idealHeight)
            var w = Math.min(screen.width - 100, idealWidth)

            if (!settings.onboardingCompleted) {
                xcite.width = w
                xcite.height = h
                xcite.x = (screen.width / 2) - (w / 2)
                xcite.y = (screen.height / 2) - (h / 2)
            }

            this.push(developerSettings.skipOnboarding ? dashboardForm : onboarding)
        }
    }

    Component {
        id: dashboardForm
        DashboardForm {
        }
    }

    Component {
        id: onboarding
        Onboarding.Introduction {
        }
    }

    Component {
        id: loginForm
        LoginComponents.LoginForm {
        }
    }

    Connections {
        target: ReleaseChecker
        onXciteUpdateAvailable: {
            confirmationModal({
                                  title: qsTr("UPDATE AVAILABLE"),
                                  bodyText: qsTr("An updated version of XCITE is available for download!"),
                                  confirmText: qsTr("DOWNLOAD"),
                                  cancelText: qsTr("NOT NOW")
                              }, function () {
                                  Qt.openUrlExternally(
                                              "https://github.com/XTRABYTES/XCITE/releases")
                              })
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
        property bool onboardingCompleted: false
        property string defaultCurrency: "USD"
    }

    Settings {
        id: developerSettings
        category: "developer"
        property bool skipOnboarding: false
        property bool skipLogin: false
        property string initialView: "xCite.home"
    }

    Settings {
        id: xChatSettings
        category: "xchat"
        property string sizeState: "minimal"
        property string activeTab: "robot"
    }

    Network {
        id: network
        handler: wallet
    }

    signal marketValueChangedSignal(string currency)
    signal xchatSubmitMsgSignal(string msg)
    signal xChatMessageReceived(string message, date datetime)
    signal localeChange(string locale)
    signal clearAllSettings

    function xchatResponse(response) {
        xChatMessageReceived(response, new Date())
    }

    function testnetResponse(response) {
        xbyBalance = response
    }

    function walletError(sender, status) {
        //        xcite.isNetworkActive = false
        if (sender === "ui") {
            modalAlert({
                           title: qsTr("NETWORK ERROR"),
                           bodyText: qsTr(status),
                           buttonText: qsTr("OK")
                       })
        }
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
