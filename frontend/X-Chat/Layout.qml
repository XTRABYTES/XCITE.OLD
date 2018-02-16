import QtQuick 2.0
import QtQuick.Layouts 1.3

import "Home" as Home

Item {
    readonly property string defaultView: "home"

    property string selectedView
    property string selectedModule

    Layout.fillHeight: true
    Layout.fillWidth: true
    visible: selectedModule === 'xChat'

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
        }
    }

    Home.Layout {
        id: home
        visible: selectedView === "home"
    }
}
