import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import xtrabytes.xcite.xchat 1.0

ApplicationWindow {
    property bool isNetworkActive: true

    id: xcite

    visible: true
    width: 1440
    height: 1024
    title: qsTr("XCITE")
    color: "#2B2C31"
    
    overlay.modal: Rectangle {
        color: "#c92a2c31"
    }

    Loader {
        id: rootLoader
        anchors.fill: parent
        source: "Login/LoginForm.qml";
    }

    Xchat {
        id: xchat
    }

    signal xchatSubmitMsgSignal(string msg)
    signal xChatMessageReceived(string message, date datetime)

    function xchatResponse(response) {
        xChatMessageReceived(response, new Date());
    }
}
