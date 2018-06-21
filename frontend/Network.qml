import QtQuick 2.0

Item {
    property var handler

    function ensureSession(cb) {
        if (!handler.hasValidSession()) {
            return handler.sessionCreate(function (res) {
                return wrapResponse(res, cb)
            })
        }

        return cb()
    }

    function wrapResponse(res, cb) {
        if (res.error) {
            return cb(new Error(res.message), res)
        }

        return cb(null, res)
    }

    function userLogin(username, password, cb) {
        ensureSession(function () {
            handler.userLogin(username, password, function (res) {
                wrapResponse(res, cb)
            })
        })
    }

    function sendConsoleCommand(args) {
        ensureSession(function () {
            handler.sendRequest(args, function (res) {
                wrapResponse(res, cb)
            })
        })
    }

    function getPrivateKey() {
        return handler.privateKey()
    }

    function userCreate(username, password, cb) {
        ensureSession(function () {
            handler.userCreate(username, password, function (res) {
                wrapResponse(res, cb)
            })
        })
    }

    function getAccountAddress(name) {//        handler.request('ui', 'getaccountaddress', [name])
    }

    function getBalance() {//        handler.request('ui', 'getbalance', [])
    }

    function listAccounts() {//        handler.request('ui', 'listaccounts', [])
    }

    function listTransactions() {//        handler.request('ui', 'listtransactions', [])
    }

    function sendToAddress(address, amount) {//        handler.request('ui', 'sendtoaddress', [address, amount])
    }

    function validateAddress(address) {//        handler.request('ui', 'validateaddress', [address])
    }
}
