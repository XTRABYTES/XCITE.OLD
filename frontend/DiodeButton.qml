import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.1

Item {
    id: root
    width: size
    height:
        if (hasLabel) {
            (size + label.height)
        } else {
            size
        }

    property alias isSelected: overlay.visible
    property alias imageSource: image.source
    property alias hoverEnabled: mouseArea.hoverEnabled
    property bool changeColorOnClick: true
    property bool hasLabel: false
    property string labelText
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
                    if (hasLabel) {
                        label.color = "#0eefe9"
                    }
                }
                else {
                    hoverOverlay.visible = false
                }
            }
        }
    }

    Text {
        id: label
        visible: hasLabel
        text: labelText
        anchors.top: image.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: image.horizontalCenter
        font.family: "Roboto"
        font.pixelSize: 14
        color: "#CFD0D2"
    }

    ColorOverlay {
        id: overlay
        anchors.fill: image
        source: image
        color: "#0ED8D2"
        visible: false
        onVisibleChanged: {
            if (hasLabel && overlay.visible) {
                label.color = "#0ED8D2"
            } else if (hasLabel) {
                label.color = "#CFD0D2"
            }
        }
    }

    ColorOverlay {
        id: hoverOverlay
        anchors.fill: image
        source: image
        color: "#0eefe9"
        visible: false
        onVisibleChanged: {
            if (hasLabel && hoverOverlay.visible) {
                label.color = "#0eefe9"
            } else if (hasLabel && overlay.visible && isSelected) {
                label.color = "#0ED8D2"
            } else if (hasLabel) {
                label.color = "#CFD0D2"
            }
        }
    }
}
