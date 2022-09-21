// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/KeeperCompatible.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";

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
    function d4(uint _hunter) external view returns (uint);
}

contract Events is KeeperCompatibleInterface {
    //----------------need fix the address--------------------
    Character constant _character =
        Character(0xce761D788DF608BD21bdd59d6f4B54b2e27F25Bb);
    CodexEvents constant _codex_events =
        CodexEvents(0x67ae39a2Ee91D7258a86CD901B17527e19E493B3);
    CodexBaseRandom constant _codex_base_random =
        CodexBaseRandom(0x67ae39a2Ee91D7258a86CD901B17527e19E493B3);
    //---------------------------------------------------------

    uint public counter;
    /**
     * Use an interval in seconds and a timestamp to slow execution of Upkeep
     */
    uint public immutable interval;
    uint public lastTimeStamp;

    function checkUpkeep(
        bytes memory /* checkData */
    )
        public
        view
        override
        returns (
            bool upkeepNeeded,
            bytes memory /* performData */
        )
    {
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;
    }

    function performUpkeep(
        bytes calldata /* performData */
    ) external override {
        (bool upkeepNeeded, ) = checkUpkeep("");
        if ((block.timestamp - lastTimeStamp) > interval) {
            lastTimeStamp = block.timestamp;
            counter = counter + 1;
        }
    }

    constructor(uint updateInterval) {
        interval = updateInterval;
        lastTimeStamp = block.timestamp;
        counter = 0;
    }

    mapping(uint => uint8) public events;

    //Generate a random event
    function set_events(uint _hunter) external {
        require(_isApprovedOrOwner(_hunter));
        uint8 _current_events;
        _current_events = SafeCast.toUint8(_codex_base_random.d4(_hunter));
        events[_hunter] = _current_events;
    }

    //Get current event
    function get_events(uint _hunter) external view returns (uint8) {
        return events[_hunter];
    }

    function _isApprovedOrOwner(uint _hunter) internal view returns (bool) {
        return
            _character.getApproved(_hunter) == msg.sender ||
            _character.ownerOf(_hunter) == msg.sender;
    }
}
