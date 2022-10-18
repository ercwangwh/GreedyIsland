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
    mapping(address => bool) public minted_address;
    mapping(uint => string) public name;
    mapping(uint => uint) public level;
    mapping(uint => uint) public xp;
    // mapping(uint => uint) public coins;

    //Event
    event summoned(address indexed owner, uint hunter);
    event leveled(address indexed owner, uint level, uint hunter);
    event named(address indexed owner, uint name, uint hunter);

    constructor() ERC721("Character", "HUNTER") {}

    function summon() external {
        require(minted_address[msg.sender] == false, "Already summoned");

        uint _next_hunter = _tokenIdCounter.current();
        name[_next_hunter] = Strings.toHexString(msg.sender);
        level[_next_hunter] = 1;
        minted_address[msg.sender] = true;

        _safeMint(msg.sender, _next_hunter);
        emit summoned(msg.sender, _next_hunter);
        _tokenIdCounter.increment();
    }

    function level_up(uint _hunter) external {
        require(_isApprovedOrOwner(msg.sender, _hunter));
        uint _level = level[_hunter];
        uint _xp_required = xp_required(_level);
        xp[_hunter] -= _xp_required;
        level[_hunter] = _level + 1;
        emit leveled(msg.sender, level[_hunter], _hunter);
    }

    function change_name(uint _hunter, string memory _name) external {
        require(_isApprovedOrOwner(msg.sender, _hunter));
        name[_hunter] = _name;
        emit named(msg.sender, level[_hunter], _hunter);
    }

    function spend_xp(uint _hunter, uint _xp) external {
        require(_isApprovedOrOwner(msg.sender, _hunter));
        xp[_hunter] -= _xp;
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

    function hunter_info(uint _hunter)
        external
        view
        returns (
            string memory _name,
            uint _xp,
            uint _level
        )
    {
        _name = name[_hunter];
        _xp = xp[_hunter];
        _level = level[_hunter];
    }
}
