import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Item {
    anchors.left: parent.left
    anchors.right: parent.right
    height: 67

    Rectangle {
        color: "#3C405A"
        anchors.fill: parent

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Column {
                    anchors.fill: parent
                    anchors.leftMargin: 15
                    anchors.rightMargin: 15
                    anchors.topMargin: 12
                    anchors.bottomMargin: 12

                    Label {
                        text: qsTr("YOUR BALANCE")
                        color: "#AEAEAE"
                        font.pixelSize: 8
                        font.letterSpacing: 0.9
                        bottomPadding: 6
                    }

                    Label {
                        font.family: "Roboto Condensed"
                        font.pixelSize: 26
                        text: qsTr("4,739.35")
                    }
                }
            }

            Rectangle {
                color: "#484B62"
                Layout.fillHeight: true
                width: 1
            }

            ColumnLayout {
                spacing: 0

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Label {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        verticalAlignment: Text.AlignVCenter
                        font.letterSpacing: 0.9
                        text: qsTr("UNCONFIRMED")
                        color: "#AEAEAE"
                        font.pixelSize: 8

                        Label {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Roboto Condensed"
                            font.pixelSize: 15
                            text: qsTr("0")
                        }
                    }
                }

                Rectangle {
                    color: "#484B62"
                    Layout.fillWidth: true
                    height: 1
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Label {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr("TOTAL")
                        font.letterSpacing: 0.9
                        color: "#AEAEAE"
                        font.pixelSize: 8

                        Label {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: "Roboto Condensed"
                            font.pixelSize: 15
                            text: qsTr("4,739.15")
                        }
                    }
                }
            }
        }
    }
}
