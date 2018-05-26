/**
 * Filename: DashboardForm.qml
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
import "Controls" as Controls
import "Onboarding" as Onboarding
import "XCITE" as XCITE
import "X-Change" as XChange
import "X-Chat" as XChat
import "X-Vault" as XVault
import "tools" as Tools
import "Settings" as Settings

import xtrabytes.xcite.xchat 1.0


// TODO: Currently this is a low-performance proof of concept demonstrating scalability.
// For production, this should be refactored to make proper use of Loaders, limit the use of JavaScript functions, etc.
// More information: http://doc.qt.io/qt-5/scalability.html
Item {
    id: dashboard

    readonly property int layoutGridSpacing: 12
    readonly property int sideMenuWidth: 86
    readonly property int panelBorderRadius: 0
    readonly property int diodeHeaderHeight: 46
    readonly property int moduleMenuHeight: 49
    readonly property int diodeTopMargin: 40
    readonly property int diodePadding: 20
    readonly property bool showLoadingBar: false

    signal selectView(string path)

    Connections {
        Component.onCompleted: {
            selectView(developerSettings.initialView)
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
            id: mainLayout
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.rightMargin: layoutGridSpacing
            spacing: layoutGridSpacing

            Controls.ModuleMenu {
                id: moduleMenu
            }

            XCITE.Layout {
            }

            XChange.Layout {
            }

            XChat.Layout {
            }

            XVault.Layout {
            }

            Settings.Layout {
            }

            Tools.Layout {
            }
        }

        Controls.LoadingBar {
            anchors.top: mainLayout.top
            anchors.left: mainLayout.left
            anchors.right: mainLayout.right
            anchors.topMargin: moduleMenu.height + (layoutGridSpacing / 2) - (this.height / 2)
            running: showLoadingBar
        }
    }

    Controls.Popup {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: sideMenuWidth + layoutGridSpacing
        visible: false
    }

    XchatPopup {
        id: xChatPopup
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
