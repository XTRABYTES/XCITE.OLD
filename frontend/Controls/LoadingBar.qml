/**
 * Filename: LoadingBar.qml
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
import QtGraphicalEffects 1.0
import "../Theme" 1.0

Item {
    readonly property int animationDuration: 750
    property alias running: animation.running
    height: 4

    LinearGradient {
        anchors.fill: parent
        start: Qt.point(parent.width, 0)
        end: Qt.point(0, 0)
        opacity: 0

        SequentialAnimation on opacity {
            id: animation
            loops: Animation.Infinite
            NumberAnimation {
                from: 0.0
                to: 1.0
                duration: animationDuration
            }
            NumberAnimation {
                from: 1.0
                to: 0.0
                duration: animationDuration
            }
        }

        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "#2A2C31"
            }
            GradientStop {
                position: 0.5
                color: Theme.primaryHighlight
            }
            GradientStop {
                position: 1.0
                color: "#2A2C31"
            }
        }
    }
}
