import QtQuick 2.2
import QtQuick.Dialogs 1.1

MessageDialog {
    title: "Operation Success"
    icon: StandardIcon.Information
    text: "Your Operation Was Performed Successfully"
    Component.onCompleted: visible = true
}
