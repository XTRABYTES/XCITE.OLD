import QtQuick 2.0
import QtCharts 2.2
import QtQuick.Layouts 1.3
import "../../Controls" as Controls
import "../../Theme" 1.0

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumHeight: 200
    Layout.preferredHeight: 400

    color: "#3A3E47"
    radius: 5

    Controls.DiodeHeader {
        id: header
        text: qsTr("XTRABYTES CHART")
    }

    ChartView {
        id: priceChartView
        anchors.top: header.bottom
        anchors.topMargin: 2
        height: parent.height-header.height
        width: parent.width
        theme: ChartView.ChartThemeDark
        legend.alignment: Qt.AlignBottom
        antialiasing: true
        backgroundColor: cDiodeBackground

        SplineSeries {
            name: "Price (USD)"
            axisX: DateTimeAxis {
                format: "dd MMM";
                tickCount: priceChartView.width > 768 ? 10 : (priceChartView.width < 576 ? 3 : 5)
            }
            axisY: ValueAxis {
                min: 0.12
                max: 0.24
            }
            color: Theme.primaryHighlight
            width: 3.5

            XYPoint { x: 1517702400000; y: 0.2221 }
            XYPoint { x: 1517788800000; y: 0.1586 }
            XYPoint { x: 1517875200000; y: 0.1876 }
            XYPoint { x: 1517961600000; y: 0.1907 }
            XYPoint { x: 1518048000000; y: 0.184 }
            XYPoint { x: 1518134400000; y: 0.2057 }
            XYPoint { x: 1518220800000; y: 0.1884 }
            XYPoint { x: 1518307200000; y: 0.1851 }
            XYPoint { x: 1518393600000; y: 0.2145 }
            XYPoint { x: 1518480000000; y: 0.2021 }
            XYPoint { x: 1518566400000; y: 0.2324 }
            XYPoint { x: 1518652800000; y: 0.2157 }
            XYPoint { x: 1518739200000; y: 0.2215 }
            XYPoint { x: 1518825600000; y: 0.23 }
            XYPoint { x: 1518912000000; y: 0.2068 }
            XYPoint { x: 1518998400000; y: 0.2127 }
            XYPoint { x: 1519084800000; y: 0.183 }
            XYPoint { x: 1519171200000; y: 0.1816 }
            XYPoint { x: 1519257600000; y: 0.1511 }
            XYPoint { x: 1519344000000; y: 0.1696 }
            XYPoint { x: 1519430400000; y: 0.153 }
            XYPoint { x: 1519516800000; y: 0.1624 }
            XYPoint { x: 1519603200000; y: 0.1733 }
            XYPoint { x: 1519689600000; y: 0.1774 }
            XYPoint { x: 1519776000000; y: 0.1592 }
            XYPoint { x: 1519862400000; y: 0.1637 }
            XYPoint { x: 1519948800000; y: 0.152 }
            XYPoint { x: 1520035200000; y: 0.1568 }
            XYPoint { x: 1520121600000; y: 0.1517 }
            XYPoint { x: 1520208000000; y: 0.1495 }
            XYPoint { x: 1520294400000; y: 0.1323 }

        }
    }
}
