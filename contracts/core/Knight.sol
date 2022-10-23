// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

// NFT faucet for testing
contract Knight is ERC721 {
    using Counters for Counters.Counter;
    using Strings for uint256;
    string private _baseTokenURI;
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Knight", "KNT") {
        _baseTokenURI = "https://cloudflare-ipfs.com/ipfs/bafybeieifbwyhz4j3pf3l4ft2hfwfcygkcb3w2qp45sy2gxi2wh77kxbra/";
    }

    function safeMint() public {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(msg.sender, tokenId);
    }

    // function setBaseURI(string memory baseURI_) external onlyOwner {
    //     _baseTokenURI = baseURI_;
    // }
    function getBaseURI() external view returns (string memory) {
        return _baseTokenURI;
    }

    // function _baseURI() internal view virtual override returns (string memory) {
    //     return _baseTokenURI;
    // }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        // if (!_exists(tokenId)) revert URIQueryForNonexistentToken();
        require(_exists(tokenId), "Nonexistent token");
        string memory baseURI = _baseTokenURI;
        return
            bytes(baseURI).length != 0
                ? string(abi.encodePacked(baseURI, tokenId.toString()))
                : "";
    }
}
