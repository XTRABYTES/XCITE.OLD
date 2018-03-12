import QtQuick 2.7
import QtQuick.Controls 2.3


//Component for text with a blue underline below it.
Item {
    //Allows easy setting of the text from a parent object
    property alias text: label.text
    //Allows setting of the text pixel size from parent
    property alias pixelSize: label.font.pixelSize

    Label {
        id: label
        font.pixelSize: 19
        font.weight: Font.Light
        color: "#E3E3E3"

        Rectangle {
            x: 0
            y: 30.29
            height: 1
            width: parent.width
            color: "#24B9C3"
        }
    }
}
