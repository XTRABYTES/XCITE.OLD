import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../../Controls" as Controls

Rectangle{
    id:generalDiode
    color:cDiodeBackground
    radius:5
    Layout.preferredHeight: 863
    Layout.preferredWidth: 1046
    Layout.fillHeight: true
    Layout.fillWidth: true
    Controls.DiodeHeader{
        text:"CHAT"
        iconSource:"../icons/menu-settings.svg"
        iconOnly:true
        iconSize:20
    }
}
