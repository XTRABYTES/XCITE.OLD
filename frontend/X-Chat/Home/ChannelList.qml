import QtQuick 2.0

Column {
    property variant items
    width: parent.width
    Repeater {

        width: parent.width
        id: groupChannels
        model: items

        Rectangle {
            id: channelBackground
            color: "transparent"
            width: parent.width
            height: itemHeight

            Text {

                text: name
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 18
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    selected = true
                    //group.channelSelected(index)
                    channelBackground.color = "#666B78"
                }
            }
        }
    }
}
