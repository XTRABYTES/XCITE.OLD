/**
 * Filename: SearchBoxResults.qml
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

Rectangle {
    // Containing gray rectangle
    id: searchResultsBox

    width: parent.width
    height: searchBoxResultsId.implicitHeight

    radius: 5
    border.color: "#4010B9C5"
    border.width: 3

    anchors.top: searchBoxId.bottom
    anchors.topMargin: 3

    visible: false
    opacity: 0.9
    color: "#3A3E46"

    default property alias children: searchBoxResultsId.children
    property alias childCont: searchBoxResultsId
    property string text: ""

    onTextChanged: {
        filterResult(text)
    }

    property int totalChildren: -1

    function countTotalChildren() {
        if (totalChildren >= 0) {
            return totalChildren
        }

        totalChildren = 0

        // Each category
        for (var i = 0; i < searchBoxResultsId.children.length; i++) {
            // Count items in each category
            totalChildren += searchBoxResultsId.children[i].children.length
        }
        return totalChildren
    }

    function filterResult(textToSearch) {
        //traverse results and set to visible
        var totalVisibleChildrenCount = 0

        textToSearch = textToSearch.toLowerCase()
        for (var i = 0; i < searchBoxResultsId.children.length; i++) {

            // Show or hide categories. They hide themselves if no child is visible or available
            totalVisibleChildrenCount += searchBoxResultsId.children[i].filterResult(
                        textToSearch)
        }

        // hide results box if search is not specific enough
        var totalChildrenCount = countTotalChildren()
        var matchRate = (totalVisibleChildrenCount / totalChildrenCount)
        searchResultsBox.visible = matchRate > 0 && matchRate < 0.30
    }

    Column {
        // Box containing categories
        id: searchBoxResultsId
        visible: true

        spacing: 2
        padding: 5

        width: parent.width
        height: Column.height

        SearchBoxResultsCategory {
            id: searchBoxResultsModulesCategoryId
            text: qsTr("Modules")

            SearchBoxResultsCategoryItem {
                text: qsTr("XCITE")
                tags: "home board manage balance wallet"

                function onSearchResultClicked() {
                    selectView("xCite.home")
                    searchResultsBox.visible = false
                }
            }

            SearchBoxResultsCategoryItem {
                text: qsTr("X-CHANGE")
                tags: "exchange buy sell market"
                function onSearchResultClicked() {
                    selectView("xChange.home")
                    searchResultsBox.visible = false
                }
            }

            SearchBoxResultsCategoryItem {
                text: qsTr("X-CHAT")
                tags: "conversation communication communicate comm speak talk"
                function onSearchResultClicked() {
                    selectView("xChat.home")
                    searchResultsBox.visible = false
                }
            }

            SearchBoxResultsCategoryItem {
                text: qsTr("X-VAULT")
                tags: "storage memory save file"
                function onSearchResultClicked() {
                    selectView("xVault.TBD")
                    searchResultsBox.visible = false
                }
            }

            SearchBoxResultsCategoryItem {
                text: qsTr("SETTINGS")
                tags: "config option fix adjust"
                function onSearchResultClicked() {
                    selectView("xCite.settings")
                    searchResultsBox.visible = false
                }
            }

            SearchBoxResultsCategoryItem {
                text: qsTr("MORE")
                tags: "test bot script miscellaneous additional"
                function onSearchResultClicked() {
                    selectView("tools.TBD")
                    searchResultsBox.visible = false
                }
            }
        }

        SearchBoxResultsCategory {
            id: searchBoxResultsLinksCategoryId
            text: qsTr("Links")

            SearchBoxResultsCategoryItem {
                text: qsTr("Official Website")
                tags: "official site web help about net coin about"
                function onSearchResultClicked() {
                    searchResultsBox.visible = false
                    Qt.openUrlExternally("https://xtrabytes.global")
                }
            }

            SearchBoxResultsCategoryItem {
                text: qsTr("FAQ")
                tags: "question answer qa q&a help"
                function onSearchResultClicked() {
                    searchResultsBox.visible = false
                    Qt.openUrlExternally(
                                "https://support.xtrabytes.global/hc/en-us/categories/360000009431-FAQ")
                }
            }

            SearchBoxResultsCategoryItem {
                text: qsTr("Block Explorer")
                tags: "blockchain transaction history browse"
                function onSearchResultClicked() {
                    searchResultsBox.visible = false
                    Qt.openUrlExternally(
                                "https://blockexplorer.xtrabytes.global")
                }
            }

            SearchBoxResultsCategoryItem {
                text: qsTr("Blog")
                tags: "blog news xtrabytes today"
                function onSearchResultClicked() {
                    searchResultsBox.visible = false
                    Qt.openUrlExternally("https://blog.xtrabytes.global")
                }
            }
        }
    }
}
