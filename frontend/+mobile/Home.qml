import QtQuick 2.0
import QtQuick.Window 2.2

Item {

    id: homepageLoader
    width: Screen.width
    height: Screen.Height

    Timer {
        id: timer
        interval: 3000
        repeat: true
        running: loginTracker == 1

        onTriggered: sumBalance()
    }

    DashboardForm {
        id: dashBoard
        visible: loginTracker == 1
        state: loginTracker == 0? "off" : "on"

        states: [
                State {
                    name: "on"
                    PropertyChanges { target: dashBoard; opacity: 1 }
                },
                State {
                    name: "off"
                    PropertyChanges { target: dashBoard; opacity: 0 }
                }
        ]

        transitions: Transition {
                NumberAnimation { target: dashBoard; properties: "opacity"; duration: 500; easing.type: Easing.OutCubic}
        }
    }
}
