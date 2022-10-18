// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

interface Character {
    function level(uint) external view returns (uint);

    function getApproved(uint) external view returns (address);

    function ownerOf(uint) external view returns (address);
}

contract Coin is ERC20, ERC20Burnable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    mapping(uint => uint) public claimed;

    Character constant hunter =
        Character(0xce761D788DF608BD21bdd59d6f4B54b2e27F25Bb);

    constructor() ERC20("Coin", "COIN") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function claim(uint _hunter) external {
        // require(_isApprovedOrOwner(summoner));
        // uint _current_level = hunter.level(summoner);
        // uint _claimed_for = claimed[summoner] + 1;
        // for (uint i = _claimed_for; i <= _current_level; i++) {
        //     _mint(summoner, 1000000);
        // }
        // claimed[summoner] = _current_level;
    }

    function _isApprovedOrOwner(uint _hunter) internal view returns (bool) {
        return
            hunter.getApproved(_hunter) == msg.sender ||
            hunter.ownerOf(_hunter) == msg.sender;
    }
}
