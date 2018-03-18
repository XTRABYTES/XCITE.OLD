import QtQuick 2.0

Item {
    property var handler

    function getAccountAddress(name) {
        handler.request('ui', 'getaccountaddress', [name])
    }

    function getBalance() {
        handler.request('ui', 'getbalance', [])
    }

    function listAccounts() {
        handler.request('ui', 'listaccounts', [])
    }

    function listTransactions() {
        handler.request('ui', 'listtransactions', [])
    }

    function sendToAddress(address, amount) {
        handler.request('ui', 'sendtoaddress', [address, amount])
    }

    function validateAddress(address) {
        handler.request('ui', 'validateaddress', [address])
    }
}
