// SPDX-License-Identifier: MIT
// contracts/access-control/Auth.sol

pragma solidity ^0.8.0;

contract ToSBT {
    address private _administrator;

    constructor() {
        // Make the deployer of the contract the administrator
        _administrator = msg.sender;
    }

    function isAdministrator(address user) public view returns (bool) {
        return user == _administrator;
    }
}