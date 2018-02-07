import QtQuick 2.0
import QtQuick.Layouts 1.3

import "../../Controls" as Controls
import "../Home" as Home
ColumnLayout {

    readonly property color cDiodeBackground: "#3a3e46"

    id: xBoardReceive
    anchors.left: parent.left
    anchors.right: parent.right
    Layout.rightMargin: layoutGridSpacing
    spacing: layoutGridSpacing
    visible:false;



        //Layout.alignment: Qt.AlignTop
        //spacing: layoutGridSpacing

        ColumnLayout {
            id:boardColumn


            spacing: layoutGridSpacing
            Home.BalanceDiode {

                id:balanceDiode
                Layout.maximumHeight: 330
            }

            Home.BalanceValueDiode {
            }
        }


       ReceiveCoinsDiode{
           // color:"green"
        }



}
