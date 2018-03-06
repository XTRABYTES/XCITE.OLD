import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import Clipboard 1.0

ApplicationWindow {
    property bool isNetworkActive: false

    id: xcite

    visible: true

    width: Screen.width
    height: Screen.height
    title: qsTr("XCITE")
    color: "#2B2C31"

    overlay.modal: Rectangle {
        color: "#c92a2c31"
    }

    StackView {
        id: mainRoot
        initialItem: DashboardForm {
        }
        anchors.fill: parent
    }

    Clipboard {
        id: clipboard
    }
}
