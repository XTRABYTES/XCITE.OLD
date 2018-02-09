import QtQuick 2.0
import QtQuick.Layouts 1.3

ButtonDiode {
    property string name

    anchors.left: parent.left
    anchors.right: parent.right

    isSelected: {
        var fullName = selectedModule + '.' + selectedView
        return fullName === this.name
    }

    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

    onButtonClicked: {
        selectView(this.name);
    }

}
