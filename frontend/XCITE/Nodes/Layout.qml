import QtQuick 2.7
import QtQuick.Layouts 1.3
import "../../Controls" as Controls

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

        Controls.ButtonModal {
            Layout.fillHeight: true
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            isPrimary: true
            width: 300
            buttonHeight: 50
            label.font.weight: Font.Medium
            label.font.letterSpacing: 3
            label.text: qsTr("<- Back")

            onButtonClicked: {
                tracker = 0
            }
        }

        Controls.ButtonModal {
            Layout.fillHeight: true
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            isPrimary: true
            width: 350
            buttonHeight: 50
            label.font.weight: Font.Medium
            label.font.letterSpacing: 3
            label.text: qsTr("   Registration Details ->")

            onButtonClicked: {
                tracker = 2
            }
        }
    }

    RegistrationDetails {
        visible: tracker == 2
        Controls.ButtonModal {
            Layout.fillHeight: true
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            isPrimary: true
            width: 300
            buttonHeight: 50
            label.font.weight: Font.Medium
            label.font.letterSpacing: 3
            label.text: qsTr("<- Back")

            onButtonClicked: {
                tracker = 1
            }
        }
        Controls.ButtonModal {
            Layout.fillHeight: true
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            isPrimary: true
            width: 350
            buttonHeight: 50
            label.font.weight: Font.Medium
            label.font.letterSpacing: 3
            label.text: qsTr("Registration Confirmation ->")

            onButtonClicked: {
                tracker = 3
            }
        }
    }
    RegistrationConfirmation {
        visible: tracker == 3
        Controls.ButtonModal {
            Layout.fillHeight: true
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            isPrimary: true
            width: 300
            buttonHeight: 50
            label.font.weight: Font.Medium
            label.font.letterSpacing: 3
            label.text: qsTr("<- Back")

            onButtonClicked: {
                tracker = 2
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
                }
            }
        }
    }
}
