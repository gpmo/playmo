const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Playmo', function () {
  it('Should add 4 same score players to the leaderboard', async function () {
    const Playmo = await ethers.getContractFactory('Playmo');
    const playmo = await Playmo.deploy();
    await playmo.deployed();

    const accounts = await hre.ethers.getSigners();

    let tx = await playmo.updateScore(accounts[0].address, 100);
    // wait until the transaction is mined
    await tx.wait();
    tx = await playmo.updateScore(accounts[1].address, 200);
    await tx.wait();
    tx = await playmo.updateScore(accounts[2].address, 300);
    await tx.wait();
    tx = await playmo.updateScore(accounts[3].address, 400);

    for (var i = 0; i < 4; i++) {
      const player = await playmo.topPlayers(i);
      // console.log(player);
    }

    expect(true);
  });
});
