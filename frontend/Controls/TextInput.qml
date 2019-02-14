/**
 * Filename: TextInput.qml
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
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "../Theme" 1.0

TextField {
    property int mobile: 0
    property int addressBook: 0
    property int deleteBtn: 1
    property alias deleteImg: deleteInput.source
    property alias textBackground: inputBackground.color
    property int textboxHeight: textInputComponent.height

    id: textInputComponent
    color: "white"
    font.family: xciteMobile.name
    font.pixelSize: 26
    leftPadding: 18
    rightPadding: deleteBtn == 0 ? 18 : textboxHeight
    topPadding: 6
    bottomPadding: 4
    verticalAlignment: Text.AlignVCenter
    selectByMouse: true
    background: Rectangle {
        id: inputBackground
        color: if(mobile == 0 && addressBook == 0)
                   "#2A2C31"
               else
                   "#34363D"
        radius: mobile == 0? 4 : 0
        border.width: parent.activeFocus ? 2 : 0
        border.color: if(mobile == 0)
                          Theme.secondaryHighlight
                      else
                          maincolor //"#34363D"

        implicitWidth: 273
    }
    onActiveFocusChanged: {
        if (textInputComponent.focus) {
            EventFilter.focus(this)
        }
    }

    property alias placeholder: placeholderTextComponent.text

    Text {
        id: placeholderTextComponent
        anchors.fill: textInputComponent
        font: textInputComponent.font
        horizontalAlignment: textInputComponent.horizontalAlignment
        verticalAlignment: textInputComponent.verticalAlignment
        leftPadding: textInputComponent.leftPadding
        rightPadding: textInputComponent.rightPadding
        topPadding: textInputComponent.topPadding
        bottomPadding: textInputComponent.bottomPadding
        opacity: !textInputComponent.displayText
                 && (!textInputComponent.activeFocus
                     || textInputComponent.horizontalAlignment !== Qt.AlignHCenter) ? 1.0 : 0.0
        color: textInputComponent.color
        clip: contentWidth > width
        elide: Text.ElideRight
    }

    Image {
        id: deleteInput
        source: darktheme == true? 'qrc:/icons/mobile/delete-icon_01_light.svg' : 'qrc:/icons/mobile/delete-icon_01_dark.svg'
        height: 12
        width: 12
        anchors.right: textInputComponent.right
        anchors.rightMargin: 11
        anchors.verticalCenter: textInputComponent.verticalCenter
        visible: mobile == 1 && deleteBtn == 1 && textInputComponent.text != ""

        MouseArea {
            width: textboxHeight
            height: textboxHeight
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                textInputComponent.text = ""
                selectedAddress = ""
            }
        }
    }
}
