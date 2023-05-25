// contracts/ERC1155Token.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

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
    address parentContract = 0xd9145CCE52D386f254917e481eB44e9943F39138;

    constructor(){
        parentNFT = IERC1155(0xd9145CCE52D386f254917e481eB44e9943F39138); //contract address of ERC1155Token
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