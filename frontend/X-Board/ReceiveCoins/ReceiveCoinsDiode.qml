import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
//import QtQuick.Controls 2.3
import "../../Controls" as Controls

Rectangle {
    id: receiveCoinsDiode
    color: cDiodeBackground
    width: 928
    height: 645
    radius: 6
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.leftMargin: 389
    anchors.topMargin: 0
    Layout.minimumWidth: 928
    Layout.minimumHeight: 645
    Layout.fillWidth: true

    anchors.rightMargin: layoutGridSpacing

    Controls.DiodeHeader {
        id: boardHeader
        text: qsTr("RECEIVE XBY")
        menuLabelText: qsTr("XBY")
        Layout.minimumWidth: 928
    }

    RowLayout {
        ColumnLayout {
            anchors.top: parent.top
            Layout.minimumWidth: 568
            Controls.LabelUnderlined {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 75
                anchors.leftMargin: 22
                text: qsTr("Main")
                pixelSize: 16
            }

            Rectangle {
                color: "#2A2C31"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 129
                anchors.leftMargin: 22
                Layout.minimumWidth: 516
                Layout.minimumHeight: 56
                radius: 5

                TextField {
                    id: formAddress
                    placeholderText: "BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS"

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: 10
                    anchors.leftMargin: 16
                    width: 500
                    font.pointSize: 18
                    font.family: "Roboto Thin"
                    style: TextFieldStyle {
                        textColor: "#ffffff"
                        placeholderTextColor: "#ffffff"
                        background: Rectangle {
                            color: "transparent"
                            width: 485
                        }
                    }
                }
            }

            RowLayout {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 22
                anchors.topMargin: 196
                Layout.minimumWidth: 516

                Text {
                    font.pixelSize: 12
                    font.family: "Roboto"
                    font.weight: Font.Light
                    text: "Copy address to clipboard"
                    color: "#E3E3E3"
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 24

                    Image {
                        id:copyImage
                        fillMode: Image.PreserveAspectFit
                        source: "../../icons/copy-clipboard.svg"
                        width: 19
                        height: 13
                        sourceSize.width: 19
                        sourceSize.height: 13
                        anchors.right: parent.left
                        anchors.top:parent.top;
                        anchors.topMargin:parent.Center
                        anchors.rightMargin: 5

                        MouseArea{
                            anchors.fill:parent
                            cursorShape:Qt.PointingHandCursor
                            onClicked:{

                                copyTextTimer.start()
                                copyImage.source = "../../icons/circle-cross.svg"
                            }
                        }

                        Timer {
                            id:copyTextTimer
                            interval: 3000; running: false; repeat: false
                            onTriggered: copyImage.source = "../../icons/copy-clipboard.svg"
                        }
                    }

                }

                Text {
                    font.pixelSize: 12
                    font.family: "Roboto"
                    font.weight: Font.Light
                    text: "Or change to another address from your list"
                    color: "#E3E3E3"
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 256
                }
            }

            Controls.LabelUnderlined {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 250
                anchors.leftMargin: 22
                text: qsTr("QR Code")
                pixelSize: 16
            }

            Label {
                font.pixelSize: 12
                font.family: "roboto"
                //                font.weight: Font.Light
                text: "Simply send money to this address by scanning this QR code"
                color: "#E3E3E3"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 298
                anchors.leftMargin: 22


            }

            Image {
                fillMode: Image.PreserveAspectFit
                source: "../../icons/right-arrow2.svg"
                width: 19
                height: 13
                sourceSize.width: 19
                sourceSize.height: 13
                anchors.right: parent.right
                anchors.top:parent.top;
                anchors.topMargin:196
                anchors.rightMargin: 30
            }

            Image {
                fillMode: Image.PreserveAspectFit
                source: "../../icons/placeholder-qr.png"
                width: 264
                height: 264
                sourceSize.width: 264
                sourceSize.height: 264
                anchors.right: parent.right
                anchors.top:parent.top;
                anchors.topMargin:345
                anchors.rightMargin: 159
            }


        }

        Rectangle {
            width: 1
            height: 562
            color: "#535353"
            anchors.left: parent.left
            anchors.leftMargin: 569
            anchors.top: parent.top
            anchors.topMargin: 59
        }

        ColumnLayout {
            anchors.top: parent.top
            Controls.LabelUnderlined {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 75
                anchors.leftMargin: 18
                text: qsTr("My Addresses")
                pixelSize: 16
            }

            Rectangle{
                color:"#2A2C31"
                radius:5
                width:317
                height:434
                anchors.top:parent.top
                anchors.left:parent.left
                anchors.topMargin:129
                anchors.leftMargin:18
                Controls.AddressBook{
                    id: addressBook
                    onCurrentItemChanged: {
                        var item = model.get(currentIndex)
                        formAddress.text = item.address
                    }
                    model:addressModel
                }

                ListModel {
                    id: addressModel

                    ListElement {
                        name: "Default"
                        address: "BMy2BpwyJc5i7upNm5Vv8HMkwXqBR3kCxS"
                    }

                    ListElement {
                        name: "Main"
                        address: "Jc5i7upNmBMy2Bpwy5Vv8HMkwXqBR3kCxS"
                    }

                    ListElement {
                        name: "Secondary"
                        address: "upNm5Vv8HMkBMy2BpwyJc5i7wXqBR3kCxS"
                    }


                }

            }

            RowLayout {
                Controls.ButtonIconText {
                    text: qsTr("ADD ADDRESS")
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 18
                    anchors.topMargin: 145
                    width: 116
                    backgroundColor: "transparent"
                    hoverBackgroundColor: "#0ED8D2"
                    iconDirectory:"../../icons/circle-cross.svg"
                    onButtonClicked: {
                        var item = addressBook.currentItem.item

                        var text = qsTr("Are you sure you want to send")

                        confirmationModal({
                                              title: qsTr("PAYMENT CONFIRMATION"),
                                              text: text,
                                              confirmText: qsTr("CONFIRM"),
                                              cancelText: qsTr("CANCEL")

                                          })
                    }
                }

                Controls.ButtonIconText {
                    text: qsTr("EDIT")
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 157
                    anchors.topMargin: 145
                    width: 67
                    backgroundColor: "transparent"
                    hoverBackgroundColor: "#0ED8D2"
                    iconDirectory:"../../icons/pencil.svg"
                }

                Controls.ButtonIconText {
                    id:removeButton
                    text: qsTr("REMOVE")
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 247
                    anchors.topMargin: 145
                    width: 89
                    backgroundColor: "transparent"
                    hoverBackgroundColor: "#0ED8D2"
                    iconDirectory:"../../icons/trash.svg"

                    onButtonClicked: {
                        var item = addressBook.currentItem.item

                        var text = qsTr("Are you sure you want to remove this address")

                        confirmationModal({
                                              title: qsTr("PAYMENT CONFIRMATION"),
                                              text: text,
                                              confirmText: qsTr("CONFIRM"),
                                              cancelText: qsTr("CANCEL"),
                                          },
                                          function(modal){   //OnConfirmed

                                              if(addressBook.currentItem != null){
                                                  addressModel.remove(addressBook.currentIndex);
                                              }
                                          })
                    }
                }
            }
        }
    }
}
