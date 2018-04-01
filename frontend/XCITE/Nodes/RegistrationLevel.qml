import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import "../../Controls" as Controls


/**
  * Refactored, needs cleaning up on the Low, Medium High Texts, see line 136
  */
Controls.Diode {
    id: regLevel
    width: parent.width - 100
    height: parent.height
    Layout.minimumHeight: 100
    Layout.preferredHeight: 1320
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
        visible: parent.width > 1125
        z: 1
        anchors {
            right: image1.left
            rightMargin: 96
            top: parent.top
            topMargin: 100
        }
        source: "../../icons/Level1.svg"
        width: 311
        height: 320
    }

    // image in case of level 2 node
    Image {
        id: image1
        z: 1
        anchors {

            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 150
        }
        source: "../../icons/Level2.svg"
        width: 311
        height: 268
    }

    // image in case of level 3 node
    Image {
        id: image2
        z: 1
        anchors {
            left: image1.right
            leftMargin: 96
            top: parent.top
            topMargin: 200
        }
        source: "../../icons/Level3.svg"
        width: 311
        height: 216
    }

    RegLevelBox {
        id: rectangle0
        visible: parent.width > 1125
        title: qsTr("L1")
        anchors.top: image0.bottom
        anchors.topMargin: -20
        anchors.left: image0.left
        width: 312
        height: 397
        radius: 5
        color: "#2A2C31"
        earningsText: qsTr("Earnings:")
        transferText: qsTr("Transfer Rate:")
        networkText: qsTr("Network Stake:")
    }
    RegLevelBox {
        id: rectangle1
        visible: parent.width > 600
        title: qsTr("L2")
        anchors.top: image1.bottom
        anchors.topMargin: -20
        anchors.left: image1.left
        width: 312
        height: 397
        radius: 5
        color: "#2A2C31"
        earningsText: qsTr("Earnings:")
        transferText: qsTr("Transfer Rate:")
        networkText: qsTr("Network Stake:")
    }

    RegLevelBox {
        id: rectangle2
        visible: parent.width > 600
        title: qsTr("L3")
        anchors.top: image2.bottom
        anchors.topMargin: -20
        anchors.left: image2.left
        width: 312
        height: 397
        radius: 5
        color: "#2A2C31"
        earningsText: qsTr("Earnings:")
        transferText: qsTr("Transfer Rate:")
        networkText: qsTr("Network Stake:")
    }
}


