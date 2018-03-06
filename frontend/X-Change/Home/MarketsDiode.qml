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
        /**
        RowLayout {
            Layout.leftMargin: 15
            Layout.topMargin: 5
            Text {
                font.pointSize: 11
                text: "XBY"
                color: "#FFFFFF"
                font.family: "Roboto"
                //font.weight: bold
            }
            Text {
                font.pointSize: 11
                text: "XFUEL"
                color: "#FFFFFF"
                font.family: "Roboto"
                //font.weight: bold
            }
        }*/
    }
}
