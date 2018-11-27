import QtQuick.Controls 2.3
import QtQuick 2.7
import QtMultimedia 5.5
import QtGraphicalEffects 1.0
import QZXing 2.3

Item {
    width: 325
    height: 450
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 50
    visible: scanQRTracker == 1

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
        focus {
            focusMode: Camera.FocusContinuous
            focusPointMode: CameraFocus.FocusPointAuto
        }
    }

    Rectangle {
        id: addressTitleBar
        width: parent.width
        height: 54
        radius: 4
        anchors.top: parent.top
        anchors.left: parent.left
        color: "#34363D"

        Text {
            id: scanQRLabel
            text: "SCAN QR CODE"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -5
            font.pixelSize: 20
            font.family: "Brandon Grotesque"
            color: "#F2F2F2"
        }
    }

    Rectangle {
        width: parent.width
        height: 400
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 42
        color: "transparent"

        VideoOutput {
            id: videoOutput
            source: camera
            width: parent.width
            height: parent.height
            fillMode: VideoOutput.PreserveAspectCrop
            autoOrientation: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            filters: [
                qrFilter
            ]
        }

        Image {
            id: scanWindow
            source: 'qrc:/scan-window.svg'
            width: 325
            height: 400
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            opacity: 0.95
        }

        Rectangle {
            width: 225
            height: 225
            radius: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            color: "transparent"
            border.width: 2
            border.color: "#F2F2F2"
        }

        Label {
            id: pubKey
            text: "PUBLIC KEY"
            anchors.top: parent.top
            anchors.topMargin: 285
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F2"
            font.family: "Brandon Grotesque"
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
            color: "white"
            font.family: "Brandon Grotesque"
            font.weight: Font.Light
            font.pixelSize: 12
            font.italic: publicKey.text == "scanning..."

        }
    }

    Rectangle {
        id: cancelAddressButton
        width: (parent.width - 40) / 2
        height: 33
        radius: 5
        color: "#5E8BFE"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        visible: scanQRTracker == 1

        MouseArea {
            anchors.fill: cancelAddressButton

            onClicked: {
                scanQRTracker = 0
                selectedAddress = ""
                publicKey.text = "scanning..."
            }
        }

        Text {
            text: "BACK"
            font.family: "Brandon Grotesque"
            font.pointSize: 14
            font.bold: true
            color: "#F2F2F2"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
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
