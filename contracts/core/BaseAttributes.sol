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
    // mapping(uint => mapping =>)

    // mapping(uint => mapping(uint => string)) public nested;

    mapping(uint => Appearance) public appearance;

    //----------------need fix the address--------------------
    Character constant _character =
        Character(0xce761D788DF608BD21bdd59d6f4B54b2e27F25Bb);

    //---------------------------------------------------------
    //Get character apperance
    function update_appearance(uint _hunter, bytes32[8] memory _trait_data)
        external
    {
        require(_isApprovedOrOwner(_hunter));
        //Need gas optimise later
        appearance[_hunter].body = _trait_data[0];
        appearance[_hunter].clothes = _trait_data[1];
        appearance[_hunter].ear = _trait_data[2];
        appearance[_hunter].eyes = _trait_data[3];
        appearance[_hunter].hair = _trait_data[4];
        appearance[_hunter].hat = _trait_data[5];
        appearance[_hunter].mouth = _trait_data[6];
        appearance[_hunter].pants = _trait_data[7];
    }

    //Get character apperance
    function get_appearance(uint _hunter)
        external
        view
        returns (Appearance memory _appearance)
    {
        _appearance = appearance[_hunter];
    }

    function _isApprovedOrOwner(uint _hunter) internal view returns (bool) {
        return
            _character.getApproved(_hunter) == msg.sender ||
            _character.ownerOf(_hunter) == msg.sender;
    }
}
