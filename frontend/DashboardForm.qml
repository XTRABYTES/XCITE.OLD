import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.1
import QtQuick.Controls.Material 2.1

import "Controls" as Controls

import "XCITE" as XCITE
import "X-Change" as XChange
import "X-Chat" as XChat
import "tools" as Tools

import xtrabytes.xcite.xchat 1.0


// TODO: Currently this is a low-performance proof of concept demonstrating scalability.
// For production, this should be refactored to make proper use of Loaders, limit the use of JavaScript functions, etc.
// More information: http://doc.qt.io/qt-5/scalability.html
Item {
    id: dashboard

    readonly property int layoutGridSpacing: 15
    readonly property int sideMenuWidth: 90

    signal selectView(string path)

    Connections {
        Component.onCompleted: {
            selectView("xCite.home")
        }
    }

    RowLayout {
        id: rootLayout
        anchors.fill: parent
        anchors.rightMargin: layoutGridSpacing
        anchors.bottomMargin: layoutGridSpacing
        spacing: 15

        Controls.SideMenu {
        }

        ColumnLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Layout.fillHeight: true
            Layout.fillWidth: true

            Controls.ModuleMenu {
            }

            XCITE.Layout {
            }

            XChange.Layout {
            }

            XChat.Layout {
            }


            // Settings
            Item {
                id: moduleSettings
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
