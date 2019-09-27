import QtQuick.Controls 2.3
import QtQuick 2.7
import QtGraphicalEffects 1.0
import QZXing 2.3
import QtMultimedia 5.8
import QtQuick.Window 2.2

Item {
    width: Screen.width
    height: Screen.height
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    visible: scanQRTracker == 1

    property alias key: pubKey.text

    Timer {
        id: timer
        interval: 1000
        repeat: false
        running: false

        onTriggered:{
            scanQRTracker = 0
            publicKey.text = "scanning..."
        }
    }

    Camera {
        id: camera
        position: Camera.BackFace
        cameraState: cameraPermission === true? ((transferTracker == 1 || addressTracker == 1 || addAddressTracker == 1 || importKeyTracker == 1) ? (scanQRTracker == 1 ? Camera.ActiveState : Camera.LoadedState) : Camera.UnloadedState) : Camera.UnloadedState
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

    Rectangle {
        id: cancelScanButton
        width: doubbleButtonWidth / 2
        height: 34
        color: "transparent"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: myOS === "android"? 50 : 70
        anchors.horizontalCenter: parent.horizontalCenter
        visible: scanQRTracker == 1

        MouseArea {
            anchors.fill: cancelScanButton

            onPressed: {
                click01.play()
            }

            onCanceled: {
            }

            onReleased: {
            }

            onClicked: {
                scanQRTracker = 0
                selectedAddress = ""
                publicKey.text = "scanning..."
            }
        }
    }

    Text {
        text: "BACK"
        font.family: xciteMobile.name //"Brandon Grotesque"
        font.pointSize: 14
        font.bold: true
        color: darktheme == true? "#F2F2F2" : "#2A2C31"
        anchors.horizontalCenter: cancelScanButton.horizontalCenter
        anchors.verticalCenter: cancelScanButton.verticalCenter
    }

    QZXingFilter {
        id: qrFilter

        decoder {
            enabledDecoders: QZXing.DecoderFormat_QR_CODE
            onTagFound: {
                console.log(tag);
                selectedAddress = ""
                scanning = ""
                publicKey.text = tag
                selectedAddress = publicKey.text
                timer.start()
            }
        }

        captureRect: {
            // setup bindings
            videoOutput.contentRect;
            videoOutput.sourceRect;
            // only scan the central quarter of the area for a barcode
            return videoOutput.mapRectToSource(videoOutput.mapNormalizedRectToItem(Qt.rect(
                                                                                       0.22, 0.09, 0.56, 0.82
                                                                                       )));
        }
    }
}
