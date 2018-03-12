import "Home" as Home
import QtQuick 2.7
import QtQuick.Layouts 1.3

Item {
    readonly property string defaultView: "home"

    property string selectedView
    property string selectedModule

    Layout.fillHeight: true
    Layout.fillWidth: true

    visible: selectedModule === 'xChat'

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
}
