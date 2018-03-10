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
        spacing: 15

        Controls.ButtonIconText {
            id: addAddress
            width: 55
            border.width: 0
            size: 16
            backgroundColor: Theme.primaryHighlight
            iconFile: "../../icons/circle-cross.svg"
            onButtonClicked: {
                btnAddClicked()
            }
        }

        Controls.ButtonIconText {
            id: editButton
            visible: type === "RECIPIENT"
            width: 55
            border.width: 0
            size: 16
            opacity: btnEditEnabled ? 1 : 0
            backgroundColor: Theme.primaryHighlight
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
            width: 55
            size: 16
            backgroundColor: Theme.primaryDanger
            iconFile: "../../icons/trash.svg"
            border.width: 0

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
