/**
 * Filename: Camera.qml
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
import QtMultimedia 5.8
import QtQuick.Window 2.2
//import QZXing 2.3
import QtMultimedia 5.4
import "../Controls" as Controls
import "../Theme" 1.0

Item {
    width: Screen.width
    height: Screen.height
    property string qrCodeString
    Camera {
        id: camera

        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

        exposure {
            exposureCompensation: -1.0
            exposureMode: Camera.ExposurePortrait
        }

        flash.mode: Camera.FlashRedEyeReduction

        imageCapture {
            onImageCaptured: {
                photoPreview.source = preview // Show the preview in an Image
            }
        }
    }

    VideoOutput {
        source: camera
        anchors.fill: parent
        focus: visible // to receive focus and capture key events when visible
        MouseArea {
            anchors.fill: parent
            onClicked: {
                camera.imageCapture.capture()
                mainRoot.pop("Camera.qml")
            }
        }
    }

    Image {
        id: photoPreview
    }

    /**
    function decode(preview) {
        photoPreview.source = preview
        decoder.decodeImageQML(photoPreview)
    }

    QZXing {
        id: decoder
        enabledDecoders: QZXing.DecoderFormat_QR_CODE
        onDecodingStarted: console.log("Decoding of image started...")
        onTagFound: console.log("Barcode data: " + tag)
        onDecodingFinished: {
            console.log("Decoding finished "
                        + (succeeded == true ? "successfully" : "unsuccessfully"))
            qrCodeString = tag
        }
    }
    */
}
