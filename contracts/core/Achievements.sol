// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Character {
    function level(uint) external view returns (uint);

    function getApproved(uint) external view returns (address);

    function ownerOf(uint) external view returns (address);
}

interface CodexAchievement {
    function achievement_by_id(uint)
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

contract Achievements {
    //----------------need fix the address--------------------
    Character constant _hunter =
        Character(0xce761D788DF608BD21bdd59d6f4B54b2e27F25Bb);
    CodexAchievement constant _codex_achievements =
        CodexAchievement(0x67ae39a2Ee91D7258a86CD901B17527e19E493B3);

    //---------------------------------------------------------

    mapping(uint => uint8[36]) public achievements;

    function set_achievements(uint _summoner, uint8[36] memory _achievements)
        external
    {
        require(_isApprovedOrOwner(_summoner));
        uint8[36] memory _current_achievements = achievements[_summoner];
        for (uint i = 0; i < 36; i++) {
            require(_current_achievements[i] <= _achievements[i]);
        }
        achievements[_summoner] = _achievements;
    }

    function get_achievements(uint _summoner)
        external
        view
        returns (uint8[36] memory)
    {
        return achievements[_summoner];
    }

    function _isApprovedOrOwner(uint _summoner) internal view returns (bool) {
        return
            _hunter.getApproved(_summoner) == msg.sender ||
            _hunter.ownerOf(_summoner) == msg.sender;
    }
}
