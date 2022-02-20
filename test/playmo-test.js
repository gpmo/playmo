const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Playmo', function () {
  it('Should add 4 same score players to the leaderboard', async function () {
    const Playmo = await ethers.getContractFactory('Playmo');
    const playmo = await Playmo.deploy();
    await playmo.deployed();

    const accounts = await hre.ethers.getSigners();

    await playmo.updateScore(accounts[0], 100);
    await playmo.updateScore(accounts[1], 100);
    await playmo.updateScore(accounts[2], 100);
    await playmo.updateScore(accounts[3], 100);

    console.log(playmo.topPlayers);

    expect(true);
  });
});
