var Dir = new function () {
    this.toNativeSparator = function (path) {
        if (systemInfo.productType === "windows")
            return path.replace(/\//g, '\\');
        return path;
    }
};

function Component() {
    if (installer.isInstaller()) {
        component.loaded.connect(this, Component.prototype.installerLoaded);
    }
}

Component.prototype.installerLoaded = function () {
    if (installer.addWizardPage(component, "FeedbackPage", QInstaller.LicenseCheck )) {
        var page = gui.pageWidgetByObjectName("DynamicFeedbackPage");
        if (page != null) {
            page.acceptFeedback.toggled.connect(this, Component.prototype.checkAccepted);

            page.complete = false;
            page.declineFeedback.checked = true;
            page.windowTitle = "Feedback Agreement";
        }
    }
}

Component.prototype.checkAccepted = function (checked) {
    var page = gui.pageWidgetByObjectName("DynamicFeedbackPage");
    if (page != null)
        page.complete = checked;
}
