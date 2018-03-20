import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0
import "../../Controls" as Controls


/**
  * Refactored, needs cleaning up on the Low, Medium High Texts, see line 136
  */
Controls.Diode {

    // primary rectangle properties
    property int pageTracker: 0
    property int level1
    level1: levelSelect.currentIndex
    id: regLevel
    width: parent.width - 100
    height: parent.height - 500
    Layout.minimumHeight: 100
    color: "#3A3E47"
    radius: 5
    anchors.fill: parent

    // Second layer text
    ColumnLayout {
        Text {
            id: text2
            Layout.topMargin: 10
            Layout.leftMargin: 13
            width: 143
            height: 23
            color: "#e2e2e2"
            text: qsTr("Node Registration")
            font.pixelSize: 18
        }

        Controls.FormLabel {
            Layout.topMargin: 55
            text: qsTr("Select a Node")
            Layout.leftMargin: 51
            font.pixelSize: 19
        }
    }
    // image in case of level 1 node
    Image {

        id: image0
        visible: level1 == 1 || level1 == 0
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        source: "../../icons/blocks1.svg"
    }

    // image in case of level 2 node
    Image {

        id: image1
        visible: level1 == 2
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        source: "../../icons/blocks2.svg"
    }

    // image in case of level 3 node
    Image {

        id: image2
        visible: level1 == 3
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        source: "../../icons/blocks3.svg"
    }

    // L1
    Controls.Diode {
        id: rectangle0
        y: {
            if (level1 == 1 || level1 == 0)
                image0.y + 12
            if (level1 == 2)
                image1.y + 120
            if (level1 == 3)
                image2.y + 190
        }
        title: {
            if (level1 == 1 || level1 == 0)
                qsTr("L1")
            if (level1 == 2)
                qsTr("L2")
            if (level1 == 3)
                qsTr("L3")
        }
        anchors.left: {
            if (level1 == 1 || level1 == 0)
                image0.right
            if (level1 == 2)
                image1.right
            if (level1 == 3)
                image2.right
        }

        width: 257
        height: 375
        radius: 5
        color: "#2A2C31"
        ColumnLayout {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 65
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            Label {
                id: label1
                font.weight: Font.Light
                font.pixelSize: 16
                bottomPadding: 5
                color: "#d5d5d5"
                text: {
                    if (level1 == 3)
                        qsTr("      Earnings:                    Low")
                    if (level1 == 2)
                        qsTr("      Earnings:               Medium")
                    if (level1 == 1 || level1 == 0)
                        qsTr("      Earnings:                    High")
                }
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
                id: label2
                font.weight: Font.Light
                font.pixelSize: 16
                bottomPadding: 5
                color: "#d5d5d5"
                text: {
                    if (level1 == 3)
                        qsTr("      Network Stake:            Low")
                    if (level1 == 2)
                        qsTr("      Network Stake:       Medium")
                    if (level1 == 1 || level1 == 0)
                        qsTr("      Network Stake:            High")
                }
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
                id: label3
                font.weight: Font.Light
                font.pixelSize: 16
                bottomPadding: 15
                color: "#d5d5d5"
                text: {
                    if (level1 == 3)
                        qsTr("      Transfer Rate:              Low")
                    if (level1 == 2)
                        qsTr("      Transfer Rate:         Medium")
                    if (level1 == 1 || level1 == 0)
                        qsTr("      Transfer Rate:              High")
                }
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
                defaultBackgroundColor: "#3A3E47"
                Layout.fillWidth: true
                model: ["Select a Node", "Level 1 Node", "Level 2 Node", "Level 3 Node"]
            }
            Label {
                font.weight: Font.Light
                font.pixelSize: 16
                topPadding: 14
                color: "#d5d5d5"
                text: "Payment"
            }
            Label {
                font.weight: Font.Light
                font.pixelSize: 10
                bottomPadding: -10
                color: "#24B9C3"
                text: "XBY                                                     XBY+XFUEL"
            }
            // choose payment value for portion of node, needs input on if amount is static or not
            RangeSlider {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                from: 0
                to: 100
                first.value: 0
                second.value: 550000
            }
            Controls.ButtonModal {
                Layout.fillHeight: true
                isPrimary: true
                width: parent.width - 10
                buttonHeight: 40
                label.font.weight: Font.Medium
                label.font.letterSpacing: 3
                label.text: qsTr("Select")
                bottomPadding: 20
            }
        }
    }
}
