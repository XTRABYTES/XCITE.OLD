import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "../../Controls" as Controls


Rectangle{
id:receiveBoard
    anchors.left:parent.left
    anchors.leftMargin:389
    anchors.top:parent.top
    width:928
    height:645


    Layout.minimumWidth:928
    Layout.minimumHeight:  645

    color:cBoardBackground
    radius:6
    //Layout.fillWidth: true
    anchors.topMargin: 0

    anchors.right:parent.right
    anchors.rightMargin: layoutGridSpacing


    Controls.BoardHeader {
        id: boardHeader
        text: qsTr("RECEIVE XBY")
        menuLabelText: qsTr("XBY")
    }

        ColumnLayout{
            Controls.LabelUnderlined{
                anchors.top:parent.top;
                anchors.left:parent.left;
                anchors.topMargin: 75
                anchors.leftMargin: 22
                text:qsTr("Main")
                pixelSize: 16

            }

            Rectangle{
               color:"#2A2C31"
               anchors.top:parent.top;
               anchors.left:parent.left;
               anchors.topMargin: 129
               anchors.leftMargin: 22
               Layout.minimumWidth:516
               Layout.minimumHeight: 56
               radius:5

               TextField{
                   placeholderText: "BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS"

                   anchors.top:parent.top
                   anchors.left:parent.left
                   anchors.topMargin:10
                   anchors.leftMargin:16
                   width:500
                   font.pointSize:18
                    font.family: "Roboto Thin"
                   style: TextFieldStyle {
                      textColor: "#ffffff"
                      placeholderTextColor: "#ffffff"
                      background: Rectangle {
                          color: "transparent"
                          width:485
                      }
                   }

               }

            }

            RowLayout{
                anchors.left:parent.left;
                anchors.top:parent.top
                anchors.leftMargin:22
                anchors.topMargin:196

                Layout.minimumWidth: 516
                Text{
                    font.pixelSize: 12
                    font.family: "Roboto"
                    font.weight: Font.Light
                    text: "Copy address to clipboard"
                    color: "#E3E3E3"
                    anchors.top:parent.top
                    anchors.left:parent.left
                    anchors.leftMargin:24

                }

                Text{
                    font.pixelSize: 12
                    font.family: "Roboto"
                    font.weight: Font.Light
                    text: "Or change to another address from your list"
                    color: "#E3E3E3"
                    anchors.top:parent.top
                    anchors.left:parent.left
                    anchors.leftMargin:256

                }
            }


            Controls.LabelUnderlined{
                anchors.top:parent.top;
                anchors.left:parent.left;
                anchors.topMargin: 250
                anchors.leftMargin: 22
                text:qsTr("QR Code")
                pixelSize: 16

            }

            Text{
                font.pixelSize: 12
                font.family: "Roboto"
                font.weight: Font.Light
                text: "Simply send money to this address by scanning this QR code"
                color: "#E3E3E3"
                anchors.top:parent.top
                anchors.left:parent.left
                anchors.topMargin:298
                anchors.leftMargin:22

            }
        }

        Rectangle{
            width:1
            height:562
            color:"#535353"
            anchors.left:parent.left;
            anchors.leftMargin:569
            anchors.top:parent.top
            anchors.topMargin:59
        }





        ColumnLayout{

        }








}
