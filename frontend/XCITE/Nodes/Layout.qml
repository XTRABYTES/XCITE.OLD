import QtQuick 2.0
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
    /**
    */
    RegistrationLevel {
        visible: tracker == 1
        Controls.NavigateButtons {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            label.text: qsTr("<- Back")
            isPrimary: true
            width: 350
            buttonHeight: 50
            onButtonClicked: {
                tracker = 0
            }
        }

        Controls.NavigateButtons {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            label.text: qsTr("   Registration Details ->")
            isPrimary: true
            width: 350
            buttonHeight: 50
            onButtonClicked: {
                tracker = 2
            }
        }
    }
    RegistrationDetails {
        visible: tracker == 2
        Controls.NavigateButtons {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            label.text: qsTr("<- Back")
            isPrimary: true
            width: 350
            buttonHeight: 50
            onButtonClicked: {
                tracker = 1
            }
        }
        Controls.NavigateButtons {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            label.text: qsTr("Registration Confirmation ->")
            isPrimary: true
            width: 350
            buttonHeight: 50
            onButtonClicked: {
                tracker = 3
            }
        }
    }

    RegistrationConfirmation {
        visible: tracker == 3
        Controls.NavigateButtons {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            label.text: qsTr("<- Back")
            isPrimary: true
            width: 350
            buttonHeight: 50
            onButtonClicked: {
                tracker = 2
            }
        }
    }

    RowLayout {
        NetworkStatusBoard {
            visible: tracker == 0

            Controls.NavigateButtons {
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                label.text: qsTr("   Register Node ->")
                isPrimary: true
                width: 350
                buttonHeight: 50
                onButtonClicked: {
                    tracker = 1
                }
            }
        }
    }
}
