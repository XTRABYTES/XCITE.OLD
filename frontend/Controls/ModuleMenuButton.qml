import QtQuick 2.0

Rectangle {
    id: button

    property string name
    property string target
    property alias text: label.text

    property bool isSelected: selected === this.name

    anchors.verticalCenter: parent.Center

    width: 140
    height: 44

    color: isSelected ? "#0DD8D2" : (state == 'hover' ? "#302f2f" : "transparent")
    radius: 5

    states: [
        State { name: "hover" }
    ]

    Text {
        id: label
        anchors.centerIn: parent
        text: "Start"
        font.family: "Roboto"
        font.pixelSize: 16
        color: isSelected ? "#38414A" : "#62DED6"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            selectView(target);
        }

        hoverEnabled: true
        onEntered: { button.state = 'hover' }
        onExited: { button.state = '' }
    }
}
