import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import "../Theme" 1.0
import "../Controls" as Controls

Item {
    id: container

    property variant currentItem
    property bool btnAddEnabled: true
    property bool btnEditEnabled: true
    property bool btnRemoveEnabled: true
    property string type: "RECIPIENT"

    signal addressAdded(string name, string address)
    signal addressUpdated(string name, string address)
    signal addressRemoved

    signal btnEditClicked
    signal btnAddClicked

    RowLayout {
        Layout.fillWidth: true

        Controls.ButtonIconText {
            id: addAddress
            text: qsTr("ADD" + (xcite.width > 1236 ? " " + type : ""))
            Layout.maximumWidth: (xcite.width > 1236 ? 116 : 80)
            backgroundColor: "transparent"
            hoverBackgroundColor: Theme.primaryHighlight
            iconFile: "../../icons/circle-cross.svg"
            onButtonClicked: {
                btnAddClicked()
            }
        }

        Controls.ButtonIconText {
            id: editButton
            visible: type === "RECIPIENT"
            text: qsTr("EDIT")
            anchors.left: addAddress.left
            anchors.leftMargin: 135
            Layout.maximumWidth: 67
            opacity: btnEditEnabled ? 1 : 0
            backgroundColor: "transparent"
            hoverBackgroundColor: Theme.primaryHighlight
            iconFile: "../../icons/pencil.svg"

            onButtonClicked: {
                if (!btnEditEnabled) {
                    return
                }

                if (!currentItem) {
                    return
                }

                btnEditClicked()
            }
        }

        Controls.ButtonIconText {
            id: removeButton
            text: qsTr("REMOVE")
            Layout.maximumWidth: 89
            backgroundColor: "transparent"
            hoverBackgroundColor: Theme.primaryHighlight
            iconFile: "../../icons/trash.svg"

            onButtonClicked: {
                var item = currentItem.item

                var text = qsTr("Are you sure you want to remove this address?")

                confirmationModal({
                                      title: qsTr(
                                                 "REMOVE ADDRESS CONFIRMATION"),
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
}
