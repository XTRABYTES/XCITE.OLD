import QtQuick 2.7

Rectangle {
    id: searchResultCategoryId

    implicitHeight: textLabelId.height
    implicitWidth: parent.width

    color: "transparent"
    property string defaultColor: "white"
    property string hoveringColor: "#0ed8d2"

    // Intended to be overwritten
    property string text

    function onSearchResultClicked() {}

    Text {
        id: textLabelId

        topPadding: 6
        leftPadding: 20
        bottomPadding: 6

        text: searchResultCategoryId.text
        font.family: "Roboto bold"
        font.pointSize: 11
        color: defaultColor
    }

    state: "default"

    MouseArea {
        anchors.fill: searchResultCategoryId
        onClicked: {
            searchResultCategoryId.onSearchResultClicked()
        }

        hoverEnabled: true
        onHoveredChanged: containsMouse ? searchResultCategoryId.state
                                          = "Hovering" : searchResultCategoryId.state = "Default"
    }

    // Hovering animations
    Behavior on scale {
        NumberAnimation {
            duration: 150
            easing.type: Easing.InOutQuad
        }
    }

    states: [
        State {
            name: "Hovering"
            PropertyChanges {
                target: textLabelId
                color: hoveringColor
            }
        },
        State {
            name: "Default"
            PropertyChanges {
                target: textLabelId
                color: defaultColor
            }
        }
    ]

    transitions: [
        Transition {
            from: "Default"
            to: "Hovering"
            ColorAnimation {
                duration: 150
            }
        },
        Transition {
            from: "Hovering"
            to: "Default"
            ColorAnimation {
                duration: 300
            }
        }
    ]
}
