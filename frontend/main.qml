import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import xtrabytes.xcite.backend 1.0

ApplicationWindow {
    visible: true

    width: 1024
    height: 768
    title: qsTr("Hello XCITE")

       Page1 {
       }

    BackEnd {
        id: backend

    }


    function setTextFieldCall(text){
      title = text
    }

    signal pressMeSignal(string msg)

}
