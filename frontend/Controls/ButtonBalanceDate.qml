import QtQuick 2.7
//Button representations of the optional dates in the balance board
Item {

    property alias dayText: day.text
    property alias dateText:date.text
    signal buttonClicked
    property bool isSelected: false
   // property alias day
    Rectangle{


        color:"transparent"
        width:60
        height:62
        radius:100

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                //root.buttonClicked()
            }
            hoverEnabled: true
            onHoveredChanged: {
                if (!isSelected) {
                    if (containsMouse) {
                        //root.color= "#64DDD8"
                    }
                    else {
                        //root.color= "transparent"
                    }
                }
            }
        }

        Text{
            id:day
            color:"#576271"
            font.pixelSize: 14
            font.family: "Roboto"
            text: "Uninstantiated Day Text"
        }

        Text{
            id:date
            color:"#576271"
            font.pixelSize: 20
            font.family: "Roboto"
            text: "Uninstantiated Date Text"
            anchors.top:parent.top
            anchors.topMargin:15
        }




    }


}
