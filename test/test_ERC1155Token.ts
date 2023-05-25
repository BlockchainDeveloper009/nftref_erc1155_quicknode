import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
let test1desc = "deploy_testERC1155Token";
describe(test1desc, function () {
    async function deployOneYearLockFixture() {
        const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
        const ONE_GWEI = 1_000_000_000;
    
        const lockedAmount = ONE_GWEI;
        const unlockTime = (await time.latest()) + ONE_YEAR_IN_SECS;
    
        // Contracts are deployed using the first signer/account by default
        const [owner, otherAccount] = await ethers.getSigners();
    
        const Lock = await ethers.getContractFactory("ERC1155Token");
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

      describe("test_methods", function () 
      {
            it("mintFirstId", async function () {
            const { lock, _ids, _names, owner, otherAccount } = await loadFixture(deployOneYearLockFixture);
        
            expect(await lock.mint(
              otherAccount,
              _ids[0],
              1
            )).to.equal( _ids[0]);
            });

            it("1-balanceOf", async function () {
              const { lock, _ids, _names, owner, otherAccount } = await loadFixture(deployOneYearLockFixture);
          
              expect(await lock.balanceOf(
                otherAccount,
                _ids[0]
              )).to.equal(1);
              });
            
              it("mintFirstId", async function () {
                const { lock, _ids, _names, owner, otherAccount } = await loadFixture(deployOneYearLockFixture);
            
                expect(await lock.mint(
                  otherAccount,
                  _ids[0],
                  1
                )).to.equal( _ids[0]);
                });
    
                it("2-balanceOf", async function () {
                  const { lock, _ids, _names, owner, otherAccount } = await loadFixture(deployOneYearLockFixture);
              
                  expect(await lock.balanceOf(
                    otherAccount,
                    _ids[0]
                  )).to.equal(2);
                  });
                
                  it("getNames", async function () {
                    const { lock, _ids, _names, owner, otherAccount } = await loadFixture(deployOneYearLockFixture);
                
                    expect(await lock.getNames()).to.equal(["test1","test2"]);
                    });
     });


});