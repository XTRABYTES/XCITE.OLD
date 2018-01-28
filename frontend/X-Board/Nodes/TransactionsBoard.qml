import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../../Controls" as Controls

Rectangle{
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumHeight: 100
    Layout.minimumWidth: 800
    color: "#3A3E47"
    anchors.rightMargin:15
    anchors.topMargin:50
    radius:5

    //Horizontal gray ruler
    Rectangle {
        id: rectangle1
        x: 0
        y: 45
        width: parent.width
        height: 1
        color: "#9fa0a3"
        opacity: 0.2
    }

    //Balance header text
    Text {
        id: text1
        y: 16
        color: "#e2e2e2"
        text: qsTr("Node Transactions")
        anchors.left: parent.left
        anchors.leftMargin: 21
        font.family: "Roboto Condensed"
        font.pixelSize: 15
    }

    Text {
        id: textid

        y: 18
        color: "#e2e2e2"
        text: qsTr("Complete View")
        anchors.right: parent.right
        anchors.rightMargin:15
        font.family: "Roboto"
        font.pixelSize: 12
    }

    RowLayout {
        Controls.LabelUnderlined{
            y:74
            text:qsTr("Address")
            anchors.left: parent.left
            anchors.leftMargin: 29
            pixelSize:15
        }
        Controls.LabelUnderlined{
            y:74
            text:qsTr("TimeIn")
            anchors.left: parent.left
            anchors.leftMargin: 217
            pixelSize:15
        }

        Controls.LabelUnderlined{
            y:74
            text:qsTr("Process")
            anchors.left: parent.left
            anchors.leftMargin: 386
            pixelSize:15
        }

        Controls.LabelUnderlined{
            y:74
            text:qsTr("Executed")
            anchors.left: parent.left
            anchors.leftMargin: 555
            pixelSize:15
        }

        Controls.LabelUnderlined{
            y:74
            text:qsTr("Type")
            anchors.left: parent.left
            anchors.leftMargin: 741
            pixelSize:15
        }



    }


}
