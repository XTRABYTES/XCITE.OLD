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

Component.prototype.createOperations = function()
{
    try {
        component.createOperations();

        if (systemInfo.productType === "windows") {
            // Create desktop shortcut
            try {
                var userProfile = installer.environmentVariable("USERPROFILE");
                installer.setValue("UserProfile", userProfile);
                component.addOperation("CreateShortcut", "@TargetDir@/XCITE.exe", "@UserProfile@/Desktop/XCITE.lnk");
            } catch (e) {
                // Do nothing if key doesn't exist
            }


            // Create start menu shortcut
            component.addOperation("CreateShortcut", "@TargetDir@/XCITE.exe", "@StartMenuDir@/XCITE.lnk");
        }
    } catch (e) {
        print(e);
    }
}
