import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtWebView 1.1

import "../Controls" as Controls

Item {
    readonly property string defaultView: "index"

    property string selectedView
    property string selectedModule

    property string supportURL: "https://support.xtrabytes.global"
    property string oauthScope: "read"
    property string oauthURL: "https://" + developerSettings.zendeskCompanyID
                              + ".zendesk.com/oauth/authorizations/new?response_type=code&redirect_url=" + encodeURIComponent(
                                  developerSettings.zendeskRedirectURI) + "&client_id="
                              + developerSettings.zendeskClientID + "&scope=" + oauthScope

    Layout.fillHeight: true
    Layout.fillWidth: true

    visible: selectedModule === 'browser'

    Connections {
        target: dashboard
        onSelectView: {
            var parts = path.split('.')

            selectedModule = parts[0]
            if (parts.length === 2) {
                selectedView = parts[1]
            } else {
                selectedView = defaultView
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        visible: selectedView === "index"
        spacing: layoutGridSpacing

        Item {
            visible: false
            Layout.fillWidth: true
            Layout.minimumHeight: 40

            Controls.ButtonModal {
                labelText: qsTr("ACCESS ZENDESK")
                width: 175
                isPrimary: true
                onButtonClicked: {
                    browser.url = oauthURL
                }
            }
        }

        WebView {
            id: browser

            Layout.fillHeight: true
            Layout.fillWidth: true

            url: supportURL
            onLoadingChanged: {

                //console.log(loadRequest.url)
                var re = /\/zendesk-complete\.php\?access_token=(.+)/
                var matches = loadRequest.url.toString().match(re)

                if (matches && (matches.length === 2)) {
                    zendeskAccessTokenSet(matches[1])
                    browser.url = supportURL
                }
            }
        }
    }
}
