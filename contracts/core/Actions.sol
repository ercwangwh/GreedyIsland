// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Character {
    function level(uint) external view returns (uint);

    function getApproved(uint) external view returns (address);

    function ownerOf(uint) external view returns (address);
}

interface Events {
    function set_events(uint hunter) external;
}

interface CodexBaseRandom {
    function d4(uint _hunter) external view returns (uint);
}

contract Actions {
    //----------------need fix the address--------------------
    Character constant _character =
        Character(0xce761D788DF608BD21bdd59d6f4B54b2e27F25Bb);
    Events constant _events =
        Events(0x67ae39a2Ee91D7258a86CD901B17527e19E493B3);
    CodexBaseRandom constant _codex_base_random =
        CodexBaseRandom(0x67ae39a2Ee91D7258a86CD901B17527e19E493B3);

    //---------------------------------------------------------

    function adventure(uint _hunter) external {
        require(_isApprovedOrOwner(_hunter));

        //Generat event
        _events.set_events(_hunter);
        //Check event completed

        //Get reward
    }

    function _isApprovedOrOwner(uint _hunter) internal view returns (bool) {
        return
            _character.getApproved(_hunter) == msg.sender ||
            _character.ownerOf(_hunter) == msg.sender;
    }
}
