import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import "../../Controls" as Controls

Controls.Diode {
    id: diodeParent
    property string earningsText: ""
    property string networkText: ""
    property string transferText: ""

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 65
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        Label {

            id: earningsLabel
            leftPadding: 30
            font.weight: Font.Light
            font.pixelSize: 16
            bottomPadding: 5
            color: "#d5d5d5"
            text: earningsText

            Image {

                id: diamond
                visible: true
                anchors {
                    left: parent.left
                }
                source: "../../icons/icon-diamond.svg"
            }
        }
        Label {
            id: networkLabel
            leftPadding: 30
            font.weight: Font.Light
            font.pixelSize: 16
            bottomPadding: 5
            color: "#d5d5d5"
            text: networkText

            Image {

                id: network
                visible: true
                anchors {
                    left: parent.left
                }
                source: "../../icons/icon-network.svg"
            }
        }
        Label {
            id: transferLabel
            leftPadding: 30
            font.weight: Font.Light
            font.pixelSize: 16
            bottomPadding: 15
            color: "#d5d5d5"
            text: transferText

            Image {

                id: transfer
                visible: true
                anchors {
                    left: parent.left
                }
                source: "../../icons/icon-transfer.svg"
            }
        }

        // drop down menu for node choice
        Controls.ComboBox {
            id: levelSelect
            Layout.fillWidth: true
            model: ["Select a Node", "Level 1 Node", "Level 2 Node", "Level 3 Node"]
            defaultBackgroundColor: "#3A3E47"
        }
        Label {
            font.weight: Font.Light
            font.pixelSize: 16
            topPadding: 14
            color: "#d5d5d5"
            text: "Payment"
        }

        // choose payment value for portion of node, needs input on if amount is static or not
        Controls.Switch {
            on: false
            Layout.topMargin: 12
            Layout.leftMargin: 35
            Label {
                anchors.right: parent.left
                anchors.rightMargin: 10
                color: "#24B9C3"
                font.pixelSize: 12
                text: "XBY"
                topPadding: 3
            }
            Label {
                anchors.left: parent.right
                anchors.leftMargin: 10
                color: "#24B9C3"
                font.pixelSize: 12
                text: "XBY+XFUEL"
                topPadding: 3
            }
        }
        Controls.ButtonModal {
            Layout.fillHeight: true
            isPrimary: true
            width: parent.width - 10
            buttonHeight: 40
            label.font.weight: Font.Medium
            label.font.letterSpacing: 3
            label.text: qsTr("Select")
            topPadding: 50
        }
    }
}

