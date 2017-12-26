import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Rectangle {
    id: xchatpopup

    x: 50
    y: 50
    width: 250
    height: 450

    radius: 5
    border.color: "#000000"
    border.width: 2
    smooth: true
    color: "#5e5e5e"

    state: "visible"

    states: [
        State {
            name: "invisible"
            PropertyChanges { target: xchatpopup; opacity: 0 }
        },

        State {
            name: "visible"
            PropertyChanges { target: xchatpopup; opacity: 1.0 }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "opacity"; duration: 100 }
    }

    function toggle() {
        if (state == "visible")
            state = "invisible";
        else
            state = "visible";
    }




Rectangle {
    id: frame
    clip: true
    border.color: "black"
    anchors.top: parent.top
    anchors.topMargin: 5
    color: "#EEEEEE"
    width: 240
    height: 370
    x: 5
    y: 5

    Text {
        id: content
        padding: 5
        text: responseTXT
        font.pixelSize: 12
        y: -vbar.position * height

    }

    ScrollBar {
        id: vbar
        hoverEnabled: true
        active: hovered || pressed
        orientation: Qt.Vertical
        size: frame.height / content.height
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

        }

Pane {
	      id: pane
	      width: 240
			y: 380
			x: 5

         RowLayout {
                		width: parent.width                		

                		TextField {
                    		id: messageField
                    		text: xchat.messageTXT
                    		onTextChanged: xchat.messageTXT = text
                    		font.pixelSize: 16
                    		Layout.fillWidth: true
                    		placeholderText: qsTr("Xchat message")
                    		wrapMode: TextArea.Wrap
                		}

                		Button {
										Layout.minimumWidth: 32
        								Layout.maximumWidth: 32
        								Layout.minimumHeight: 32
        								Layout.maximumHeight: 32

										Image {
										        anchors.fill: parent
										        source: "buttons/ok.png"
										        fillMode: Image.Tile
										    	}
	
	                    			id: sendMsgButton
	                    			enabled: messageField.length > 0
	                    			onClicked: { 
	                    			   xchatSubmitMsgSignal(xchat.messageTXT,responseTXT)
	                    			   xchat.messageTXT = ""
	                    			}   
                				}
            		}
      }
        
}