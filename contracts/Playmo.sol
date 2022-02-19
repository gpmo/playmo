//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Playmo is Ownable{
    uint256 public playCost;
    uint256 public maxTopPlayers;
    uint256 public maxPlays;
    mapping (address => Player) players;
    mapping (uint256 => Player) topPlayers;
    uint256 internal topPlayersCount;

    struct Player {
        uint256 numTrials;
        uint256 equityWeight;
        uint256 highScore;
    }

    function addTopPlayer(address playerAddress) internal view {

    }

    function updateScore(address playerAddress, uint256 score)
        public onlyOwner {

    }
}
