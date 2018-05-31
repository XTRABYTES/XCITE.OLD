/**
 * Filename: DeveloperSettings.qml
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
import "../Controls" as Controls
import "../Theme" 1.0

ColumnLayout {
    Controls.FormLabel {
        text: qsTr("Developer Settings")
    }

    Text {
        Layout.topMargin: 20
        color: "#F46472"
        text: "Leave these alone unless you know what you're doing"
    }

    Label {
        Layout.topMargin: 15
        text: "Initial View"
    }

    Controls.TextInput {
        id: initialView
        font.pixelSize: 16
        Layout.preferredWidth: 150
        text: developerSettings.initialView

        onAccepted: {
            developerSettings.initialView = this.text.trim()
        }
    }

    CheckBox {
        id: skipOnboardingCheckbox
        text: "Skip onboarding screens on startup"
        checked: developerSettings.skipOnboarding
        onClicked: developerSettings.skipOnboarding = this.checked
    }

    CheckBox {
        id: skipLoginCheckbox
        text: "Skip login screens on startup"
        checked: developerSettings.skipLogin
        onClicked: developerSettings.skipLogin = this.checked
    }

    Button {
        text: "Reset All Settings"
        onClicked: clearAllSettings()
    }
}
