pragma solidity ^0.4.18;
import "github.com/Arachnid/solidity-stringutils/strings.sol";
contract TicTacToe {
    using strings for *;
  struct Game {
    uint8[9] board;
    address player1;
    address player2;
    uint8 turn; // 1 = first player turn, 2 = second player turn
  }
  mapping(uint64 => Game) _games;
  mapping(address => Game[]) _playerToGame;
  uint64 gameId = 0;
  function newGame(address _player2) public returns (uint64){
    uint8[9] memory board = [0,0,0,0,0,0,0,0,0];
    Game memory g = Game(board, msg.sender, _player2, 0);

    _games[gameId++] = g;
    return gameId;
  }

  function printStatus(Game g) internal returns (string) {
    string res;
    for(uint8 i = 0; i < 9; i++) {
        uint8 elem = g.board[i];
        if(elem == 0) {
            res.toSlice().concat(" |".toSlice());
        } else if(elem == 1) {
            res.toSlice().concat("X|".toSlice());
        } else {
            res.toSlice().concat("O|".toSlice());
        }
        if(i % 3 == 0) {
            res.toSlice().concat("\n".toSlice());
        }
    }
    return res;
  }

  function nextMove(uint64 id, uint8 move) public returns (string) {
      Game memory g = _games[id];
      // Sanity checks
      if(g.turn != 1 && msg.sender == g.player1) {
          // error
      }
      if(g.turn != 2  && msg.sender == g.player2) {
          // error
      }
      // Only play on an empty cell
      require(g.board[move] == 0);
      g.board[move] = g.turn;
      // check for victory;
      return printStatus(g);
  }

}
