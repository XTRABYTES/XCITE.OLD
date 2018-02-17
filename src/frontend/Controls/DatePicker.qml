import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0

TextField {
    property string dateFormat : "dd/MM/yyyy"

    id: dateField
    font.family: "Roboto"
    font.weight: Font.Light
    font.pixelSize: 16
    text: Qt.formatDate(new Date(), dateFormat)
    leftPadding: 10
    rightPadding: 10
    topPadding: 0
    bottomPadding: 0

    background: Rectangle {
        color: "#2A2C31"
        radius: 6
        implicitWidth: 132
        implicitHeight: 47
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

            GridLayout {
                columns: 1
                anchors.fill: parent
                anchors.leftMargin: 5
                anchors.rightMargin: 5

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
                        font.family: "Roboto"
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
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        opacity: model.month === grid.month ? 1 : 0
                        text: model.day
                        font.family: "Roboto"
                        font.weight: Font.Light
                        font.pixelSize: 7
                        padding: 5

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                dateField.text = Qt.formatDate(model.date, dateFormat);
                                picker.visible = false;
                            }
                        }

                        background: Rectangle {
                            color: "#414245"
                            radius: 3
                        }
                    }
                }
            }
        }
    }
}
