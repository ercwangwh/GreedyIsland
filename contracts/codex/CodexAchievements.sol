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
            return find_the_door();
        } else if (_id == 2) {
            return find_the_door();
        } else if (_id == 3) {
            return wander();
        }
    }

    function find_the_door()
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
        name = "Find the door";
        attribute_id = 4;
        synergy = 6; // craft
        retry = false;
        armor_check_penalty = false;
        check = "Check to open the door, need key";
        action = "Find the door";
    }

    function find_key()
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
        name = "Find the key";
        attribute_id = 4;
        synergy = 6; // craft
        retry = false;
        armor_check_penalty = false;
        check = "Check attributes to get the key, need clothes";
        action = "Find the key";
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
        id = 3;
        name = "Wander";
        attribute_id = 4;
        synergy = 6; // craft
        retry = false;
        armor_check_penalty = false;
        check = "Nothing happen";
        action = "Wander around, nothing happen";
    }
}
