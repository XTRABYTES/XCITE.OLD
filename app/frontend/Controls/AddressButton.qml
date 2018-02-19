import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "../Controls" as Controls

Item {
    id: container

    property variant currentItem

    signal addressAdded(string name, string address)
    signal addressUpdated(string name, string address)
    signal addressRemoved

    Controls.ButtonIconText {
        id: addAddress
        text: qsTr("ADD ADDRESS")
        anchors.left: parent.left
        anchors.leftMargin: 20
        width: 116
        backgroundColor: "transparent"
        hoverBackgroundColor: "#0ED8D2"
        iconDirectory: "../../icons/circle-cross.svg"
        onButtonClicked: {
            var item = currentItem.item
            var text = qsTr("Enter the name of the address")

            confirmationModal({
                                  title: qsTr("ADD ADDRESS CONFIRMATION"),
                                  bodyText: text,
                                  confirmText: qsTr("CONFIRM"),
                                  cancelText: qsTr("CANCEL"),
                                  showInput: true
                              }, function (modal, inputValue) {

                                  //OnConfirmed
                                  if (inputValue !== "") {
                                      addressAdded(inputValue, "newaddress")
                                  }
                              })
        }
    }

    Controls.ButtonIconText {
        id: editButton
        text: qsTr("EDIT")
        anchors.left: addAddress.left
        anchors.leftMargin: 135
        width: 67
        backgroundColor: "transparent"
        hoverBackgroundColor: "#0ED8D2"
        iconDirectory: "../../icons/pencil.svg"

        onButtonClicked: {
            if (!currentItem) {
                return
            }

            var item = currentItem.item

            var text = qsTr("Edit the name of the address")
            var itemValue = currentItem.item
            confirmationModal({
                                  title: qsTr("EDIT ADDRESS CONFIRMATION"),
                                  bodyText: text,
                                  confirmText: qsTr("CONFIRM"),
                                  cancelText: qsTr("CANCEL"),
                                  showInput: true,
                                  inputValue: itemValue
                              }, function (modal, inputValue) {
                                  //OnConfirmed
                                  if (inputValue != "") {
                                      addressUpdated(item.name, inputValue)
                                  }
                              })
        }
    }

    Controls.ButtonIconText {
        id: removeButton
        text: qsTr("REMOVE")
        anchors.left: editButton.left
        anchors.leftMargin: 85
        width: 89
        backgroundColor: "transparent"
        hoverBackgroundColor: "#0ED8D2"
        iconDirectory: "../../icons/trash.svg"

        onButtonClicked: {
            var item = currentItem.item

            var text = qsTr("Are you sure you want to remove this address?")

            confirmationModal({
                                  title: qsTr("REMOVE ADDRESS CONFIRMATION"),
                                  bodyText: text,
                                  confirmText: qsTr("CONFIRM"),
                                  cancelText: qsTr("CANCEL")
                              }, function (modal) {

                                  //OnConfirmed
                                  if (currentItem !== null) {
                                      addressRemoved()
                                  }
                              })
        }
    }
}
