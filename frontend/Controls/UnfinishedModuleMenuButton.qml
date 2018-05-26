/**
 * Filename: UnfinishedModuleMenuButton.qml
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

ModuleMenuButton {
    id: button
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            modalAlert({
                           bodyText: "This portion of XCITE is not yet functioning. Expect it soon!",
                           title: qsTr("Module Alert"),
                           buttonText: qsTr("OK")
                       })
            selectView(target)
        }
        onHoveredChanged: {
            button.state = containsMouse ? "hover" : ""
        }
        hoverEnabled: true
    }
}
