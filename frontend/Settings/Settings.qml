import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "../Controls" as Controls

Controls.Diode {
    anchors.fill: parent
    title: qsTr("Settings")

    ColumnLayout {
        spacing: 30
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 75
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.bottomMargin: 20

        Controls.FormLabel {
            text: qsTr("Select your language")
        }

        ComboBox {
            currentIndex: 0
            textRole: "text"
            objectName: "localeSelector"

            signal localeChange(string locale)

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
                localeChange(languageOptions.get(currentIndex).locale)
            }
        }
    }
}
