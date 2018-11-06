/**
 * Filename: xchange.qml
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
import QtMultimedia 5.8

import "../Controls" as Controls

/**
  * Main page
  */
Item {
    property int tempHide: 1

    Loader {
        id: pageLoader
    }
    Controls.Header {
        id: heading
        text: qsTr("X-CHANGE")
        showBack: false
        Layout.topMargin: 30
    }
    Image {
        id: back
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 25
        source: '../icons/left-arrow.svg'
        width: 15
        height: 15

        MouseArea {
             anchors.fill: back
             onClicked: mainRoot.pop("../DashboardForm.qml")
        }
    }
}
