// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Character {
    function level(uint) external view returns (uint);

    function getApproved(uint) external view returns (address);

    function ownerOf(uint) external view returns (address);
}

interface CodexEvents {
    function event_by_id(uint)
        external
        view
        returns (
            uint id,
            string memory name,
            uint attribute_id,
            uint synergy,
            bool retry,
            bool armor_check_penalty,
            string memory check,
            string memory action
        );
}

interface CodexBaseRandom {
    function d4(uint _summoner) external view returns (uint);
}

contract Events {
    //----------------need fix the address--------------------
    Character constant _hunter =
        Character(0xce761D788DF608BD21bdd59d6f4B54b2e27F25Bb);
    CodexEvents constant _codex_events =
        CodexEvents(0x67ae39a2Ee91D7258a86CD901B17527e19E493B3);
    CodexBaseRandom constant _random =
        CodexBaseRandom(0x7426dBE5207C2b5DaC57d8e55F0959fcD99661D4);

    //---------------------------------------------------------

    mapping(uint => uint8[36]) public events;

    function set_events(uint _summoner, uint8[36] memory _events) external {
        require(_isApprovedOrOwner(_summoner));
        uint8[36] memory _current_events = events[_summoner];
        for (uint i = 0; i < 36; i++) {
            require(_current_events[i] <= _events[i]);
        }
        events[_summoner] = _events;
    }

    function get_events(uint _summoner)
        external
        view
        returns (uint8[36] memory)
    {
        return events[_summoner];
    }

    function _isApprovedOrOwner(uint _summoner) internal view returns (bool) {
        return
            _hunter.getApproved(_summoner) == msg.sender ||
            _hunter.ownerOf(_summoner) == msg.sender;
    }
}
