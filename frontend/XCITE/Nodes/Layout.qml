import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import Qt.labs.calendar 1.0
import "../../Controls" as Controls
import "../../Theme" 1.0

ColumnLayout {
    readonly property color cBoardBackground: "#3a3e46"
    property int tracker: 0

    id: xCiteNodes
    anchors.left: parent.left
    anchors.right: parent.right
    Layout.rightMargin: tracker == 0 ? layoutGridSpacing : ''
    spacing: tracker == 0 ? layoutGridSpacing : ''
    visible: false
    height: parent.height - 50
    RowLayout {
        id: row1
        spacing: tracker == 0 ? layoutGridSpacing : ''

        BalanceBoard {
            visible: tracker == 0
        }

        TransactionsBoard {
            visible: tracker == 0
        }
    }
    RegistrationLevel {

        visible: tracker == 1

        Label {
            id: back1

            readonly property string defaultText: qsTr("< Back")
            property bool isActive: false
            anchors.top: parent.top
            anchors.left: parent.left
            topPadding: 60
            leftPadding: 35
            font.pixelSize: 12
            font.weight: isActive ? Font.Bold : Font.Normal
            text: isActive ? altText : defaultText
            color: Theme.primaryHighlight

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    tracker = 0
                }
            }
        }
        Label {
            id: regdetails

            readonly property string defaultText: qsTr("Registration Details >")
            property bool isActive: false

            anchors.right: parent.right
            font.pixelSize: 12
            font.weight: isActive ? Font.Bold : Font.Normal
            text: isActive ? altText : defaultText
            color: Theme.primaryHighlight
            rightPadding: 50
            topPadding: 60

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    tracker = 2
                }
            }
        }
    }

    RegistrationDetails {
        visible: tracker == 2
        height: parent.height + 50

        Label {
            id: back2

            readonly property string defaultText: qsTr("< Back")

            property bool isActive: false
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            font.weight: isActive ? Font.Bold : Font.Normal
            text: isActive ? altText : defaultText
            color: Theme.primaryHighlight
            leftPadding: 35
            topPadding: 60

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    tracker = 1
                }
            }
        }
        Label {
            id: regconfirmation

            readonly property string defaultText: qsTr("Node Confirmation >")

            property bool isActive: false
            anchors.top: parent.top
            anchors.right: parent.right
            font.pixelSize: 12
            font.weight: isActive ? Font.Bold : Font.Normal
            text: isActive ? altText : defaultText
            color: Theme.primaryHighlight
            rightPadding: 50
            topPadding: 60

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    tracker = 3
                }
            }
        }
    }
    RegistrationConfirmation {
        visible: tracker == 3
        height: parent.height + 50
        Label {
            id: back3

            readonly property string defaultText: qsTr("< Back")

            property bool isActive: false
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            font.weight: isActive ? Font.Bold : Font.Normal
            text: isActive ? altText : defaultText
            color: Theme.primaryHighlight
            leftPadding: 35
            topPadding: 60

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    tracker = 2
                }
            }
        }
    }

    RowLayout {
        NetworkStatusBoard {
            visible: tracker == 0
            Controls.ButtonModal {
                Layout.fillHeight: true
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                isPrimary: true
                width: 350
                buttonHeight: 50
                label.font.weight: Font.Medium
                label.font.letterSpacing: 3
                label.text: qsTr("   Register Node ->")

                onButtonClicked: {
                    tracker = 1

                    modalAlert({
                                   bodyText: "This portion of XCite is not yet functioning, expect it soon",
                                   title: qsTr("Module Alert"),
                                   buttonText: qsTr("OK")
                               })
                    return
                }
            }
        }
    }
}
