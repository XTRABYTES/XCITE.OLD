import QtQuick 2.0

Item {
    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 380
        height: 470
        color: "#3a3e46"
        radius: 5
        opacity: 1

        Rectangle {
            id: rectangle1
            x: 0
            y: 45
            width: 380
            height: 1
            color: "#9fa0a3"
            opacity: 0.2
        }

        Text {
            id: text1
            y: 16
            color: "#e2e2e2"
            text: qsTr("BALANCE")
            anchors.left: parent.left
            anchors.leftMargin: 21
            font.family: "Roboto Condensed"
            font.pixelSize: 15
        }

        Text {
            id: text2
            x: 222
            y: 18
            color: "#e2e2e2"
            text: qsTr("Day, Week, Month")
            anchors.right: parent.right
            anchors.rightMargin: 59
            font.family: "Roboto"
            font.pixelSize: 12
        }

        LabelUnderlined{
            id: dailyText
            x: 0
            y:213
            text:"Daily"
            anchors.left: parent.left
            anchors.leftMargin: 33
            pixelSize:19

        }

        Text{
            id: dailyValue
            x:263
            y:195
            color:"#D5D5D5"
            font.pixelSize: 54
            text:"550"
            anchors.right: parent.right
            anchors.rightMargin: 30

        }

        Text{
            id: monthlyValue
            x:189
            y:281
            color:"#D5D5D5"
            font.pixelSize: 54
            text:"23,000"
            anchors.right: parent.right
            anchors.rightMargin: 30

        }

        Text{
            id: totalValue
            x:160
            y:363
            color:"#0ED8D2"
            font.pixelSize: 54
            text:"198,009"
            anchors.right: parent.right
            anchors.rightMargin: 30

        }

        LabelUnderlined{
            id: monthlyText
            y:299
            text:"Monthly"
            anchors.left: parent.left
            anchors.leftMargin: 33
            pixelSize:19

        }

        LabelUnderlined{
            y:384
            text:"Total"
            anchors.left: parent.left
            anchors.leftMargin: 33
            pixelSize:19

        }
    }

}
