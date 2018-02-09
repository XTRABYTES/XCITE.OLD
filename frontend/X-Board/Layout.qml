import QtQuick 2.0
import QtQuick.Layouts 1.3

import "Nodes" as Nodes
import "Home" as Home
import "SendCoins" as SendCoins
import "History" as History
import "ReceiveCoins" as ReceiveCoins

Item {
    readonly property string defaultView: "home"

    property string selectedView
    property string selectedModule

    Layout.fillHeight: true
    Layout.fillWidth: true

    // Home

    Connections {
        target: dashboard
        onSelectView: {
            var parts = path.split('.');

            selectedModule = parts[0];
            if (parts.length === 2) {
                selectedView = parts[1];
            } else {
                selectedView = defaultView
            }

            if (selectedView === "home") {
                xBoardLoader.source = "Home/Layout.qml";
            } else if (selectedView === "sendCoins") {
                xBoardLoader.source = "SendCoins/Layout.qml";
            } else if (selectedView === "receiveCoins") {
                xBoardLoader.source = "ReceiveCoins/Layout.qml";
            } else if (selectedView === "history") {
                xBoardLoader.source = "History/Layout.qml";
            } else if (selectedView === "nodes") {
                xBoardLoader.source = "Nodes/Layout.qml";
            }
        }
    }

    Loader {
        id: xBoardLoader
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
}
