import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0

import "../../Controls" as Controls

Controls.Diode {
    title: qsTr("FILTER TRANSACTIONS")

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 75
        anchors.leftMargin: 15
        anchors.rightMargin: 15

        Label {
            font.family: "Roboto"
            font.weight: Font.Light
            font.pixelSize: 16
            text: qsTr("Type")
        }

        Controls.ComboBox {
            Layout.fillWidth: true
            model: ["Please select", "Foo", "Bar", "Baz"]
        }

        Label {
            topPadding: 15
            bottomPadding: 5
            font.family: "Roboto"
            font.weight: Font.Light
            font.pixelSize: 16
            text: qsTr("Dates between")
        }

        Controls.DatePicker {
            z: 3
        }

        Label {
            topPadding: 5
            bottomPadding: 5
            font.family: "Roboto"
            font.weight: Font.Light
            font.pixelSize: 16
            text: qsTr("and")
        }

        Controls.DatePicker {
            z: 2
        }

        Label {
            topPadding: 15
            font.family: "Roboto"
            font.weight: Font.Light
            font.pixelSize: 16
            text: qsTr("To")
        }

        Controls.ComboBox {
            z: 1
            Layout.fillWidth: true
            model: ["Select address"]
        }

        Label {
            topPadding: 20
            font.family: "Roboto"
            font.weight: Font.Light
            font.pixelSize: 16
            text: qsTr("Transaction value")
        }

        RangeSlider {
            first.value: 0
            second.value: 60000
        }
    }
}
