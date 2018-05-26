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

import "Home" as Home
import "MarketTrades" as MarketTrades
import "OpenOrders" as OpenOrders
import "OrderBooks" as OrderBooks
import "OrderHistory" as OrderHistory
import "../Controls" as Controls

Item {
    readonly property string defaultView: "home"

    property string selectedView
    property string selectedModule

    Layout.fillHeight: true
    Layout.fillWidth: true
    visible: selectedModule === 'xChange'

    // Home
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

    Home.Layout {
        id: home
        visible: selectedView === "home"
    }
    // Send Coins
    OpenOrders.Layout {
        id: xCiteOpenOrders
        visible: selectedView === "openOrders"
    }

    // Receive Coins
    OrderHistory.Layout {
        id: xCiteOrderHistory
        visible: selectedView === "orderHistory"
    }

    // History
    MarketTrades.Layout {
        id: xCiteMarketTrades
        visible: selectedView === "marketTrades"
    }

    OrderBooks.Layout {
        id: xCiteOrderBooks
        visible: selectedView === "orderBooks"
    }
}
