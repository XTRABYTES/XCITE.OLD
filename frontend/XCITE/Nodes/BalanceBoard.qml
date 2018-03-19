import QtQuick 2.7
import QtQuick.Layouts 1.3
import "../../Controls" as Controls
import "../../Theme" 1.0


//Balance board used on the Nodes page (left hand side)
Controls.Diode {
    id: rectangle
    x: 0
    y: 0
    width: 380
    height: 470
    color: "#3a3e46"
    radius: 5
    opacity: 1
    Layout.minimumHeight: 470
    Layout.fillHeight: true

    Controls.DiodeHeader {
        id: diodeHeader
        text: qsTr("BALANCE")
    }

    //Horizontal gray ruler
    Text {
        id: text2
        x: 222
        y: 18
        color: "#e2e2e2"
        text: qsTr("Day, Week, Month")
        anchors.right: parent.right
        anchors.rightMargin: 59
        font.pixelSize: 12
    }

    //Balances text values
    Text {
        id: dailyValue
        x: 263
        y: 195
        color: "#D5D5D5"
        font.pixelSize: 54
        text: "550"
        anchors.right: parent.right
        anchors.rightMargin: 30
    }

    Text {
        id: monthlyValue
        x: 189
        y: 281
        color: "#D5D5D5"
        font.pixelSize: 54
        text: "23,000"
        anchors.right: parent.right
        anchors.rightMargin: 30
    }

    Text {
        id: totalValue
        x: 160
        y: 363
        color: Theme.primaryHighlight
        font.pixelSize: 54
        text: "198,009"
        anchors.right: parent.right
        anchors.rightMargin: 30
    }
    //Balance labels
    Controls.LabelUnderlined {
        id: dailyText
        x: 0
        y: 213
        text: "Daily"
        anchors.left: parent.left
        anchors.leftMargin: 33
        pixelSize: 19
    }
    Controls.LabelUnderlined {
        id: monthlyText
        y: 299
        text: "Monthly"
        anchors.left: parent.left
        anchors.leftMargin: 33
        pixelSize: 19
    }

    Controls.LabelUnderlined {
        y: 384
        text: "Total"
        anchors.left: parent.left
        anchors.leftMargin: 33
        pixelSize: 19
    }

    Controls.ButtonBalanceDate {
        anchors.top: parent.top
        anchors.topMargin: 97
        anchors.left: parent.left
        anchors.leftMargin: 245
        dayText: "WED"
        dateText: "18"
    }

    Controls.ButtonBalanceDate {
        x: 9
        y: 1
        anchors.leftMargin: 191
        anchors.left: parent.left
        dayText: "TUES"
        dateText: "17"
        anchors.top: parent.top
        anchors.topMargin: 97
    }

    Controls.ButtonBalanceDate {
        x: 2
        y: 4
        anchors.leftMargin: 136
        anchors.left: parent.left
        dayText: "MON"
        dateText: "16"
        anchors.top: parent.top
        anchors.topMargin: 97
    }

    Controls.ButtonBalanceDate {
        x: -1
        y: 5
        anchors.leftMargin: 83
        anchors.left: parent.left
        dayText: "SUN"
        dateText: "15"
        anchors.top: parent.top
        anchors.topMargin: 97
    }

    Controls.ButtonBalanceDate {
        x: -1
        y: 5
        anchors.leftMargin: 32
        anchors.left: parent.left
        dayText: "SAT"
        dateText: "14"
        anchors.top: parent.top
        anchors.topMargin: 97
    }

    Controls.ButtonBalanceDate {
        x: -10
        y: 7
        anchors.leftMargin: 299
        anchors.left: parent.left
        dayText: "THU"
        dateText: "19"
        anchors.top: parent.top
        anchors.topMargin: 97
    }
}
