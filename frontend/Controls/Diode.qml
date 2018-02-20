import QtQuick 2.0

Rectangle {
    property alias title: header.text
    property alias menuLabelText: header.menuLabelText

    color: cDiodeBackground
    radius: 5

    DiodeHeader {
        id: header
    }
}
