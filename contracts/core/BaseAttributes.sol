// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Character {
    function getApproved(uint) external view returns (address);

    function ownerOf(uint) external view returns (address);
}

contract BaseAttributes {
    struct Appearance {
        bytes32 body;
        bytes32 clothes;
        bytes32 ear;
        bytes32 eyes;
        bytes32 hair;
        bytes32 hat;
        bytes32 mouth;
        bytes32 pants;
    }

    mapping(uint => Appearance) public appearance;
    mapping(uint => uint) public level_points_spent;
    mapping(uint => bool) public character_created;
}
