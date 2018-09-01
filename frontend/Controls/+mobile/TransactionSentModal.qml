/**
 * Filename: DashboardForm.qml
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
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Rectangle {
    id: transactionSentModal
    height: modal.height
    width: parent.width - 50
    color: "#42454F"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: modal.top
    radius: 4
    z: 100
    Image {
        id: transactionSentImage
        source: '../icons/rocket.svg'
        anchors.top: parent.top
        anchors.topMargin: (parent.height/2) - 80
        anchors.horizontalCenter: parent.horizontalCenter
        height: (parent.height/4)
        width: (parent.height/4)
        ColorOverlay {
            anchors.fill: transactionSentImage
            source: transactionSentImage
            color: "#5E8BFF"
        }
    }
    Text {
        text: "Transaction Sent!"
        font.family: "Brandon Grotesque"
        font.pointSize: 14
        font.bold: true
        color: "#5E8BFF"
        anchors.top: transactionSentImage.bottom
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Rectangle {
        id: transactionSentModalTop
        height: 50
        width: transactionSentModal.width
        anchors.bottom: transactionSentModal.top
        anchors.left: transactionSentModal.left
        color: "#34363D"
        radius: 4
        Text {
            id: textHeader
            text: "CONFIRMATION"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
            font.bold: true
            font.pixelSize: 15
        }
    }
}
