// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Character is ERC721, Ownable {
    using SafeERC20 for IERC20;
    using Counters for Counters.Counter;

    IERC20 public immutable coin;
    //Variable
    Counters.Counter private _tokenIdCounter;
    mapping(address => bool) public minted_address;
    mapping(uint => string) public name;
    //skill level
    mapping(uint => uint[]) public skill;

    //Event
    event summoned(address indexed owner, uint hunter);
    event skilled(address indexed owner, uint skill, uint hunter);
    event named(address indexed owner, string name, uint hunter);

    constructor(IERC20 _coin) ERC721("Character", "HUNTER") {
        coin = _coin;
    }

    function summon() external {
        require(minted_address[msg.sender] == false, "Already summoned");

        uint _next_hunter = _tokenIdCounter.current();
        name[_next_hunter] = Strings.toHexString(msg.sender);
        skill[_next_hunter] = [0, 0, 0];
        minted_address[msg.sender] = true;

        _safeMint(msg.sender, _next_hunter);
        emit summoned(msg.sender, _next_hunter);
        _tokenIdCounter.increment();
    }

    function skill_up(uint _hunter, uint _skill_index) external onlyOwner {
        // require(_isApprovedOrOwner(msg.sender, _hunter));
        uint _skill_level = skill[_hunter][_skill_index];
        uint _coin_required = coin_required(_skill_level);
        coin.safeTransfer(address(0), _coin_required);
        // coin[_hunter] -= _coin_required;
        skill[_hunter][_skill_index] = _skill_level + 1;
        emit skilled(msg.sender, skill[_hunter][_skill_level], _hunter);
    }

    function change_name(uint _hunter, string memory _name) external onlyOwner {
        // require(_isApprovedOrOwner(msg.sender, _hunter));
        name[_hunter] = _name;
        emit named(msg.sender, _name, _hunter);
    }

    function coin_required(uint curent_skill)
        public
        pure
        returns (uint coin_to_next_skill)
    {
        curent_skill > 0
            ? coin_to_next_skill = curent_skill * 1e18
            : coin_to_next_skill = 1e18;
    }

    function hunter_info(uint _hunter)
        external
        view
        returns (string memory _name, uint[] memory _skill)
    {
        _name = name[_hunter];
        _skill = skill[_hunter];
    }
}
