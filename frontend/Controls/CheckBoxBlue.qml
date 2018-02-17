import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.3

CheckBox {
    id: checkboxBlue

    property string text

    style: CheckBoxStyle {
        indicator: Rectangle {
            implicitWidth: 16
            implicitHeight: 16
            radius: 2
            color: "black"
            border.color: "#10B9C5"
            border.width: 1

            Rectangle {
                visible: control.checked
                color: "#10B9C5"
                border.color: "#10B9C5"
                radius: 2
                anchors.margins: 3
                anchors.fill: parent
            }

        }

        label: Text {
            color: "#10B9C5"
            text: checkboxBlue.text
        }
    }
}
