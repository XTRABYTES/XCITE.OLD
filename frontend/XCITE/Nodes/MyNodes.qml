/**
 * Filename: MyNodes.qml
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
import "../../Controls" as Controls
import "../../Theme" 1.0


//Balance board used on the Nodes page (left hand side)
Controls.Diode {
    id: rectangle
    width: 376
    height: 305
    color: "#3a3e46"
    radius: 5
    opacity: 1
    Layout.fillHeight: false

    Controls.DiodeHeader {
        id: diodeHeader
        text: qsTr("MY NODES")
    }
    /**
    //Balances text values
    Text {
        id: dailyValue
        x: 263
        y: 195
        color: "#D5D5D5"
        font.pixelSize: 54
        text: "550"
        anchors.right: parent.right
        anchors.rightMargin: 30
    }

    Text {
        id: monthlyValue
        x: 189
        y: 281
        color: "#D5D5D5"
        font.pixelSize: 54
        text: "23,000"
        anchors.right: parent.right
        anchors.rightMargin: 30
    }

    Text {
        id: totalValue
        x: 160
        y: 363
        color: Theme.primaryHighlight
        font.pixelSize: 54
        text: "198,009"
        anchors.right: parent.right
        anchors.rightMargin: 30
    }
    //Balance labels
    Controls.LabelUnderlined {
        id: dailyText
        x: 0
        y: 213
        text: "Nodes Registered"
        anchors.left: parent.left
        anchors.leftMargin: 33
        pixelSize: 19
    }
    Controls.LabelUnderlined {
        id: monthlyText
        y: 299
        text: "Total XBY locked"
        anchors.left: parent.left
        anchors.leftMargin: 33
        pixelSize: 19
    }
    Controls.LabelUnderlined {
        y: 384
        text: "Total XFUEL locked"
        anchors.left: parent.left
        anchors.leftMargin: 33
        pixelSize: 19
    }
    */
}
