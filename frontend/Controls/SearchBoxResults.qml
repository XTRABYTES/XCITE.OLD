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

    default property alias children: searchBoxResultsCategoryId.children
    property alias childCont: searchBoxResultsCategoryId
    property string text: ""

    onTextChanged: {
        console.log("text of search changed")

        filterResult(text)
    }

    function filterResult(textToSearch) {
        //traverse results and set to visible
        var isAnyCategoryVisible = false
        textToSearch = textToSearch.toLowerCase()
        for (var i = 0; i < searchBoxResultsId.children.length; i++) {

            // Show or hide categories. They hide themselves if no child is visible or available
            var isVisibleCategory = searchBoxResultsId.children[i].filterResult(
                        textToSearch)

            if (isVisibleCategory) {
                isAnyCategoryVisible = true
            }
        }

        // hide results box if no category is visible
        searchResultsBox.visible = isAnyCategoryVisible
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
            id: searchBoxResultsCategoryId
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
                    selectView("xChat.TBD")
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
                text: qsTr("MORE")
                tags: "test bot script miscellaneous additional"
                function onSearchResultClicked() {
                    selectView("tools.TBD")
                    searchResultsBox.visible = false
                }
            }
        }
    }
}
