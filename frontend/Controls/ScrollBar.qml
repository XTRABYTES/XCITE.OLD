import QtQuick 2.0
import QtQuick.Controls 2.3


/**
  * Simple scrollbar preferably for use with flickables, reccommend using layout.fillWidth & Layout.fillHeight
  * Can be used on any item, recommend override anchors when needed
  * Example usage: 
  * Controls.ScrollBar {
  *   Layout.fillHeight: true
  *   Layout.fillWidth: true 
  * }
  */
ListView {
    id: listView
    flickableDirection: Flickable.VerticalFlick
    boundsBehavior: Flickable.StopAtBounds
    model: 100
    clip: true
    delegate: ItemDelegate {
        text: modelData
    }

    ScrollBar.vertical: ScrollBar {
        active: true
        policy: ScrollBar.AlwaysOn
    }
}
