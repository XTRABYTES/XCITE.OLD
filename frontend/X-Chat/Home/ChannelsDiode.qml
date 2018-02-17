import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../../Controls" as Controls

Rectangle {
    id: channelsDiode
    color: cDiodeBackground
    radius: 5
    Layout.preferredHeight: 843
    Layout.preferredWidth: 257
    Layout.fillHeight: true
    //Layout.fillWidth: true
    Controls.DiodeHeader {
        text: "CHANNELS"
        iconSource: "../icons/menu-settings.svg"
        iconOnly: true
        iconSize: 20
    }
}
