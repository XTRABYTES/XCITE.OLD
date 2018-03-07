import QtQuick 2.2
import QtQuick.Dialogs 1.1


/**
  * Basic Dialog for a failed operation
  */
MessageDialog {
    title: "Operation Failure"
    icon: StandardIcon.Warning
    text: "Your Operation Was Performed Unsuccessfully"
    Component.onCompleted: visible = true
}
