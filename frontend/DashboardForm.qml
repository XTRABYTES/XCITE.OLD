import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.1
import QtQuick.Controls.Material 2.1

import "Controls" as Controls

import "X-Board" as XBoard
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
                modal.destroy()
            })

            modal.cancelled.connect(function () {
                if (typeof onCancel == 'function') {
                    onCancel(modal, modal.inputValue)
                }

                modal.close()
                modal.destroy()
            })

            modal.open()
        }
    }

    Connections {
        Component.onCompleted: {
            selectView("xBoard.home")
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

            XBoard.Layout {
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
}
