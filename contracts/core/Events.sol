// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/utils/math/SafeCast.sol";

interface Character {
    function level(uint) external view returns (uint);

    function events_status(uint, uint) external view returns (bool);

    function getApproved(uint) external view returns (address);

    function ownerOf(uint) external view returns (address);
}

// interface CodexEvents {
//     function event_by_id(uint)
//         external
//         view
//         returns (
//             uint id,
//             string memory name,
//             bool retry,
//             string memory text,
//             string memory traits_type_check,
//             uint event_dependency,
//             string memory success_text,
//             string memory failure_text
//         );
// }

interface CodexBaseRandom {
    function d4(uint _hunter) external view returns (uint);
}

// interface BaseAttributes {
//     struct Appearance {
//         bytes32 body;
//         bytes32 clothes;
//         bytes32 ear;
//         bytes32 eyes;
//         bytes32 hair;
//         bytes32 hat;
//         bytes32 mouth;
//         bytes32 pants;
//     }

//     function get_appearance(uint _hunter)
//         external
//         view
//         returns (Appearance memory _appearance);
// }

contract Events {
    //----------------need fix the address--------------------
    Character constant _character =
        Character(0xce761D788DF608BD21bdd59d6f4B54b2e27F25Bb);
    // CodexEvents constant _codex_events =
    //     CodexEvents(0x67ae39a2Ee91D7258a86CD901B17527e19E493B3);
    CodexBaseRandom constant _codex_base_random =
        CodexBaseRandom(0x67ae39a2Ee91D7258a86CD901B17527e19E493B3);
    // BaseAttributes constant _base_attributes =
    //     BaseAttributes(0x67ae39a2Ee91D7258a86CD901B17527e19E493B3);
    //---------------------------------------------------------

    mapping(uint => uint8) public events;

    event __current_event(address indexed owner, uint hunter);

    //Generate a random event
    function generate_events(uint _hunter) external {
        require(_isApprovedOrOwner(_hunter));
        uint8 _current_events;
        _current_events = SafeCast.toUint8(_codex_base_random.d4(_hunter));
        events[_hunter] = _current_events;
        emit __current_event(msg.sender, _hunter);
    }

    //Get current event
    function get_events(uint _hunter) external view returns (uint8) {
        return events[_hunter];
    }

    // function handle_events(uint _hunter) external view returns (string memory) {
    //     // require(_isApprovedOrOwner(_hunter));
    //     uint _current_id = events[_hunter];
    //     (
    //         uint _id,
    //         ,
    //         ,
    //         ,
    //         string memory _traits_type_check,
    //         uint _event_dependency,
    //         string memory _success_text,
    //         string memory _failure_text
    //     ) = _codex_events.event_by_id(_current_id);

    //     //check if event dependecy need
    //     bool _event_status_check = true;
    //     if (_event_dependency > 0) {
    //         _event_status_check = _character.events_status(
    //             _hunter,
    //             _event_dependency
    //         );
    //     }

    //     //check if traits meet the event require
    //     bytes32 _appearance = _base_attributes.get_appearance(_hunter).body;
    //     bool _traits_status_check = (keccak256(
    //         abi.encodePacked(_traits_type_check)
    //     ) == keccak256(abi.encodePacked(_appearance)));

    //     if (_traits_status_check && _event_status_check) return _success_text;
    //     else return _failure_text;
    // }

    function _isApprovedOrOwner(uint _hunter) internal view returns (bool) {
        return
            _character.getApproved(_hunter) == msg.sender ||
            _character.ownerOf(_hunter) == msg.sender;
    }
}
