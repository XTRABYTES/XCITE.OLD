import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0
import "../../Controls" as Controls


/**
  * Initial concept, components need made
  */
Rectangle {

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
    Text {
        id: text1
        x: 51
        y: 80
        width: 115
        height: 18
        color: "#e3e3e3"
        text: qsTr("Select a node")
        font.family: "Roboto"
        font.weight: Font.Light
        font.pixelSize: 19
    }

    // top divider
    Rectangle {
        id: rectangle
        x: 0
        y: 44
        width: 1320
        height: 1
        color: "#535353"
    }

    // layer 1 text
    Text {
        id: text2
        x: 15
        y: 12
        width: 143
        height: 23
        color: "#e2e2e2"
        text: qsTr("Node Registration")
        font.family: "Roboto"
        font.pixelSize: 18
    }

    // image in case of level 1 node
    Image {

        id: image0
        visible: level1 == 0
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        source: "../../icons/blocks1.svg"
    }

    // image in case of level 2 node
    Image {

        id: image1
        visible: level1 == 1
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        source: "../../icons/blocks2.svg"
    }

    // image in case of level 3 node
    Image {

        id: image2
        visible: level1 == 2
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        source: "../../icons/blocks3.svg"
    }

    // L1
    Controls.Diode {
        id: rectangle0

        title: {
            if (level1 == 0)
                qsTr("L1")
            if (level1 == 1)
                qsTr("L2")
            if (level1 == 2)
                qsTr("L3")
        }
        visible: pageTracker == 0
        anchors.left: {
            if (level1 == 0)
                image0.right
            if (level1 == 1)
                image1.right
            if (level1 == 2)
                image2.right
        }
        anchors.top: {
            if (level1 == 0)
                image0.top
            if (level1 == 1)
                image1.top
            if (level1 == 2)
                image2.top
        }
        width: 257
        height: 300
        radius: 5
        color: "#2A2C31"
        ColumnLayout {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 75
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            Label {
                font.family: "Roboto"
                font.weight: Font.Light
                font.pixelSize: 16
                text: {
                    if (level1 == 0)
                        qsTr("Earnings:                    Low")
                    if (level1 == 1)
                        qsTr("Earnings:                    Medium")
                    if (level1 == 2)
                        qsTr("Earnings:                    High")
                }
            }
            Label {
                font.family: "Roboto"
                font.weight: Font.Light
                font.pixelSize: 16
                text: {
                    if (level1 == 0)
                        qsTr("Network Stake:            Low")
                    if (level1 == 1)
                        qsTr("Network Stake:            Medium")
                    if (level1 == 2)
                        qsTr("Network Stake:            High")
                }
            }
            Label {
                font.family: "Roboto"
                font.weight: Font.Light
                font.pixelSize: 16
                text: {
                    if (level1 == 0)
                        qsTr("Transfer Rate:              Low")
                    if (level1 == 1)
                        qsTr("Transfer Rate:              Medium")
                    if (level1 == 2)
                        qsTr("Transfer Rate:              High")
                }
            }

            // drop down menu for node choice
            Controls.ComboBox {
                id: levelSelect
                defaultBackgroundColor: "#3A3E47"
                Layout.fillWidth: true
                model: ["Level 1 Node", "Level 2 Node", "Level 3 Node"]
            }
            Label {
                font.family: "Roboto"
                font.weight: Font.Light
                font.pixelSize: 16
                text: "Payment"
            }
            // choose payment value for portion of node, needs input on if amount is static or not
            RangeSlider {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                first.value: 0
                second.value: 550000
            }
        }
    }
    // divider
    Rectangle {
        id: divider
        x: 51
        y: 104
        width: 115
        height: 1
        color: "#24B9C3"
    }
}
