import QtQuick 2.7
import QtCharts 2.2
import QtQuick.Layouts 1.3
import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    title: qsTr("XBY/USD")

    Item {
        anchors.fill: parent
        anchors.topMargin: diodeHeaderHeight + 2
        anchors.bottomMargin: 10
        clip: true

        ChartView {
            id: priceChartView

            // This is a dirty hack required to remove the excessive margins around the ChartView.
            // Documentation states margins can be set but they appear to be read-only.
            // We nest the ChartView in a parent Item that clips off the excess and position it such that it crops
            x: -20
            y: -10
            width: parent.width + 40
            height: parent.height + 40
            anchors.margins: 0

            theme: ChartView.ChartThemeDark
            legend.visible: false
            antialiasing: true
            backgroundColor: Theme.panelBackground
            backgroundRoundness: panelBorderRadius

            SplineSeries {
                name: "Price (USD)"
                axisX: DateTimeAxis {
                    format: "dd MMM"
                    tickCount: priceChartView.width
                               > 768 ? 10 : (priceChartView.width < 576 ? 3 : 5)
                    labelsFont.pixelSize: 12
                    gridLineColor: "#565a63"
                    labelsColor: "#8591A5"
                    lineVisible: false
                    minorGridVisible: false
                    titleVisible: false
                }
                axisY: ValueAxis {
                    min: 0.12
                    max: 0.24
                    labelsFont.pixelSize: 12
                    gridVisible: false
                    labelsColor: "#8591A5"
                    lineVisible: false
                    minorGridVisible: false
                    titleVisible: false
                }
                color: Theme.primaryHighlight
                width: 3.5

                XYPoint {
                    x: 1517702400000
                    y: 0.2221
                }
                XYPoint {
                    x: 1517788800000
                    y: 0.1586
                }
                XYPoint {
                    x: 1517875200000
                    y: 0.1876
                }
                XYPoint {
                    x: 1517961600000
                    y: 0.1907
                }
                XYPoint {
                    x: 1518048000000
                    y: 0.184
                }
                XYPoint {
                    x: 1518134400000
                    y: 0.2057
                }
                XYPoint {
                    x: 1518220800000
                    y: 0.1884
                }
                XYPoint {
                    x: 1518307200000
                    y: 0.1851
                }
                XYPoint {
                    x: 1518393600000
                    y: 0.2145
                }
                XYPoint {
                    x: 1518480000000
                    y: 0.2021
                }
                XYPoint {
                    x: 1518566400000
                    y: 0.2324
                }
                XYPoint {
                    x: 1518652800000
                    y: 0.2157
                }
                XYPoint {
                    x: 1518739200000
                    y: 0.2215
                }
                XYPoint {
                    x: 1518825600000
                    y: 0.23
                }
                XYPoint {
                    x: 1518912000000
                    y: 0.2068
                }
                XYPoint {
                    x: 1518998400000
                    y: 0.2127
                }
                XYPoint {
                    x: 1519084800000
                    y: 0.183
                }
                XYPoint {
                    x: 1519171200000
                    y: 0.1816
                }
                XYPoint {
                    x: 1519257600000
                    y: 0.1511
                }
                XYPoint {
                    x: 1519344000000
                    y: 0.1696
                }
                XYPoint {
                    x: 1519430400000
                    y: 0.153
                }
                XYPoint {
                    x: 1519516800000
                    y: 0.1624
                }
                XYPoint {
                    x: 1519603200000
                    y: 0.1733
                }
                XYPoint {
                    x: 1519689600000
                    y: 0.1774
                }
                XYPoint {
                    x: 1519776000000
                    y: 0.1592
                }
                XYPoint {
                    x: 1519862400000
                    y: 0.1637
                }
                XYPoint {
                    x: 1519948800000
                    y: 0.152
                }
                XYPoint {
                    x: 1520035200000
                    y: 0.1568
                }
                XYPoint {
                    x: 1520121600000
                    y: 0.1517
                }
                XYPoint {
                    x: 1520208000000
                    y: 0.1495
                }
                XYPoint {
                    x: 1520294400000
                    y: 0.1323
                }
            }
        }
    }
}
