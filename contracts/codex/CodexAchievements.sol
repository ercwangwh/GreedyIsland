// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract CodexAchievements {
    string public constant index = "Achievements";

    function achievement_by_id(uint _id)
        external
        pure
        returns (
            uint id,
            string memory name,
            uint attribute_id,
            uint synergy,
            bool retry,
            bool armor_check_penalty,
            string memory check,
            string memory action
        )
    {
        if (_id == 1) {
            return walkthourgh_chapter0();
        } else if (_id == 2) {
            return wander();
        } else if (_id == 3) {
            return wander();
        }
    }

    function walkthourgh_chapter0()
        public
        pure
        returns (
            uint id,
            string memory name,
            uint attribute_id,
            uint synergy,
            bool retry,
            bool armor_check_penalty,
            string memory check,
            string memory action
        )
    {
        id = 1;
        name = "Chapter 0 Finished";
        attribute_id = 4;
        synergy = 6; // craft
        retry = false;
        armor_check_penalty = false;
        check = "Complete find the door event";
        action = "Complete";
    }

    function wander()
        public
        pure
        returns (
            uint id,
            string memory name,
            uint attribute_id,
            uint synergy,
            bool retry,
            bool armor_check_penalty,
            string memory check,
            string memory action
        )
    {
        id = 2;
        name = "Wander";
        attribute_id = 4;
        synergy = 6; // craft
        retry = false;
        armor_check_penalty = false;
        check = "wander 10 times";
        action = "Wander";
    }
}
