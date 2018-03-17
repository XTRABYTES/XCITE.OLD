import QtQuick 2.7
import QtQuick.Layouts 1.3
import "../../Controls" as Controls
import "../../Theme" 1.0


//Transactions status board used on the Nodes page (bottom)
Controls.Diode {
    id: networkStatusBoardId
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumHeight: 200
    Layout.preferredHeight: 400
    color: "#3A3E47"
    radius: 5

    Controls.DiodeHeader {
        id: diodeHeader
        text: qsTr("NETWORK STATUS")
        menuLabelText: qsTr("Complete View")
    }
}
