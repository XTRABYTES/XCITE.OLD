import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "../../Controls" as Controls
import "../../Theme" 1.0

Controls.Diode {
    id: parentDiode
    width: 257
    height: 924
    radius: 5
    color: "#3A3E47"
    Layout.fillWidth: true
    ColumnLayout {
        Controls.DiodeHeader {
            text: "MARKET"
        }

        RowLayout {
            Layout.leftMargin: 10
            Layout.topMargin: 10
            Image {
                source: "../../icons/Star.svg"
            }
            Label {
                text: "XBY"
                font.family: "Roboto"
                color: "#99A5BA"
            }
            Label {
                anchors.left: parent.left
                anchors.leftMargin: 80
                text: "1.00"
                font.family: "Roboto"
                color: "#99A5BA"
            }
            Label {
                anchors.left: parent.left
                anchors.leftMargin: 160
                text: "+0.00%"
                font.family: "Roboto"
            }
        }
        RowLayout {
            Layout.leftMargin: 10
            Layout.topMargin: 2
            Image {
                source: "../../icons/Star.svg"
            }
            Label {
                text: "XFUEL"
                color: "#99A5BA"
                font.family: "Roboto"
            }
            Label {
                anchors.left: parent.left
                anchors.leftMargin: 80
                text: "0.99"
                font.family: "Roboto"
                color: "#99A5BA"
            }
            Label {
                anchors.left: parent.left
                anchors.leftMargin: 160
                text: "-0.03%"
                font.family: "Roboto"
                color: "#F77E7E"
            }
        }
    }
}

