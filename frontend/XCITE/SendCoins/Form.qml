import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "../../Controls" as Controls

ColumnLayout {
    property alias address: formAddress
    property alias amount: formAmount

    Layout.fillWidth: true

    // Amount
    Controls.FormLabel {
        Layout.bottomMargin: 25
        text: qsTr("Amount")
    }

    Controls.TextInput {
        id: formAmount

        Layout.fillWidth: true
        text: "0"

        validator: DoubleValidator {
            bottom: 0
        }

        TextXBY {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 12
            anchors.bottomMargin: 5
        }
    }

    Controls.SliderAmount {
        id: slider
        Layout.preferredWidth: parent.width
        Layout.bottomMargin: 10
        Layout.topMargin: 10
        totalAmount: balance

        onMoved: {
            formAmount.text = Number(value).toFixed(2)
        }
    }

    // Pay To
    Controls.FormLabel {
        Layout.topMargin: 20
        Layout.bottomMargin: 25
        text: qsTr("Pay to")
    }

    Label {
        font.pixelSize: 12
        bottomPadding: 10
        color: "#d5d5d5"
        text: qsTr("Enter a XTRABYTES address in here.\nEx: BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS ")
    }

    Controls.TextInput {
        id: formAddress

        Layout.fillWidth: true
        font.pixelSize: 24

        Connections {
            onTextEdited: {
                addressBook.control.currentIndex = -1
            }
        }
    }

    Label {
        id: chooseFromAddressBookLabel
        Layout.topMargin: 6
        anchors.right: parent.right
        horizontalAlignment: Text.AlignRight
        rightPadding: 20
        font.pixelSize: 12
        text: qsTr("Or add a recipient from your address book")
        color: "#d5d5d5"
        visible: xcite.width > 1100
        Image {
            fillMode: Image.PreserveAspectFit
            source: "../../icons/right-arrow2.svg"
            width: 19
            height: 13
            sourceSize.width: 19
            sourceSize.height: 13
            anchors.right: parent.right
        }
    }

    // Total
    Controls.FormLabel {
        Layout.topMargin: 40 - (xcite.width > 1100 ? chooseFromAddressBookLabel.height + 1 : 0)
        Layout.bottomMargin: 25
        text: qsTr("Total")
    }

    RowLayout {
        TextXBY {
            Layout.alignment: Qt.AlignBottom
            Layout.bottomMargin: 5
        }

        Label {
            text: Number(totalAmount).toFixed(2)
            font.weight: Font.Light
            font.pixelSize: 36
            color: "#d5d5d5"
        }
    }

    Label {
        topPadding: 10
        font.pixelSize: 12
        color: "#d5d5d5"
        text: qsTr("Transaction fee:") + " " + networkFee + " " + qsTr("XBY")
    }
}
