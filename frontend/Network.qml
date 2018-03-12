import QtQuick 2.0

Item {
    property var handler

    function getAccountAddress(name) {
        handler.request('getaccountaddress', [name])
    }

    function getBalance() {
        handler.request('getbalance', [])
    }

    function listAccounts() {
        handler.request('listaccounts', [])
    }

    function listTransactions() {
        handler.request('listtransactions', [])
    }

    function sendToAddress(address, amount) {
        handler.request('sendtoaddress', [address, amount])
    }

    function validateAddress(address) {
        handler.request('validateaddress', [address])
    }
}
