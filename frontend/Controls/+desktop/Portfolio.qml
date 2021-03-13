import QtQuick 2.7
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtCharts 2.0

Item {
    id: portfolio
    height: appWidth/6
    width: appWidth*1.75/6

    Component.onCompleted: {
        if (!isNaN(totalXBY)) {
            pieSeries.find("XBY").value = totalXBY * valueXBY
        }
        if (!isNaN(totalXFUEL)) {
            pieSeries.find("XFUEL").value = totalXFUEL * valueXFUEL
        }
        if (!isNaN(totalBTC)) {
            pieSeries.find("BTC").value = totalBTC * valueBTC
        }
        if (!isNaN(totalETH)) {
            pieSeries.find("ETH").value = totalETH * valueETH
        }
    }

    property int newAlert: newAlerts
    property real percentage

    onNewAlertChanged: {
        if (!isNaN(totalXBY)) {
            pieSeries.find("XBY").value = totalXBY * valueXBY
        }
        if (!isNaN(totalXFUEL)) {
            pieSeries.find("XFUEL").value = totalXFUEL * valueXFUEL
        }
        if (!isNaN(totalBTC)) {
            pieSeries.find("BTC").value = totalBTC * valueBTC
        }
        if (!isNaN(totalETH)) {
            pieSeries.find("ETH").value = totalETH * valueETH
        }
    }

    Label {
        text: "PORTFOLIO"
        anchors.horizontalCenter: chart.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: appWidth/36
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: themecolor
    }

    ChartView {
        id: chart
        anchors.verticalCenter: legendXFUEL.bottom
        //anchors.verticalCenterOffset: appWidth/96
        anchors.right: parent.right
        height: appWidth/6
        width: height
        legend.visible: false
        antialiasing: true
        backgroundColor: "transparent"

        PieSeries {
            id: pieSeries
            size: 0.7
            holeSize: 0.35
            PieSlice { label: "XFUEL"; value: 0; color: "#FFAE11"; borderColor: "transparent"}
            PieSlice { label: "XBY"; value: 0; color: "#0ED8D2"; borderColor: "transparent"}
            PieSlice { label: "BTC"; value: 0; color: "#F7931A"; borderColor: "transparent"}
            PieSlice { label: "ETH"; value: 0; color: "#A690FC"; borderColor: "transparent"}
        }
    }

    Rectangle {
        id: portfolioArea
        width: appWidth*1.5/6
        anchors.left: parent.left
        anchors.top: legendXBY.top
        anchors.topMargin: -appWidth/24
        anchors.bottom: legendETH.bottom
        anchors.bottomMargin: -appWidth/48
        color: "transparent"
    }

    Rectangle {
        id: legendXBY
        width: appHeight/36*0.8
        height: width
        anchors.top: parent.top
        anchors.topMargin: appWidth*1.5/24
        anchors.left: portfolioArea.left
        anchors.leftMargin: appWidth/48
        color: "#0ED8D2"
    }

    Label {
        id: xbyLabel
        text: "XBY"
        anchors.verticalCenter: legendXBY.verticalCenter
        anchors.left: legendXBY.right
        anchors.leftMargin: appHeight/72
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: themecolor
    }

    Rectangle {
        id: legendXFUEL
        width: appHeight/36*0.8
        height: width
        anchors.top: legendXBY.top
        anchors.topMargin: appWidth/42
        anchors.left: portfolioArea.left
        anchors.leftMargin: appWidth/48
        color: "#FFAE11"
    }

    Label {
        id: xfuelLabel
        text: "XFUEL"
        anchors.verticalCenter: legendXFUEL.verticalCenter
        anchors.left: legendXFUEL.right
        anchors.leftMargin: appHeight/72
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: themecolor
    }

    Rectangle {
        id: legendBTC
        width: appHeight/36*0.8
        height: width
        anchors.top: legendXFUEL.top
        anchors.topMargin: appWidth/42
        anchors.left: portfolioArea.left
        anchors.leftMargin: appWidth/48
        color: "#F7931A"
    }

    Label {
        id: btcLabel
        text: "BTC"
        anchors.verticalCenter: legendBTC.verticalCenter
        anchors.left: legendBTC.right
        anchors.leftMargin: appHeight/72
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: themecolor
    }

    Rectangle {
        id: legendETH
        width: appHeight/36*0.8
        height: width
        anchors.top: legendBTC.top
        anchors.topMargin: appWidth/42
        anchors.left: portfolioArea.left
        anchors.leftMargin: appWidth/48
        color: "#A690FC"
    }

    Label {
        id: ethLabel
        text: "ETH"
        anchors.verticalCenter: legendETH.verticalCenter
        anchors.left: legendETH.right
        anchors.leftMargin: appHeight/72
        font.pixelSize: appHeight/36
        font.family: xciteMobile.name
        font.letterSpacing: 2
        color: themecolor
    }
}
