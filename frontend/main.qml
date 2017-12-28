import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import xtrabytes.xcite.xchat 1.0

ApplicationWindow {
    visible: true
    width: 1024
    height: 768
    title: qsTr("Hello XCITE")
    
    property var responseTXT: ""

    StackView {
        id: mainRoot
        initialItem: LoginForm {}
        anchors.fill: parent
    }

    Xchat {
        id: xchat
    }

    signal xchatSubmitMsgSignal(string msg, string responseTXT)

    function xchatResponse(response){
      responseTXT = response
    }
}
