//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Playmo is Ownable {
    uint256 public playCost;
    uint256 public maxTopPlayers;
    uint256 public maxPlays;
    mapping(address => Player) public players;
    mapping(uint256 => Player) public topPlayers;
    uint256 internal topPlayersCount;

    // share weights
    mapping(uint256 => uint256) sharesPerRanking;
    uint256 ownerShares;

    struct Player {
        address playerAddress;
        uint256 numTrials;
        uint256 score;
        bool exists;
    }

    constructor() {
        maxTopPlayers = 3;
    }

    function updateScore(address playerAddress, uint256 newScore)
        public
        onlyOwner
    {
        // if newScore is smaller than lowest top score, halt early
        if (newScore < topPlayers[topPlayersCount].score) {
            return;
        }

        // TODO: check if this already exists
        // Get / Create player with new score
        Player memory playerWithNewScore;
        if (players[playerAddress].exists) {
            playerWithNewScore = players[playerAddress];
        } else {
            playerWithNewScore = Player(playerAddress, 0, newScore, true);
            players[playerAddress] = playerWithNewScore;
        }

        if (topPlayersCount == 0) {
            topPlayers[0] = playerWithNewScore;
            topPlayersCount++;
            return;
        }

        console.log("Player with new score");
        logPlayer(playerWithNewScore);
        console.log("*********************");

        // uint256 newPlayersCount = topPlayersCount;
        // update top players array if necessary
        Player memory unswappedPlayer;
        for (uint256 i = 0; i < topPlayersCount; i++) {
            console.log("Current top player - position %s", i);
            logPlayer(topPlayers[i]);
            console.log("Unswapped player");
            logPlayer(unswappedPlayer);
            console.log("============");

            // if playerScore is larger than score for player i
            if (newScore > topPlayers[i].score) {
                // if newScore does not belong to the player i
                if (topPlayers[i].playerAddress != playerAddress) {
                    unswappedPlayer = topPlayers[i];
                    Player memory player;
                    topPlayers[i] = player;
                    if (topPlayersCount < maxTopPlayers) {
                        topPlayersCount++;
                    }
                    // if newScore belongs to the player i
                } else {
                    topPlayers[i].score = newScore;
                    break;
                }
            } else if (unswappedPlayer.exists) {
                Player memory currentPlayer = topPlayers[i];
                topPlayers[i] = unswappedPlayer;
                unswappedPlayer = currentPlayer;
            }
        }
    }

    function logPlayer(Player memory player) internal {
        console.log("Player {address: %s, score: %s, exists: %s}", player.playerAddress, player.score, player.exists);
    }
}
