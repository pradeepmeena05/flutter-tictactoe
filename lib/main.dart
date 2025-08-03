import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: TicTacToeMatrix(),
    debugShowCheckedModeBanner: false,
  ));
}

class TicTacToeMatrix extends StatefulWidget {
  const TicTacToeMatrix({super.key});

  @override
  State<TicTacToeMatrix> createState() => _TicTacToeMatrixState();
}

class _TicTacToeMatrixState extends State<TicTacToeMatrix> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));
  bool isXTurn = true;
  String winner = '';
  List<List<bool>> highlight = List.generate(3, (_) => List.filled(3, false));

  void resetGame() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      highlight = List.generate(3, (_) => List.filled(3, false));
      isXTurn = true;
      winner = '';
    });
  }

  void playMove(int i, int j) {
    if (board[i][j] != '' || winner != '') return;

    setState(() {
      board[i][j] = isXTurn ? 'X' : 'O';
      isXTurn = !isXTurn;
      checkWinner();
    });
  }

  void checkWinner() {
    for (int i = 0; i < 3; i++) {
      
      if (board[i][0] != '' &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        winner = board[i][0];
        highlight[i][0] = highlight[i][1] = highlight[i][2] = true;
        return;
      }

      if (board[0][i] != '' &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        winner = board[0][i];
        highlight[0][i] = highlight[1][i] = highlight[2][i] = true;
        return;
      }
    }

    if (board[0][0] != '' &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      winner = board[0][0];
      highlight[0][0] = highlight[1][1] = highlight[2][2] = true;
      return;
    }

    if (board[0][2] != '' &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      winner = board[0][2];
      highlight[0][2] = highlight[1][1] = highlight[2][0] = true;
      return;
    }

    if (board.every((row) => row.every((cell) => cell != ''))) {
      winner = 'Draw';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe (Matrix)"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 70, 115, 199),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         
          for (int i = 0; i < 3; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int j = 0; j < 3; j++)
                  GestureDetector(
                    onTap: () => playMove(i, j),
                    child: Container(
                       width: 90,
                      height: 90,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: highlight[i][j]
                            ? const Color.fromARGB(255, 50, 232, 56)
                            : Colors.grey.shade200,
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          board[i][j],
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: board[i][j] == 'X'
                                ? Colors.blue
                                : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 20),
          Text(
            winner == ''
                ? 'Turn: ${isXTurn ? 'X' : 'O'}'
                : (winner == 'Draw' ? 'Draw!' : 'Winner: $winner'),
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: resetGame,
            child: const Text('Reset Game'),
          ),
        ],
      ),
    );
  }
}
