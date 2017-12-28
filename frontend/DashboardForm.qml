import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.1
//import EmbeddedAuto 1.0
//import QuickGridStar 1.0
import xtrabytes.xcite.xchat 1.0


// TODO: Currently this is a low-performance proof of concept demonstrating scalability.
// For production, this should be refactored to make proper use of Loaders, limit the use of JavaScript functions, etc.
// More information: http://doc.qt.io/qt-5/scalability.html

RowLayout {
    id: rootLayout
    anchors.fill: parent

    Rectangle {
        // Diode navigation
        id: navRectangle
        color: "#3A3E47"
        Layout.fillHeight: true
        Layout.minimumWidth: 100
        Layout.preferredWidth: 100
        Layout.maximumWidth: 100
    }

    ColumnLayout {
        id: rootColumnLayout
        anchors.top: parent.top
        anchors.left: navRectangle.right + 10
        Layout.fillHeight: true
        spacing: 5

        Rectangle {
            // Main navigation
            Layout.fillWidth: true
            Layout.maximumWidth: parent.width
            Layout.minimumHeight: 50
            Layout.preferredHeight: 50
            Layout.maximumHeight: 50
            anchors.left: parent.left
            anchors.top: parent.top
            color: "transparent"

            RowLayout {
                Layout.fillWidth: true
                Layout.maximumWidth: 700
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                NavigationButton {
                    Layout.fillWidth: true
                    Layout.maximumWidth: 225
                    Layout.preferredWidth: 100
                    Layout.minimumWidth: 90
                    text: qsTr("HOME")
                }

                NavigationButton {
                    Layout.fillWidth: true
                    Layout.maximumWidth: 120
                    Layout.preferredWidth: 100
                    Layout.minimumWidth: 90
                    text: qsTr("X-CHANGE")
                }

                NavigationButton {
                    Layout.fillWidth: true
                    Layout.maximumWidth: 120
                    Layout.preferredWidth: 100
                    Layout.minimumWidth: 90
                    text: qsTr("X-CHAT")
                }
            }
        }

        RowLayout {
            // Diode row 1
            Layout.fillHeight: true
            anchors.left: parent.left

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: 100
                color: "#3A3E47"
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: 100
                color: "#3A3E47"
            }
        }

        RowLayout {
            // Diode row 2
            Layout.fillHeight: true
            anchors.left: parent.left

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: 100
                color: "#3A3E47"
            }
        }

        RowLayout {
            // Footer
            height: 60
            anchors.left: parent.left

            Rectangle {
                Layout.fillWidth: true
                height: 60
                color: "#0DD8D2"
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.maximumWidth: 300
                Layout.preferredWidth: 250
                Layout.minimumWidth: 200
                height: 60
                color: "#3A3E47"
            }

            // TODO Display XchatCollapsed

            //XchatPopup{}
        }


    }
}


