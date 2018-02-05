import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import xtrabytes.xcite.xchat 1.0
import "Login" as LoginComponents

ApplicationWindow {
    property bool isNetworkActive: true

    id: xcite

    visible: true
    width: 1440
    height: 1024
    title: qsTr("Hello XCITE")
    color: "#2B2C31"
    
    overlay.modal: Rectangle {
        color: "#c92a2c31"
    }

    StackView {
        id: mainRoot
        initialItem: LoginComponents.LoginForm {}
        anchors.fill: parent
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }
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
