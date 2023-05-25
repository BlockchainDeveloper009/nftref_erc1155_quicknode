// contracts/ERC1155Token.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
//src: https://www.youtube.com/watch?v=19SSvs32m8I
//@author: blkcdev
//#tools similar to ipfs: 
//1. nft.storage (upload batch of files)
//2. storej
//3. filecoin
//4. arweave

//developerDao academy
//academy.developerdao.com
//buildspace.so
//capturetheether.com
//cryptozombies.io / solidity 101
//artur chmaro

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract ERC1155GeneralImplementation is ERC1155, Ownable {

    uint256 public constant CHARIZARD=0;
    uint256 public constant IVYSAUR=1;
    mapping(uint256=> string) private _uris;

    constructor() public ERC1155(""){
        _mint(msg.sender, CHARIZARD,100,"");
        _mint(msg.sender, IVYSAUR,100,"");
    }
    //old method not used anymore.
     function uri(uint256 tokenId) override public view returns (string memory)
    {
        return (_uris[tokenId]);
    }
    function setTokenUri(uint256 tokenId, string memory uri) public onlyOwner {
        require(bytes(_uris[tokenId]).length == 0, "Cannot set uri twice");
        _uris[tokenId] = uri;
    }

    function uri(uint256 tokenId, string sampleMethod) override internal view returns (string memory)
    {
        return (string(abi.encodePacked(
            "https://bafybeihul6z.ipfs.dweb.link/",
            Strings.toString(tokenId),
            ".json"
        )));
    }
}