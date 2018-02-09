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

            // Set the current view based on the new selection
            if (selectedView === "home") {
                xBoardViewLoader.source = "Home/Layout.qml";
            } else if (selectedView === "sendCoins") {
                xBoardViewLoader.source = "SendCoins/Layout.qml";
            } else if (selectedView === "receiveCoins") {
                xBoardViewLoader.source = "ReceiveCoins/Layout.qml";
            } else if (selectedView === "history") {
                xBoardViewLoader.source = "History/Layout.qml";
            } else if (selectedView === "nodes") {
                xBoardViewLoader.source = "Nodes/Layout.qml";
            }
        }
    }

    // Set the source of this loader to change the X-Board view

    Loader {
        id: xBoardViewLoader
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
}
