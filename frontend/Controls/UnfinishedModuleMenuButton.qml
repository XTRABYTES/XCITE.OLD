import QtQuick 2.7
import "../Theme" 1.0

ModuleMenuButton {
    id: button
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            modalAlert({
                           bodyText: "This portion of XCite is not yet functioning, expect it soon",
                           title: qsTr("Module Alert"),
                           buttonText: qsTr("OK")
                       })
            selectView(target)
        }
        onHoveredChanged: {
            button.state = containsMouse ? "hover" : ""
        }
        hoverEnabled: true
    }
}
