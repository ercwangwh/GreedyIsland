// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Character is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    struct CharInfo {
        string name;
    }

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Character", "HUNTER") {}

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }
}
