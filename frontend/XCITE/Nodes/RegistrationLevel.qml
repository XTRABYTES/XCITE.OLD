import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0
import "../../Controls" as Controls

/**
  * Initial concept, needs to be compartmentalized and controls need to be made
  */
Rectangle {

    property int pageTracker: 0
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
        visible: pageTracker == 0
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        source: "../../icons/blocks1.svg"
    }
    // L1
    Controls.Diode {
        id: rectangle0
        title: qsTr("L1")
        visible: pageTracker == 0 
        anchors.left: image0.right
        anchors.top: image0.top
        width: 257
        height: 381
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
                text: qsTr("Earnings:")
            }
            Label {
                font.family: "Roboto"
                font.weight: Font.Light
                font.pixelSize: 16
                text: qsTr("Network Stake:")
            }
            Label {
                font.family: "Roboto"
                font.weight: Font.Light
                font.pixelSize: 16
                text: qsTr("Transfer Rate:")
            }
            Controls.ComboBox {
                id: levelSelect
                defaultBackgroundColor: "#3A3E47"
                Layout.fillWidth: true
                model: ["Select Node", "Level 1 Node", "Level 2 Node", "Level 3 Node"]
            }
        }
    }

    // L2
    Controls.Diode {
        id: rectangle1
        title: qsTr("L2")
        visible: false
        anchors.left: image0.right
        anchors.top: image0.top
        width: 257
        height: 381
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
                text: qsTr("Earnings:        Medium")
            }
            Label {
                font.family: "Roboto"
                font.weight: Font.Light
                font.pixelSize: 16
                text: qsTr("Network Stake:   Medium")
            }
            Label {
                font.family: "Roboto"
                font.weight: Font.Light
                font.pixelSize: 16
                text: qsTr("Transfer Rate:   Medium")
            }
            Controls.ComboBox {
                id: levelSelect2
                defaultBackgroundColor: "#3A3E47"
                Layout.fillWidth: true
                model: ["Level 2 Node", "Level 1 Node", "Level 3 Node"]
            }
            Label {
                font.family: "Roboto"
                font.weight: Font.Light
                font.pixelSize: 16
                text: qsTr("Payment")
            }
        }
    }

    // L3
    Controls.Diode {
        id: rectangle2
        title: qsTr("L3")
        visible: false
        anchors.left: image0.right
        anchors.top: image0.top
        width: 257
        height: 381
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
                text: qsTr("Earnings:        High")
            }
            Label {
                font.family: "Roboto"
                font.weight: Font.Light
                font.pixelSize: 16
                text: qsTr("Network Stake:   High")
            }
            Label {
                font.family: "Roboto"
                font.weight: Font.Light
                font.pixelSize: 16
                text: qsTr("Transfer Rate:   High")
            }
            Controls.ComboBox {
                id: levelSelect3
                defaultBackgroundColor: "#3A3E47"
                Layout.fillWidth: true
                model: ["Level 3 Node", "Level 1 Node", "Level 2 Node"]
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
