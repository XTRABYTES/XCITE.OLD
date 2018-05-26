/**
 * Filename: SliderAmount.qml
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
import QtGraphicalEffects 1.0
import "../Theme" 1.0

Slider {
    id: slider

    property real totalAmount

    from: 0
    stepSize: totalAmount / 4
    snapMode: Slider.SnapAlways
    leftPadding: 0
    rightPadding: 0
    to: totalAmount
    bottomPadding: 15
    clip: true

    background: Rectangle {
        // background rail
        x: slider.leftPadding
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: slider.availableWidth
        height: implicitHeight
        radius: 2
        color: "#2A2C31"

        // 0% bubble
        Rectangle {
            x: 0
            y: -9
            implicitWidth: 22
            implicitHeight: 22
            radius: 11
            border.width: 0
            color: "#2A2C31"

            Text {
                anchors.fill: parent
                anchors.topMargin: 27
                anchors.leftMargin: 3
                color: "#E0E0E0"
                font.weight: Font.Light
                font.pixelSize: 10
                text: "0%"
                width: 22
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // 25% bubble
        Rectangle {
            x: (slider.availableWidth - 22) / 4
            y: -9
            implicitWidth: 22
            implicitHeight: 22
            radius: 11
            border.width: 0
            color: "#2A2C31"

            Text {
                anchors.fill: parent
                anchors.topMargin: 27
                anchors.leftMargin: 3
                color: "#E0E0E0"
                font.weight: Font.Light
                font.pixelSize: 10
                text: "25%"
                width: 22
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // 50% bubble
        Rectangle {
            x: (slider.availableWidth - 22) / 4 * 2
            y: -9
            implicitWidth: 22
            implicitHeight: 22
            radius: 11
            border.width: 0
            color: "#2A2C31"

            Text {
                anchors.fill: parent
                anchors.topMargin: 27
                anchors.leftMargin: 3
                color: "#E0E0E0"
                font.weight: Font.Light
                font.pixelSize: 10
                text: "50%"
                width: 22
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // 75% bubble
        Rectangle {
            x: (slider.availableWidth - 22) / 4 * 3
            y: -9
            implicitWidth: 22
            implicitHeight: 22
            radius: 11
            border.width: 0
            color: "#2A2C31"

            Text {
                anchors.fill: parent
                anchors.topMargin: 27
                anchors.leftMargin: 3
                color: "#E0E0E0"
                font.weight: Font.Light
                font.pixelSize: 10
                text: "75%"
                width: 22
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // 100% bubble
        Rectangle {
            x: slider.availableWidth - 22
            y: -9
            implicitWidth: 22
            implicitHeight: 22
            radius: 11
            border.width: 0
            color: "#2A2C31"

            Text {
                anchors.fill: parent
                anchors.topMargin: 27
                anchors.leftMargin: 3
                color: "#E0E0E0"
                font.weight: Font.Light
                font.pixelSize: 10
                text: "100%"
                width: 22
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    // handle
    handle: Rectangle {
        id: handle
        property int rayLength: 50
        property int blobWidth: 22

        x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: blobWidth
        implicitHeight: blobWidth
        radius: blobWidth / 2
        color: Theme.primaryHighlight
        border.width: 0

        // left ray
        Rectangle {
            x: slider.leftPadding - handle.rayLength + 5
            y: (slider.topPadding + slider.availableHeight / 2 - height / 2) - 6
            implicitWidth: handle.rayLength
            implicitHeight: 4
            width: implicitWidth
            height: implicitHeight
            color: Theme.primaryHighlight

            LinearGradient {
                anchors.fill: parent
                start: Qt.point(handle.rayLength, 0)
                end: Qt.point(0, 0)
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: Theme.primaryHighlight
                    }
                    GradientStop {
                        position: 1.0
                        color: "#2A2C31"
                    }
                }
            }
        }

        // right ray
        Rectangle {
            x: slider.leftPadding + handle.blobWidth - 5
            y: (slider.topPadding + slider.availableHeight / 2 - height / 2) - 6
            implicitWidth: handle.rayLength
            implicitHeight: 4
            width: implicitWidth
            height: implicitHeight
            color: Theme.primaryHighlight

            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(handle.rayLength, 0)
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: Theme.primaryHighlight
                    }
                    GradientStop {
                        position: 1.0
                        color: "#2A2C31"
                    }
                }
            }
        }
    }
}
