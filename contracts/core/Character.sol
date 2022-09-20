// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Character is IERC721, ERC721URIStorage {
    using Counters for Counters.Counter;

    //Variable
    Counters.Counter private _tokenIdCounter;
    mapping(address => bool) private mintedAddress;
    mapping(uint => string) public name;
    mapping(uint => uint) public level;
    mapping(uint => uint) public xp;

    //Event
    event summoned(address indexed owner, uint summoner);
    event leveled(address indexed owner, uint level, uint summoner);
    event named(address indexed owner, uint name, uint summoner);

    constructor() ERC721("Character", "HUNTER") {}

    function summon() external {
        require(mintedAddress[msg.sender] == false, "Already summoned");

        uint _next_summoner = _tokenIdCounter.current();
        name[_next_summoner] = Strings.toHexString(msg.sender);
        level[_next_summoner] = 1;
        mintedAddress[msg.sender] = true;

        _safeMint(msg.sender, _next_summoner);
        emit summoned(msg.sender, _next_summoner);
        _tokenIdCounter.increment();
    }

    function level_up(uint _summoner) external {
        require(_isApprovedOrOwner(msg.sender, _summoner));
        uint _level = level[_summoner];
        uint _xp_required = xp_required(_level);
        xp[_summoner] -= _xp_required;
        level[_summoner] = _level + 1;
        emit leveled(msg.sender, level[_summoner], _summoner);
    }

    function change_name(uint _summoner, string memory _name) external {
        require(_isApprovedOrOwner(msg.sender, _summoner));
        name[_summoner] = _name;
        emit named(msg.sender, level[_summoner], _summoner);
    }

    function spend_xp(uint _summoner, uint _xp) external {
        require(_isApprovedOrOwner(msg.sender, _summoner));
        xp[_summoner] -= _xp;
    }

    function xp_required(uint curent_level)
        public
        pure
        returns (uint xp_to_next_level)
    {
        xp_to_next_level = curent_level * 1000e18;
        for (uint i = 1; i < curent_level; i++) {
            xp_to_next_level += curent_level * 1000e18;
        }
    }
}
