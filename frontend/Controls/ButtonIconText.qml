/**
 * Filename: ButtonIconText.qml
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
import QtQuick.Window 2.2

Rectangle {
    id: root

    //Alias
    property alias label: label
    property alias text: label.text

    readonly property color cDiodeBackground: "#3a3e46"

    //Properties
    property string backgroundColor: "transparent"
    property string foregroundColor: "#10B9C5"
    property string hoverBackgroundColor: root.color
    property string hoverForegroundColor: label.color
    property string hoverTextColor: cDiodeBackground
    property string textColor: "#ffffff"
    property string hoverBorderColor: "#10B9C5"
    property string borderColor: "#616878"
    property int size: 40
    property int imageOffsetX: 0
    property string iconFile: "../../icons/right-arrow2.svg"
    property int mobile
    property int marginLeftValue
    //Signals
    signal buttonClicked

    radius: 6
    width: 250
    height: 29
    border.color: borderColor
    border.width: 1
    color: backgroundColor

    Label {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: ""
        font.pixelSize: 10
        color: textColor

        leftPadding: text === "" ? 0 : 25

        Image {
            id: icon
            fillMode: Image.PreserveAspectFit
            source: iconFile
            height: size
            sourceSize.width: size
            sourceSize.height: size
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: text === "" ? parent.horizontalCenter : undefined
            anchors.left: if (mobile == 1)
                              label.left
            anchors.leftMargin: if (mobile == 1)
                                    marginLeftValue
        }

        ColorOverlay {
            anchors.fill: icon
            source: icon
            color: "#333333"
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            root.buttonClicked()
        }
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onHoveredChanged: {
            if (containsMouse) {
                root.color = hoverBackgroundColor
                label.color = hoverTextColor
                root.border.color = hoverBorderColor
            } else {
                root.color = backgroundColor
                label.color = textColor
                root.border.color = borderColor
            }
        }
    }
}
