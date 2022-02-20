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
        uint256 shares;
        uint256 highScore;
    }

    function addTopPlayer(address playerAddress) internal view {

    }

    function updateScore(address playerAddress, uint256 score, uint256 numTrials)
        public onlyOwner {
            uint256 currRanking = -1;
            for (uint256 i = topPlayersCount - 1; i >= 0 ; i--) {
                if (score < topPlayers[i].highScore) {
                    break;
                }else if (score > topPlayers[i].highScore){
                    currRanking = i;
                }
            }

            if (currRanking < 0) { return; }

            uint256 shares = (maxTopPlayers*10) - 10 * currRanking;
            topPlayers[currRanking] = Player(numTrials, shares, score);
    }
}
