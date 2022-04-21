import 'dart:math';

class Play {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension CotainsAll on List {
  bool containsAll(int x, int y, [z]) {
    if (z == Null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}

class Game {
  void playGame(int index, String activePlayer) {
    if (activePlayer == 'X') {
      Play.playerX.add(index);
    } else {
      Play.playerO.add(index);
    }
  }

  String checkWinner() {
    String winner = "";
    if (Play.playerX.containsAll(0, 1, 2) ||
        Play.playerX.containsAll(3, 4, 5) ||
        Play.playerX.containsAll(6, 7, 8) ||
        Play.playerX.containsAll(0, 3, 6) ||
        Play.playerX.containsAll(1, 4, 7) ||
        Play.playerX.containsAll(2, 5, 8) ||
        Play.playerX.containsAll(0, 4, 8) ||
        Play.playerX.containsAll(2, 4, 6))
      winner = " X ";
    else if (Play.playerO.containsAll(0, 1, 2) ||
        Play.playerO.containsAll(3, 4, 5) ||
        Play.playerO.containsAll(6, 7, 8) ||
        Play.playerO.containsAll(0, 3, 6) ||
        Play.playerO.containsAll(1, 4, 7) ||
        Play.playerO.containsAll(2, 5, 8) ||
        Play.playerO.containsAll(0, 4, 8) ||
        Play.playerO.containsAll(2, 4, 6))
      winner = " O ";
    else
      winner = "";
    return winner;
  }

  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptycells = [];
    for (var i = 0; i < 9; i++) {
      if (!(Play.playerX.contains(i)) || Play.playerO.contains(i))
        emptycells.add(i);
    }
    Random random = Random();
    int rendoIndex = random.nextInt(emptycells.length);
    index = emptycells[rendoIndex];
    playGame(index, activePlayer);
  }
}
