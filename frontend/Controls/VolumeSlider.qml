/**
 * Filename: VolumeSlider.qml
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

Item {
    width: appWidth/6*2
    height: sliderButton.height

    property real sliderPosition: (sliderButton.x + (sliderButton.width/2) - bar.x)/bar.width
    property bool movePressed: false
    property real volumeValue: 0

    Rectangle {
        id: bar
        width: parent.width
        height: 2
        anchors.verticalCenter: parent.verticalCenter
        color: themecolor
    }

    Rectangle {
        id: sliderButton
        width: appHeight/27 - 4
        height: width
        radius: height/2
        anchors.verticalCenter: parent.verticalCenter
        x: (bar.width * volumeValue) - width/2
        color: maincolor

        MouseArea {
            anchors.fill: parent
            drag.target: sliderButton
            drag.axis: Drag.XAxis
            drag.minimumX: -sliderButton.width/2
            drag.maximumX: bar.width - (sliderButton.width/2) - 1

            onPressed: {
                movePressed = true
            }

            onReleased: {
                sliderPosition = (sliderButton.x + (sliderButton.width/2) - bar.x)/bar.width
                movePressed = false
            }
        }
    }
}
