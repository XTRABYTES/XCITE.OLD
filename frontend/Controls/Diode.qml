import QtQuick 2.0

Rectangle {
    property alias title: header.text

    color: cDiodeBackground
    radius: 5

    DiodeHeader {
        id: header
    }
}
