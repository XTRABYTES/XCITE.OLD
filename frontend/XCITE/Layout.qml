/**
 * Filename: Layout.qml
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
import QtQuick.Layouts 1.3

import "Nodes" as Nodes
import "Home" as Home
import "SendCoins" as SendCoins
import "History" as History
import "ReceiveCoins" as ReceiveCoins
import "../Settings" as Settings

Item {
    readonly property string defaultView: "home"

    property string selectedView
    property string selectedModule

    Layout.fillHeight: true
    Layout.fillWidth: true

    visible: selectedModule === 'xCite'

    Connections {
        target: dashboard
        onSelectView: {
            var parts = path.split('.')

            selectedModule = parts[0]
            if (parts.length === 2) {
                selectedView = parts[1]
            } else {
                selectedView = defaultView
            }
        }
    }

    // Home
    Home.Layout {
        id: home
        visible: selectedView === "home"
    }

    // Send Coins
    SendCoins.Layout {
        id: xCiteSendCoins
        visible: selectedView === "sendCoins"
    }

    // Receive Coins
    ReceiveCoins.Layout {
        id: xCiteReceiveCoins
        visible: selectedView === "receiveCoins"
    }

    // History
    History.Layout {
        id: xCiteHistory
        visible: selectedView === "history"
    }

    Settings.Layout {
        id: xCiteSettings
        visible: selectedView === "settings"
    }

    // Nodes
    Nodes.Layout {
        id: xCiteNodes
        visible: selectedView === "nodes"
    }
}
