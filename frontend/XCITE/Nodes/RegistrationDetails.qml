import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0
import "../../Controls" as Controls
import "../../Theme" 1.0
import QtQuick.Extras 1.4


/**
  * Refactored, needs cleaning up on the Low, Medium High Texts, see line 136
  */
Rectangle {

    // primary rectangle properties
    property int pageTracker: 0
    id: regDetails
    width: parent.width - 100
    height: parent.height - 500
    Layout.minimumHeight: 100
    color: "#3A3E47"
    radius: 5
    anchors.fill: parent

    ColumnLayout {
        Text {
            id: text2
            Layout.topMargin: 10
            Layout.leftMargin: 13
            width: 143
            height: 23
            color: "#e2e2e2"
            text: qsTr("Node Registration")
            font.family: "Roboto"
            font.pixelSize: 18
        }
        Rectangle {
            id: rectangle
            Layout.topMargin: 8

            width: 1320
            height: 1
            color: "#535353"
        }
    }
    // Second layer text
    ColumnLayout {
        anchors.top: parent.top
        anchors.topMargin: 65
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

        Controls.FormLabel {
            Layout.topMargin: 20
            text: qsTr("Registration Details")
            Layout.leftMargin: 25
            font.pixelSize: 19
            font.family: "Roboto"
        }
        Label {
            Layout.leftMargin: 25
            Layout.topMargin: 30
            font.family: "Roboto"
            font.pixelSize: 16
            text: "Static registration string"
        }
        Label {
            Layout.leftMargin: 25
            Layout.topMargin: 6
            font.pixelSize: 12
            font.family: "Roboto"
            text: "Save this code in a safe location"
            font.weight: Font.Medium
            color: "#FFFFFF"
        }

        TextArea {
            id: regString
            text: "   aFEFR452ffaf778wyJc5i8upNm5Vv8HMkwXqBR3kaf3452CxS"
            font.family: "Roboto"
            width: contentWidth + 20

            Layout.leftMargin: 25
            Layout.topMargin: 5
            background: Rectangle {
                width: regString.width + 20
                color: "#2A2C31"
                radius: 4
                border.width: parent.activeFocus ? 2 : 0
                border.color: Theme.primaryHighlight
            }
        }
        Label {

            Image {
                fillMode: Image.PreserveAspectFit
                source: "../../icons/copy-clipboard.svg"
                anchors.right: parent.left
                anchors.rightMargin: 5
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        regString.text.copy()

                        // do what you want here
                    }
                }
            }

            font.pixelSize: 12
            font.family: "Roboto"
            Layout.leftMargin: 45
            Layout.topMargin: 5
            text: "Copy string to clipboard"
            font.weight: Font.Medium
            color: "#FFFFFF"
        }
        Label {
            font.pixelSize: 16
            font.family: "Roboto"
            Layout.leftMargin: 25
            Layout.topMargin: 20
            text: "XBY Deposit Address"
        }
        TextArea {
            id: addString
            text: "   BMy2BpwyJc5i8upNm5Vv8HMkwXqBR3kCxS"

            width: contentWidth + 20
            Layout.leftMargin: 25

            font.family: "Roboto"
            Layout.topMargin: 10
            background: Rectangle {
                width: addString.width + 20
                color: "#2A2C31"
                radius: 4
                border.width: parent.activeFocus ? 2 : 0
                border.color: Theme.primaryHighlight
            }
        }

        Label {
            font.pixelSize: 16
            font.family: "Roboto"
            Layout.leftMargin: 25
            Layout.topMargin: 20
            text: "Accept transaction fee"
        }
        Label {
            font.pixelSize: 12
            font.family: "Roboto"
            Layout.leftMargin: 25
            Layout.topMargin: 3
            text: "Save this code in a safe location"
            color: "#FFFFFF"
            font.weight: Font.Medium
        }
        Controls.Switch {
            on: false
            Layout.topMargin: 15
            Layout.leftMargin: 50
            Label {
                anchors.right: parent.left
                anchors.rightMargin: 10
                text: "No"
            }
            Label {
                anchors.left: parent.right
                anchors.leftMargin: 10
                text: "Yes"
            }
        }

        Label {
            font.pixelSize: 16
            font.family: "Roboto"
            Layout.leftMargin: 25
            Layout.topMargin: 20
            text: "Total Deposit"
        }
        Label {
            font.pixelSize: 14
            font.family: "Roboto"
            Layout.leftMargin: 25
            Layout.topMargin: 10
            text: "XBY "
        }
        Controls.ButtonModal {
            font.pixelSize: 18
            font.family: "Roboto"
            Layout.leftMargin: 25
            Layout.topMargin: 35
            labelText: "CONFIRM"
            height: 42
            Layout.fillWidth: true
            Layout.minimumWidth: 180
            Layout.preferredWidth: 230
            Layout.maximumWidth: 300
            label.font.weight: Font.Medium
            isPrimary: true
        }
    }
}
