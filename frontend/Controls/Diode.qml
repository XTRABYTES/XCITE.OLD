/**
 * Filename: Diode.qml
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
import "../Theme" 1.0

Rectangle {
    property alias title: header.text
    property alias menuLabelText: header.menuLabelText

    color: Theme.panelBackground
    radius: panelBorderRadius

    DiodeHeader {
        id: header
    }
}
