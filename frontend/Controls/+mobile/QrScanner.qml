import QtQuick.Controls 2.3
import QtQuick 2.7
import QtGraphicalEffects 1.0
import QZXing 2.3
import QtMultimedia 5.8
import QtQuick.Window 2.2

Item {
    width: appWidth
    height: appHeight
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: scanQRTracker == 1
    state: scanQRTracker == 1? "up" : "down"

    states: [
        State {
            name: "up"
        },
        State {
            name: "down"
        }
    ]

    property alias key: pubKey.text
    property bool qrFound: false

    onStateChanged: {
        if (scanQRTracker == 0 && qrFound == false) {
            selectedAddress = ""
            publicKey.text = "scanning..."
        }
    }

    Timer {
        id: timer
        interval: 1000
        repeat: false
        running: false

        onTriggered:{
            scanQRTracker = 0
            publicKey.text = "scanning..."
            qrFound = false
        }
    }

    Camera {
        id: camera
        position: Camera.BackFace
        cameraState: cameraPermission === true? ((transferTracker == 1 || addressTracker == 1 || addAddressTracker == 1) ? (scanQRTracker == 1 ? Camera.ActiveState : Camera.LoadedState) : Camera.UnloadedState) : Camera.UnloadedState
        focus {
            focusMode: Camera.FocusContinuous
            focusPointMode: CameraFocus.FocusPointAuto
        }

        onCameraStateChanged: {
            console.log("camera status: " + camera.cameraStatus)
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        color: bgcolor
        clip: true

        Label {
            text: "activating camera..."
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: scanFrame.verticalCenter
            color: "#F2F2F2"
            font.family: xciteMobile.name
            font.bold: true
            font.pixelSize: 14
            font.italic: true

        }

        VideoOutput {
            id: videoOutput
            source: camera
            width: parent.width
            fillMode: VideoOutput.PreserveAspectCrop
            autoOrientation: true
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: scanFrame.horizontalCenter
            anchors.verticalCenter: scanFrame.verticalcenter
            filters: [
                qrFilter
            ]
        }

        Image {
            id: scanWindow
            source: 'qrc:/scan-window_02.svg'
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.9

            ColorOverlay {
                anchors.fill: scanWindow
                source: scanWindow
                color: darktheme == false? "white" : "black"
                opacity: 0.9
            }
        }

        Text {
            id: scanQRLabel
            text: "SCAN QR CODE"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            font.pixelSize: 20
            font.family: xciteMobile.name
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
        }

        Rectangle {
            id: scanFrame
            width: 225
            height: 225
            radius: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 150
            color: "transparent"
            border.width: 1
            border.color: darktheme == true? "#F2F2F2" : "#2A2C31"
        }

        Label {
            id: pubKey
            text: "ADDRESS"
            anchors.top: scanFrame.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.family: xciteMobile.name
            font.bold: true
            font.pixelSize: 14
            font.letterSpacing: 1
        }

        Label {
            id: publicKey
            text: scanning
            anchors.top: pubKey.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: pubKey.horizontalCenter
            color: darktheme == true? "#F2F2F2" : "#2A2C31"
            font.family: xciteMobile.name
            font.pixelSize: 12
            font.italic: publicKey.text == "scanning..."

        }
    }

    QZXingFilter {
        id: qrFilter

        decoder {
            enabledDecoders: QZXing.DecoderFormat_QR_CODE
            onTagFound: {
                qrFound = true
                console.log(tag);
                selectedAddress = ""
                scanning = ""
                publicKey.text = tag
                selectedAddress = publicKey.text
                timer.start()
            }

            tryHarder: true

        }


        captureRect: {
            // setup bindings
            videoOutput.contentRect;
            videoOutput.sourceRect;
            return videoOutput.mapRectToSource(videoOutput.mapNormalizedRectToItem(Qt.rect(
                                                                                       0.25, 0.25, 0.5, 0.5
                                                                                       )));
        }
    }
}
