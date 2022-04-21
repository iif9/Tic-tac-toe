import 'package:flutter/material.dart';
import 'package:tikantik/screen/game_logic.dart';

class HomeSc extends StatefulWidget {
  const HomeSc({Key? key}) : super(key: key);

  @override
  State<HomeSc> createState() => _HomeScState();
}

class _HomeScState extends State<HomeSc> {
  String activePlayer = 'X';
  bool gameOver = false;
  String result = '';
  Game game = Game();
  bool isSwitched = false;
  int turn = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
              title: const Text(
                "Turn on/off Two Player",
                style: TextStyle(color: Colors.white, fontSize: 28),
                textAlign: TextAlign.center,
              ),
              value: isSwitched,
              onChanged: (bool newValue) {
                setState(() {
                  isSwitched = newValue;
                });
              },
            ),
            Text(
              "it's $activePlayer turn".toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 52),
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: GridView.count(
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.0,
              crossAxisCount: 3,
              children: List.generate(
                  9,
                  (index) => InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: gameOver ? null : () => _noTap(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).shadowColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              Play.playerX.contains(index)
                                  ? " X "
                                  : Play.playerO.contains(index)
                                      ? 'O'
                                      : '',
                              style: TextStyle(
                                  color: Play.playerX.contains(index)
                                      ? Colors.blue
                                      : Colors.redAccent,
                                  fontSize: 52),
                            ),
                          ),
                        ),
                      )),
            )),
            Text(
              result,
              style: TextStyle(color: Colors.white, fontSize: 52),
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  Play.playerX = [];
                  Play.playerO = [];
                  activePlayer = 'X';
                  gameOver = false;
                  result = '';
                  game = Game();
                  isSwitched = false;
                });
              },
              icon: const Icon(Icons.repeat),
              label: const Text("Repeat The Game"),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).splashColor)),
            )
          ],
        ),
      ),
    );
  }

// This is fun On Click
  _noTap(int index) async {
    if ((Play.playerX.isEmpty ||
        !Play.playerX.contains(index) &&
            (Play.playerO.isEmpty || !Play.playerO.contains(index)))) {
      game.playGame(index, activePlayer);
      UpdeteSteat();
      if (!isSwitched && !gameOver) {
        await game.autoPlay(activePlayer);
        UpdeteSteat();
      }
    }
  }

// This is Fun Update For Play
  void UpdeteSteat() {
    setState(() {
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;
      String winnerPlay = game.checkWinner();
      if (winnerPlay != null) {
        gameOver = true;
        result = "$winnerPlay is the Winner";
      } else if (!gameOver && turn == 9) {
        result = " It's Draw";
      }
    });
  }
}
