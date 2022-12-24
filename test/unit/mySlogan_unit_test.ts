
import { ethers } from "hardhat";
import { expect } from "chai";
import { BigNumber } from "ethers";
import { parseEther } from "ethers/lib/utils";
import { assert } from "console";
import { beforeEach } from "mocha";


  describe("MySlogan_Test", async function () {
    
    it("should send tip to the publisher address", async function () {
      const MySlogan = await ethers.getContractFactory("MySlogan");
      const mySlogan = await MySlogan.deploy();
      await mySlogan.deployed();

      const [publisher, addr1] = await ethers.getSigners();
      await mySlogan.publish('first_slogan');

      const tx = {
        to: "0x8ba1f109551bD432803012645Ac136ddd64DBA72",
        value: utils.parseEther("1.0")
      }
      await expect Wallet.sendTransaction(tx);
    });  
     
      it("should revert if the slogan has been already published", async function () {
          
      const MySlogan = await ethers.getContractFactory("MySlogan");
      const mySlogan = await MySlogan.deploy();
      await mySlogan.deployed();
      await mySlogan.publish('first_slogan');
        
      await expect (mySlogan.publish('first_slogan')).to.be.revertedWith("This Slogan has already been published!");
    });
    

    it("should revert if the slogan has already been liked by the caller address", async function () {
      
      const MySlogan = await ethers.getContractFactory("MySlogan");
      const mySlogan = await MySlogan.deploy();
      await mySlogan.deployed();
      const tx = (await mySlogan.publish('first_slogan'));
      const tx2 = (await mySlogan.like('0'));

      await expect (mySlogan.like('0')).to.be.revertedWith("You've already liked this Slogan!");

    });
    

    /*xit("", async function() {
    
      const MySlogan = await ethers.getContractFactory("MySlogan");
    
      //2. Deploy our contract using deploy and deployed function from nomiclabs/hardhat-ethers
      const mySlogan = await MySlogan.deploy();
      await mySlogan.deployed();
    
      const tx = (await mySlogan.publish('first_slogan'));
      const tx2 = (await mySlogan.like('0'));

      await expect (mySlogan.slogans[id].likes).not.to.be.equal('0');
    }); */

    /*it("should check if the slogan is listed", async function () {
      const MySlogan = await ethers.getContractFactory("MySlogan");
    
      //2. Deploy our contract using deploy and deployed function from nomiclabs/hardhat-ethers
      const mySlogan = await MySlogan.deploy();
      await mySlogan.deployed();
    
      const tx = (await mySlogan.publish('first_slogan'));
    
      await expect ('first_slogan').to.be.a.members.slogans[];
    }) */

    /*it("should check if the slogan is listed", async function () {
      const MySlogan = await ethers.getContractFactory("MySlogan");
    
      const mySlogan = await MySlogan.deploy();
      await mySlogan.deployed();
    
      const tx = (await mySlogan.publish('first_slogan'));
    
      await expect(await mySlogan.list())..................;
    });*/

    it("should increase the number of likes of the slogan by 1", async function () {
      const MySlogan = await ethers.getContractFactory("MySlogan");
      const mySlogan = await MySlogan.deploy();
      await mySlogan.deployed();
      await mySlogan.publish('first_slogan');
      await mySlogan.like(0);
      const likeNumber = await mySlogan.getLikeNumber(0);
      expect(likeNumber).to.equal(1);
      
    })  
    

    /*xit("should calculate 10 percent of the tip sent", async function () {
        const MySlogan = await ethers.getContractFactory("MySlogan");
    
        const mySlogan = await MySlogan.deploy();
        await mySlogan.deployed();
        
        const commissionPercent = 10;
        const tx = await mySlogan.publish('first_slogan');
        await mySlogan.tip(0);
        
        await expect(mySlogan.get_comm_fee(0)) = commissionPercent;
    }); 
    */
    
});
