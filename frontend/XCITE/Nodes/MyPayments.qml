/**
 * Filename: MyPayments.qml
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
        text: qsTr("PAYMENTS")
        menuLabelText: qsTr("LAST 30 DAYS")
    }
    /**
    RowLayout {
        ColumnLayout {
            //Balance labels
            Controls.LabelUnderlined {
                id: dailyText
                text: "XBY"
                anchors.left: parent.left
                anchors.leftMargin: 33
                pixelSize: 19
            }
            Controls.LabelUnderlined {
                id: monthlyText
                text: "Total XBY locked"
                anchors.left: parent.left
                anchors.leftMargin: 33
                pixelSize: 19
            }

            Controls.LabelUnderlined {
                text: "Total XFUEL locked"
                anchors.left: parent.left
                anchors.leftMargin: 33
                pixelSize: 19
            }
        }
        ColumnLayout {
            //Balances text values
            Text {
                id: dailyValue
                color: "#D5D5D5"
                font.pixelSize: 54
                text: "1 L1 2 L2"
                anchors.right: parent.right
                anchors.rightMargin: 30
            }

            Text {
                id: monthlyValue
                color: "#D5D5D5"
                font.pixelSize: 54
                text: "625,000"
                anchors.right: parent.right
                anchors.rightMargin: 30
            }

            Text {
                id: totalValue
                color: Theme.primaryHighlight
                font.pixelSize: 54
                text: "0"
                anchors.right: parent.right
                anchors.rightMargin: 30
            }
        }
    }
    */
}
