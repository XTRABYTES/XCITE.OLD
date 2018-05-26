/**
 * Filename: DatePicker.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0
import "../Theme" 1.0

TextField {
    property string dateFormat: "dd/MM/yyyy"
    property date value: new Date()

    property string defaultBackgroundColor: "#2A2C31"
    property string hoveringBackgroundColor: "#46464b"

    id: dateField
    font.weight: Font.Light
    font.pixelSize: 16
    text: Qt.formatDate(value, dateFormat)
    leftPadding: 10
    rightPadding: 10
    topPadding: 0
    bottomPadding: 0
    color: "#d5d5d5"

    state: "Default"

    background: Rectangle {
        id: dateFieldBackground
        color: defaultBackgroundColor
        radius: 6
        implicitWidth: 132
        implicitHeight: 47
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onHoveredChanged: containsMouse ? dateField.state = "Hovering" : dateField.state = "Default"
    }

    Button {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 32

        background: Rectangle {
            color: "transparent"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                picker.visible = true
            }

            hoverEnabled: true
            onHoveredChanged: containsMouse ? dateField.state
                                              = "Hovering" : dateField.state = "Default"
        }

        Image {
            id: pickerIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 12
            source: "../../icons/calendar.svg"
            sourceSize.width: 15
            sourceSize.height: 17
        }

        Rectangle {
            id: picker
            visible: false
            color: "#2a2c31"
            width: 200
            height: 150
            radius: 5
            z: 100
            border.width: 1
            border.color: "#888"

            GridLayout {
                columns: 1
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                DayOfWeekRow {
                    locale: grid.locale
                    Layout.fillWidth: true
                    spacing: 3
                    bottomPadding: 0

                    delegate: Label {
                        color: "#FFF7F7"
                        text: model.narrowName
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.weight: Font.Medium
                        font.pixelSize: 8
                        padding: 5
                    }
                }

                MonthGrid {
                    id: grid
                    month: Calendar.February
                    year: 2018
                    locale: Qt.locale("en_GB")
                    Layout.fillWidth: true
                    spacing: 3

                    delegate: Label {
                        id: label

                        readonly property color defaultColor: "#22414245"
                        readonly property color selectedColor: Theme.primaryHighlight
                        readonly property color hoveringColor: "#414245"

                        function dateMatch() {
                            var d1 = model.date.setHours(0, 0, 0, 0)
                            var d2 = value.setHours(0, 0, 0, 0)
                            return d1 === d2
                        }

                        function getBackgroundColor() {
                            return dateMatch() ? selectedColor : defaultColor
                        }

                        function getColor() {
                            return dateMatch() ? "#333" : "#bbb"
                        }

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        opacity: model.month === grid.month ? 1 : 0
                        text: model.day
                        font.weight: Font.Light
                        font.pixelSize: 7
                        padding: 5

                        state: dateMatch() ? "Selected" : "Default"
                        color: getColor()

                        MouseArea {
                            id: labelMouseArea
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                state: "Default"
                                value = model.date
                                picker.visible = false
                            }
                            hoverEnabled: true
                            onHoveredChanged: {
                                if (containsMouse && !dateMatch()) {
                                    label.state = "Hovering"
                                } else {
                                    if (dateMatch()) {
                                        label.state = "Selected"
                                    } else {
                                        label.state = "Default"
                                    }
                                }
                            }
                        }

                        background: Rectangle {
                            id: labelBackground
                            color: getBackgroundColor()
                            radius: 3
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
                                    target: labelBackground
                                    color: label.hoveringColor
                                }
                            },
                            State {
                                name: "Default"
                                PropertyChanges {
                                    target: labelBackground
                                    color: label.defaultColor
                                }
                            },
                            State {
                                name: "Selected"
                                PropertyChanges {
                                    target: labelBackground
                                    color: label.getBackgroundColor()
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
                }
            }
        }
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
                target: dateFieldBackground
                color: hoveringBackgroundColor
            }
        },
        State {
            name: "Default"
            PropertyChanges {
                target: dateFieldBackground
                color: defaultBackgroundColor
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
