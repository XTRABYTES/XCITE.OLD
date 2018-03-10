import QtQuick 2.7
import "../Theme" 1.0

Rectangle {
    property alias title: header.text
    property alias menuLabelText: header.menuLabelText

    color: Theme.panelBackground
    radius: panelBorderRadius

    DiodeHeader {
        id: header
    }
}
