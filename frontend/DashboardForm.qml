import QtQuick 2.7
import QtQuick.Layouts 1.3

import "Controls" as Controls

import "XCITE" as XCITE
import "X-Change" as XChange
import "tools" as Tools
import "Settings" as Settings

import xtrabytes.xcite.xchat 1.0


// TODO: Currently this is a low-performance proof of concept demonstrating scalability.
// For production, this should be refactored to make proper use of Loaders, limit the use of JavaScript functions, etc.
// More information: http://doc.qt.io/qt-5/scalability.html
Item {
    id: dashboard

    readonly property int layoutGridSpacing: 8
    readonly property int sideMenuWidth: 86
    readonly property int panelBorderRadius: 0
    readonly property int diodeHeaderHeight: 46
    readonly property int moduleMenuHeight: 49

    signal selectView(string path)

    Connections {
        Component.onCompleted: {
            selectView("xCite.home")
        }
    }

    RowLayout {
        id: rootLayout
        anchors.fill: parent
        spacing: layoutGridSpacing

        Controls.SideMenu {
            Layout.fillHeight: true
            width: sideMenuWidth
        }

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.rightMargin: layoutGridSpacing
            spacing: layoutGridSpacing

            Controls.ModuleMenu {
            }

            XCITE.Layout {
            }

            XChange.Layout {
            }

            Settings.Layout {
            }

            Tools.Layout {
            }
        }
    }

    Controls.Popup {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: sideMenuWidth + layoutGridSpacing
    }

    XchatPopup {
        id: xChatPopup
        visible: true
    }

    Timer {
        interval: 3000
        running: xcite.isNetworkActive
        repeat: true
        onTriggered: {
            pollWallet()
        }
    }
}
