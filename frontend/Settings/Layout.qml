/**
 * Filename: Layout.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "../Controls" as Controls

Item {
    readonly property color cDiodeBackground: "#3a3e46"
    readonly property string defaultView: "home"

    property string selectedView
    property string selectedModule

    anchors.fill: parent
    Layout.fillHeight: true
    Layout.fillWidth: true

    visible: selectedModule === 'settings'

    Connections {
        target: dashboard
        onSelectView: {
            var parts = path.split('.')

            selectedModule = parts[0]
            if (parts.length === 2) {
                selectedView = parts[1]
            } else {
                selectedView = defaultView
            }
        }
    }

    Controls.Diode {
        anchors.fill: parent
        title: qsTr("Settings")

        RowLayout {
            anchors.fill: parent
            anchors.topMargin: 75
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            ColumnLayout {
                Layout.alignment: Qt.AlignTop
                spacing: 20

                Controls.FormLabel {
                    text: qsTr("Select your language")
                }

                ComboBox {
                    id: control
                    currentIndex: 0
                    textRole: "text"

                    Connections {
                        Component.onCompleted: {
                            for (var i = 0; i < languageOptions.count; i++) {
                                if (languageOptions.get(
                                            i).locale === settings.locale) {
                                    control.currentIndex = i
                                    break
                                }
                            }
                        }
                    }

                    model: ListModel {
                        id: languageOptions
                        ListElement {
                            text: qsTr("English")
                            locale: "en_us"
                        }
                        ListElement {
                            text: qsTr("Dutch")
                            locale: "nl_nl"
                        }
                    }

                    onCurrentIndexChanged: {
                        if (languageOptions.get(
                                    currentIndex).locale === settings.locale) {
                            return
                        }

                        var locale = languageOptions.get(currentIndex).locale
                        localeChange(locale)
                        settings.locale = locale
                    }
                }
            }

            DeveloperSettings {
                Layout.alignment: Qt.AlignTop
            }
        }
    }
}
