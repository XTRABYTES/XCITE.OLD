import QtQuick 2.0
import QtQuick.Layouts 1.3

import "../../Controls" as Controls
import "../Home" as Home
ColumnLayout {

    readonly property color cBoardBackground: "#3a3e46"

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
            Home.BalanceBoard {
                id:balanceBoard
                Layout.maximumHeight: 330
            }

            Home.BalanceValueBoard {
            }
        }


        ReceiveBoard{
           // color:"green"
        }



}
