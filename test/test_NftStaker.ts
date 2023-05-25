import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("NftStaker", function () {
    async function deployOneYearLockFixture() {
        const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
        const ONE_GWEI = 1_000_000_000;
    
        const lockedAmount = ONE_GWEI;
        const unlockTime = (await time.latest()) + ONE_YEAR_IN_SECS;
    
        // Contracts are deployed using the first signer/account by default
        const [owner, otherAccount] = await ethers.getSigners();
    
        const Lock = await ethers.getContractFactory("NftStaker");
        const lock = await Lock.deploy();
    
        return { lock, unlockTime, lockedAmount, owner, otherAccount };
      }

      describe("Deployment", function () 
      {
            it("onERC1155Received", async function () {
            const { lock, unlockTime } = await loadFixture(deployOneYearLockFixture);
        
                expect(await lock.onERC1155Received(
                  0xDA0bab807633f07f013f94DD0E6A4F96F8742B53,
                  0xd9145CCE52D386f254917e481eB44e9943F39138,
                  1,
                  10,
                  "0x00"
                  )).to.equal(unlockTime);

                  expect(await lock.stake(
                    1,
                    10              
                    )).to.equal(0xf23a6e61);

                  await lock.unstake(1,10);

                  const {tokenId,amount,tstamp} = await lock.stakingTime(0xDA0bab807633f07f013f94DD0E6A4F96F8742B53);
                  
                });

     });


});