import QtQuick 2.2
import QtQuick.Dialogs 1.1

MessageDialog {
    title: "Operation Failure"
    icon: StandardIcon.Warning
    text: "Your Operation Was Performed Unsuccessfully"
    Component.onCompleted: visible = true
}
