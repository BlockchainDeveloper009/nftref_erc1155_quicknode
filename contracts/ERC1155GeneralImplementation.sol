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

contract NftStaker{
    IERC1155 public parentNFT;
    struct Stake {
        uint256 tokenId;
        uint256 amount;
        uint256 timestamp;
    }
    // map staker address to stake details
    mapping(address => Stake) public stakes;
    // map staker to total staking time
    mapping(address => uint256) public stakingTime;

    constructor(){
        parentNFT = IERC1155(0x)
    }
    
    function stake(uint256 _tokenId, uint256 _amount) public {
        stakes[msg.sender] = Stake(_tokenId, _amount, block.timestamp);
        parentNFT.safeTransferFrom(msg.sender, address(this), _tokenId, _amount, "0x00");
    }
    // *required
    // this method helps us to react what happens to the nft that is sent to the contract
    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4){
        return bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"));
    }

    function unstake(uint256 _tokenId, uint256 _amount) public {
        parentNFT.safeTransferFrom(
            address(this), msg.sender, stakes[msg.sender].tokenId,
            stakes[msg.sender].amount, "0x00");

        stakingTime[msg.sender] += (block.timestamp - stakes[msg.sender].timestamp);
        delete stakes[msg.sender];
    }

}