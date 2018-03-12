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
        Layout.topMargin: 10
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
        leftPadding: 4
        rightPadding: 4
        text: developerSettings.initialView

        onAccepted: {
            developerSettings.initialView = this.text.trim()
        }
    }

    CheckBox {
        id: skipLoginCheckbox
        text: "Skip login screens on startup"
        checked: developerSettings.skipLogin
        onClicked: developerSettings.skipLogin = this.checked
    }
}
