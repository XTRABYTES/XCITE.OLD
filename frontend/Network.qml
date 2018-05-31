/**
 * Filename: Network.qml
 *
 * XCITE is a secure platform utilizing the XTRABYTES Proof of Signature
 * blockchain protocol to host decentralized applications
 *
 * Copyright (c) 2017-2018 Zoltan Szabo & XTRABYTES developers
 *
 * This file is part of an XTRABYTES Ltd. project.
 *
 */
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
