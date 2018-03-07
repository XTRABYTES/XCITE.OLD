import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Item {
    anchors.left: parent.left
    anchors.right: parent.right
    height: 67

    Label {
        text: qsTr("Transactions")
        color: "white"
        topPadding: 10
        font.pixelSize: 12
    }
}
