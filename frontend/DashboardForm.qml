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

Item {
    anchors.fill: parent

    RowLayout {
        id: rootLayout
        anchors.fill: parent

        Rectangle {
            // Diode navigation
            id: navRectangle
            color: "#3A3E47"
            Layout.fillHeight: true
            Layout.minimumWidth: 90
            Layout.preferredWidth: 90
            Layout.maximumWidth: 90

            ColumnLayout {
                width: parent.width
                Layout.fillHeight: true
                anchors.left: parent.left
                anchors.top: parent.top
                //Layout.fillHeight: true
                spacing: 35


                Image {
                    Layout.topMargin: 20
                    smooth: true
                    source: "logos/xby_logo.svg"
                    mipmap: true
                    Layout.maximumWidth: Math.min(parent.width, 80)
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    verticalAlignment: Qt.AlignTop
                    sourceSize: Qt.size(width, height) //important
                }

                Image {
                    Layout.topMargin: 20
                    smooth: true
                    source: "icons/dollar-pointer.svg"
                    mipmap: true
                    Layout.maximumWidth: Math.min(parent.width, 40)
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    verticalAlignment: Qt.AlignTop
                    sourceSize: Qt.size(width, height) //important
                }

                Image {
                    smooth: true
                    source: "icons/share.svg"
                    mipmap: true
                    Layout.maximumWidth: Math.min(parent.width, 40)
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    verticalAlignment: Qt.AlignTop
                    sourceSize: Qt.size(width, height) //important
                }

                Image {
                    smooth: true
                    source: "icons/shuffle.svg"
                    mipmap: true
                    Layout.maximumWidth: Math.min(parent.width, 40)
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    verticalAlignment: Qt.AlignTop
                    sourceSize: Qt.size(width, height) //important
                }

                Image {
                    smooth: true
                    source: "icons/chat.svg"
                    mipmap: true
                    Layout.maximumWidth: Math.min(parent.width, 40)
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    verticalAlignment: Qt.AlignTop
                    sourceSize: Qt.size(width, height) //important
                }

                Image {
                    smooth: true
                    source: "icons/plus-button.svg"
                    mipmap: true
                    Layout.maximumWidth: Math.min(parent.width, 40)
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    verticalAlignment: Qt.AlignTop
                    sourceSize: Qt.size(width, height) //important
                }
            }
        }

        ColumnLayout {
            id: rootColumnLayout
            anchors.top: parent.top
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
                    DockButton {
                        height: 13
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: parent.width
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumHeight: 100
                    color: "#3A3E47"
                    DockButton {
                        height: 13
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: parent.width
                    }
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
                    DockButton {
                        height: 13
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: parent.width
                    }
                }
            }

            RowLayout {
                // Footer
                height: 40
                anchors.left: parent.left

                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    color: "#0DD8D2"
                }

                XchatSummary {
                    anchors.right: parent.right
                }
            }
        }
    }

    XchatPopup {
        id: xchatpopup
        visible:true
    }
}


