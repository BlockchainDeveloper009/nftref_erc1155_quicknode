import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("ERC1155GeneralImplementation", function () {
    async function deployOneYearLockFixture() {
        const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
        const ONE_GWEI = 1_000_000_000;
    
        const lockedAmount = ONE_GWEI;
        const unlockTime = (await time.latest()) + ONE_YEAR_IN_SECS;
    
        // Contracts are deployed using the first signer/account by default
        const [owner, otherAccount] = await ethers.getSigners();
    
          
        const Lock = await ethers.getContractFactory("ERC1155GeneralImplementation");
        const _names = ["test1","test2"];
        const _ids = [1,2];
        const lock = await Lock.deploy(
          "testBaashaToken",
          "",//uri
          _names,
          _ids

        );
    
        return { lock, _ids, _names, owner, otherAccount };

      }

      describe("Deployment", function () 
      {
            it("Should set the right unlockTime", async function () {
            const { lock, unlockTime } = await loadFixture(deployOneYearLockFixture);
        
            expect(await lock.unlockTime()).to.equal(unlockTime);
            });
     });
     /*
     https://bobbyhadz.com/blog/javascript-access-value-of-promise#:~:text=then()%20method%20to%20access,the%20promise%20as%20a%20parameter.
     
// 👇️ Example promise
const p = Promise.resolve('hello');

p.then(value => {
  console.log(value); // 👉️ "hello"
}).catch(err => {
  console.log(err);
});

     */

});