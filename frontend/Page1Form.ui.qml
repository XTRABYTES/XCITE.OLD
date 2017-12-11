import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    width: 1024
    height: 768

    RowLayout {
        width: 1028
        height: 768
        anchors.horizontalCenterOffset: 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 0
        anchors.top: parent.top
    }

    Rectangle {
        id: rectangle13
        x: 0
        y: 0
        width:parent.width
        height: parent.height
        color: "#000"
        visible: true

        Rectangle {
            id: rectangle12
            x: 824
            y: 557
            width: 200
            height: 170
            color: "#c2b300"
            clip: true

            Text {
                id: text13
                x: 74
                y: 77
                text: qsTr("BLOCK 11")
                font.pixelSize: 12
            }



        }

        Rectangle {
            id: rectangle11
            x: 618
            y: 557
            width: 200
            height: 170
            color: "#efe233"
            clip: true

            Text {
                id: text12
                x: 74
                y: 77
                text: qsTr("BLOCK 10")
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: rectangle10
            x: 412
            y: 557
            width: 200
            height: 170
            color: "#ebe166"
            clip: true

            Text {
                id: text11
                x: 77
                y: 78
                text: qsTr("BLOCK 9")
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: rectangle9
            x: 206
            y: 557
            width: 200
            height: 170
            color: "#fbf49a"

            Text {
                id: text10
                x: 77
                y: 78
                text: qsTr("BLOCK 8")
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: rectangle8
            x: 618
            y: 215
            width: 406
            height: 336
            color: "#8581cd"
            clip: true

            Text {
                id: text8
                x: 180
                y: 161
                text: qsTr("BLOCK 7")
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: rectangle7
            x: 206
            y: 215
            width: 406
            height: 336
            color: "#617fef"
            clip: true

            Text {
                id: text7
                x: 180
                y: 121
                text: qsTr("BLOCK 6")
                font.pixelSize: 12
            }
    TextField {
        text: backend.loremIpsum
        placeholderText: qsTr("type here")
        anchors.centerIn: parent

        onTextChanged: backend.loremIpsum = text
    }

    Button {
        text: "update window title"
        onClicked: pressMeSignal(backend.loremIpsum)
    }
        }

        Rectangle {
            id: rectangle6
            x: 824
            y: 39
            width: 200
            height: 170
            color: "#fe0000"
            clip: true

            Text {
                id: text5
                x: 77
                y: 78
                text: qsTr("BLOCK 5")
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: rectangle5
            x: 618
            y: 39
            width: 200
            height: 170
            color: "#f15757"
            clip: true

            Text {
                id: text4
                x: 77
                y: 78
                text: qsTr("BLOCK 4")
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: rectangle4
            x: 412
            y: 39
            width: 200
            height: 170
            color: "#f09091"
            clip: true

            Text {
                id: text3
                x: 77
                y: 78
                text: qsTr("BLOCK 3")
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: rectangle3
            x: 0
            y: 733
            width: 1024
            height: 35
            color: "#cccccc"
            clip: true

            Text {
                id: text9
                x: 485
                y: 11
                text: qsTr("INFOBAR")
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: rectangle2
            x: 0
            y: 39
            width: 200
            height: 688
            color: "#5cd106"
            clip: true

            Text {
                id: text1
                x: 59
                y: 337
                text: qsTr("BLOCK 1 MENU")
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: rectangle1
            x: 0
            y: 0
            width: 1024
            height: 33
            color: "#cccccc"
            clip: true

            Text {
                id: text6
                x: 485
                y: 11
                text: qsTr("SUBMENU")
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: rectangle
            x: 206
            y: 39
            width: 200
            height: 170
            color: "#f6b6b6"
            clip: true

            Text {
                id: text2
                x: 77
                y: 78
                text: qsTr("BLOCK 2")
                font.pixelSize: 12
            }
        }
    }
}
