

// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/coin.dart';
import '../utils/game_logic.dart';
import 'game_coin_widget.dart';

// ignore: must_be_immutable
class GameBoard extends StatefulWidget {
  GameBoard(
      {super.key, required this.playerTurnKey, required this.gameBoardKey});
  GlobalKey gameBoardKey;
  GlobalKey playerTurnKey;

  @override
  State<GameBoard> createState() => GameBoardState();
}

class GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width - 20,
      width: MediaQuery.of(context).size.width - 20,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: gameState.map((row) {
          return Row(
            children: row.map((coin) {
              return InkWell(
                onTap: () async {
                  if (end == false) {
                    await onPlay(
                        coin: Coin(
                          row: coin['row'] as int,
                          column: coin['column'] as int,
                          selected: false,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        playerTurnKey: widget.playerTurnKey,
                        gameBoardKey: widget.gameBoardKey);

                    Result result = didEnd();
                    //stop the game if the game has ended
                    if (result != Result.play) {
                      setState(() {});
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: (result == Result.draw)
                                ? Colors.white.withOpacity(0.9)
                                : (result == Result.player1)
                                    ? playerOneColor.withOpacity(0.9)
                                    : playerTwoColor.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            content: Text(
                              (result == Result.draw)
                                  ? 'It\'s a tie'
                                  : (result == Result.player1)
                                      ? 'Player 1 wins'
                                      : 'Player 2 wins',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            title: Text(
                              'GAME OVER!',
                              style: GoogleFonts.davidLibre(
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Game Over!',
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        backgroundColor: Colors.black,
                      ),
                    );
                  }
                },
                child: GameCoinWidget(
                  coin: (coin['value'] == 0)
                      ? Coin(
                          row: coin['row'] as int,
                          column: coin['column'] as int,
                          selected: false,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        )
                      : (coin['value'] == 1)
                          ? Coin(
                              row: coin['row'] as int,
                              column: coin['column'] as int,
                              selected: true,
                              color: playerOneColor,
                            )
                          : (coin['value'] == 2)
                              ? Coin(
                                  row: coin['row'] as int,
                                  column: coin['column'] as int,
                                  selected: true,
                                  color: playerTwoColor,
                                )
                              : Coin(
                                  row: coin['row'] as int,
                                  column: coin['column'] as int,
                                  selected: true,
                                  color: Colors.red,
                                ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
