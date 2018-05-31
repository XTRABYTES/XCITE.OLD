/**
 * Filename: ChartDiode.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
import QtQuick 2.7
import QtQuick.Controls 2.3
import QtCharts 2.2
import QtQuick.Layouts 1.3
import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    title: qsTr("XBY/USD")

    ChartView {
        id: priceChartView

        readonly property string updateUrl: "https://ticker.xtrabytes.global/data.json"

        anchors.fill: parent
        anchors.topMargin: diodeHeaderHeight

        margins.top: 0
        margins.bottom: 0
        margins.left: 0
        margins.right: 0

        theme: ChartView.ChartThemeDark
        legend.visible: false
        antialiasing: true
        backgroundColor: Theme.panelBackground
        backgroundRoundness: panelBorderRadius

        BusyIndicator {
            running: !updateTimer.loaded
            anchors.centerIn: parent
            width: 100
            height: 100

            Image {
                opacity: parent.running ? 1 : 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: (parent.height / 2) - (width / 2) + 5
                source: "../../icons/xby.png"
                width: 50
                height: 43

                Behavior on opacity {
                    PropertyAnimation {
                    }
                }
            }
        }

        MouseArea {
            id: mouse
            cursorShape: Qt.CrossCursor
            property int mx
            property int my

            anchors.fill: parent
            hoverEnabled: true

            onMouseXChanged: updateToolTip(mouse)
            onMouseYChanged: updateToolTip(mouse)

            function updateToolTip(mouse) {
                var area = priceChartView.plotArea

                var isVisible = (mouse.y >= area.y)
                        && (mouse.y <= (area.y + area.height))
                        && (mouse.x >= area.x)
                        && (mouse.x <= (area.x + area.width))

                tooltip.visible = isVisible
                marker.visible = isVisible

                if (!isVisible) {
                    return
                }

                var series = priceChartView.series("Price (USD)")
                var delta = priceChartView.plotArea.width / (series.count - 1)
                var idx = Math.round(
                            (mouse.x - priceChartView.plotArea.x) / delta)

                var pt = series.at(idx)
                var isVisible = !(pt.x === 0 && pt.y === 0)

                var pos = priceChartView.mapToPosition(pt)

                var d = new Date()
                d.setTime(pt.x)
                date.text = d.toString()
                price.text = "$" + pt.y.toFixed(5)

                tooltip.x = (pos.x + tooltip.width
                             > priceChartView.width) ? pos.x - tooltip.width : pos.x
                tooltip.y = priceChartView.plotArea.bottom - 20
                price.text = "$" + pt.y.toFixed(5)

                marker.x = pos.x - (marker.width / 2)
                marker.y = pos.y - (marker.height / 2)

                var d = new Date()
                d.setTime(pt.x)
                date.text = d.toString()
            }
        }

        LineSeries {
            name: "Price (USD)"
            pointsVisible: false

            axisX: DateTimeAxis {
                format: "dd MMM hh:mm"
                tickCount: priceChartView.width > 768 ? 10 : (priceChartView.width < 576 ? 3 : 5)
                labelsFont.pixelSize: 12
                gridLineColor: "#565a63"
                gridVisible: updateTimer.loaded
                labelsColor: "#8591A5"
                labelsVisible: updateTimer.loaded
                lineVisible: false
                minorGridVisible: false
                titleVisible: false
            }

            axisY: ValueAxis {
                min: 0
                max: 1
                labelsFont.pixelSize: 12
                gridVisible: false
                labelsColor: "#8591A5"
                lineVisible: false
                labelsVisible: updateTimer.loaded
                minorGridVisible: false
                titleVisible: false
            }

            color: Theme.primaryHighlight

            width: 1.5
        }
    }

    Timer {
        id: updateTimer
        property bool loaded: false

        interval: 15 * 60 * 60 * 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            var xhr = new XMLHttpRequest
            xhr.open("GET", priceChartView.updateUrl)
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    var data = JSON.parse(xhr.responseText)

                    var priceSeries = priceChartView.series("Price (USD)")
                    priceSeries.clear()

                    var minTime = Number.MAX_VALUE
                    var maxTime = Number.MIN_VALUE
                    var minValue = Number.MAX_VALUE
                    var maxValue = Number.MIN_VALUE

                    for (var i = 0; i < data.length; i++) {
                        var row = data[i]

                        if (row[0] && row[1]) {
                            minTime = Math.min(row[0], minTime)
                            maxTime = Math.max(row[0], maxTime)

                            minValue = Math.min(row[1], minValue)
                            maxValue = Math.max(row[1], maxValue)

                            priceSeries.append(row[0], row[1])
                        }
                    }

                    var dateStart = new Date()
                    dateStart.setTime(minTime)
                    priceSeries.axisX.min = dateStart

                    var dateEnd = new Date()
                    dateEnd.setTime(maxTime)
                    priceSeries.axisX.max = dateEnd

                    priceSeries.axisY.min = Math.max(0, minValue * .8)
                    priceSeries.axisY.max = maxValue * 1.05

                    loaded = true
                }
            }
            xhr.send()
        }
    }

    Rectangle {
        id: marker
        parent: priceChartView
        width: 8
        visible: false
        anchors.top: priceChartView.top
        anchors.bottom: priceChartView.bottom
        color: '#000'
        opacity: 0.2
    }

    Rectangle {
        id: tooltip
        color: "#2A2C31"
        height: (date.height + price.height + 10)
        width: childrenRect.width
        radius: 4
        visible: false

        Column {
            padding: 5

            spacing: 2
            Label {
                id: date
                color: "#fff"
            }

            Label {
                id: price
                color: "#fff"
            }
        }
    }
}
