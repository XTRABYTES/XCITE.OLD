import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.1

Item {
    id: root
    width: size
    height: size

    property alias isSelected: overlay.visible
    property alias imageSource: image.source
    property alias hoverEnabled: mouseArea.hoverEnabled
    property bool changeColorOnClick: true
    property int size: 40
    signal buttonClicked

    Image {
        id: image
        smooth: true
        mipmap: true
        sourceSize.width: size
        sourceSize.height: size
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                if (changeColorOnClick) {
                    overlay.visible = !overlay.visible
                    hoverOverlay.visible = false
                }
                root.buttonClicked()
            }
            hoverEnabled: true
            onHoveredChanged: {
                if (containsMouse) {
                    hoverOverlay.visible = true
                }
                else {
                    hoverOverlay.visible = false
                }
            }
        }
    }

    ColorOverlay {
        id: overlay
        anchors.fill: image
        source: image
        color: "#0ED8D2"
        visible: false
    }

    ColorOverlay {
        id: hoverOverlay
        anchors.fill: image
        source: image
        color: "#0eefe9"
        visible: false
    }
}
