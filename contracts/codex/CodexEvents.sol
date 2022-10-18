// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract CodexEvents {
    string public constant index = "Skills";

    function event_by_id(uint _id)
        external
        pure
        returns (
            uint id,
            string memory name,
            bool retry,
            string memory text,
            string memory traits_type_check,
            uint event_dependency,
            string memory success_text,
            string memory failure_text
        )
    {
        if (_id == 1) {
            return find_the_door();
        } else if (_id == 2) {
            return find_key();
        } else if (_id == 3) {}
    }

    function find_the_door()
        public
        pure
        returns (
            uint id,
            string memory name,
            bool retry,
            string memory text,
            string memory traits_type_check,
            uint event_dependency,
            string memory success_text,
            string memory failure_text
        )
    {
        id = 1;
        name = "Find the door";
        retry = false;
        text = "You find a door named 'Chapert 0' on this island";
        traits_type_check = "";
        event_dependency = 2;
        success_text = "You success open the door";
        failure_text = "The door is locked, you need find someting to open it.";
    }

    function find_key()
        public
        pure
        returns (
            uint id,
            string memory name,
            bool retry,
            string memory text,
            string memory traits_type_check,
            uint event_dependency,
            string memory success_text,
            string memory failure_text
        )
    {
        id = 2;
        name = "Find the key";
        retry = false;
        text = "You find a locked box. The password hint is time.";
        traits_type_check = "4:20 watch";
        event_dependency = 0;
        success_text = "You hava watch in your traits. You type in current time as password and get a golden key.";
        failure_text = "The box is locked, you need to find the password.";
    }
}
