pragma Singleton
import QtQuick 2.0
import QtQuick.Window 2.2

QtObject {
    readonly property real refScreenWidth: 1280
    readonly property real refScreenHeight: 800

    readonly property real screenWidth: 1024
    //readonly property real screenWidth: Screen.width
    readonly property real screenHeight: 768
    //readonly property real screenHeight: Screen.height

    function hscale(size) {
        return Math.round(size * (screenWidth / refScreenWidth))
    }

    function vscale(size) {
        return Math.round(size * (screenHeight / refScreenHeight))
    }
}
