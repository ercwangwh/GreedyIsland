// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

// import "@openzeppelin/contracts/access/AccessControl.sol";

interface Character {
    function level(uint) external view returns (uint);

    function getApproved(uint) external view returns (address);

    function ownerOf(uint) external view returns (address);
}

contract Coin is ERC20, ERC20Burnable {
    mapping(uint => uint) public claimed;
    Character public immutable hunter;

    constructor(address _hunter) ERC20("Coin", "COIN") {
        hunter = Character(_hunter);
        _mint(msg.sender, 1000000 * 10**decimals());
    }

    // function mint(address to, uint256 amount) public {
    //     _mint(to, amount);
    // }

    // function claim(uint _hunter) external {
    //     require(_isApprovedOrOwner(_hunter));
    //     uint _current_level = hunter.level(summoner);
    //     uint _claimed_for = claimed[summoner] + 1;
    //     for (uint i = _claimed_for; i <= _current_level; i++) {
    //         _mint(_hunter, 1000000);
    //     }
    //     claimed[summoner] = _current_level;
    // }

    function _isApprovedOrOwner(uint _hunter) internal view returns (bool) {
        return
            hunter.getApproved(_hunter) == msg.sender ||
            hunter.ownerOf(_hunter) == msg.sender;
    }
}
