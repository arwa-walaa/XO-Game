import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'X & O '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<List> matrix;

  _MyHomePageState() {
    matrix = [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' ']
    ];
  }

  filedContainer(int row, int col) {
    setState(() {
      if (matrix[row][col] == ' ') {
        if (LastChar == 'O') {
          matrix[row][col] = 'X';
        } else {
          matrix[row][col] = 'O';
        }
        LastChar = matrix[row][col];
      }
    });
  }

  checkDraw() {
    bool draw = true;
    matrix.forEach((i) {
      i.forEach((j) {
        if (j == ' ') {
          draw = false;
        }
      });
    });
    return draw;
  }

  checkWinner(int r, int c) {
    int Row = 0, Col = 0, diag = 0, rdiag = 0;
    int n = matrix.length - 1;
    var player = matrix[r][c];
    for (var i = 0; i < matrix.length; i++) {
      if (matrix[r][i] == player) Col++;
      if (matrix[i][c] == player) Row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - 1] == player) rdiag++;
    }
    if (Row == n + 1 || Col == n + 1 || diag == n + 1 || rdiag == n + 1) {
      return true;
    } else {
      return false;
    }
  }

  winnerDialog(String player) {
    String DialogText;
    if (player != 'null') {
      DialogText = 'Player $player Won';
    } else {
      DialogText = 'IT IS DRAW';
    }
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('GAME OVER'),
        content: Text(DialogText),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                emptyMatrix();
              },
              child: Text('Restart'))
        ],
      ),
    );
  }

  emptyMatrix() {
    setState(() {
      matrix = [
        [' ', ' ', ' '],
        [' ', ' ', ' '],
        [' ', ' ', ' ']
      ];
    });
  }

  String LastChar = 'O';
  buildContainer(int row, int col) {
    return GestureDetector(
        onTap: () {
          filedContainer(row, col);
          var isWinner = checkWinner(row, col);
          if (isWinner) {
            winnerDialog(matrix[row][col]);
          } else {
            if (checkDraw()) {
              winnerDialog('null');
            }
          }
        },
        child: Container(
            width: 150.0,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black)),
            child: Center(
                child: Text(matrix[row][col],
                    style: TextStyle(
                        fontSize: 150.0,
                        color: Color.fromARGB(255, 2, 43, 77))))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 2, 43, 77),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(color: Color.fromARGB(255, 219, 182, 71)),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                buildContainer(0, 0),
                buildContainer(0, 1),
                buildContainer(0, 2)
              ]),
              Row(mainAxisSize: MainAxisSize.min, children: [
                buildContainer(1, 0),
                buildContainer(1, 1),
                buildContainer(1, 2)
              ]),
              Row(mainAxisSize: MainAxisSize.min, children: [
                buildContainer(2, 0),
                buildContainer(2, 1),
                buildContainer(2, 2)
              ])
            ],
          ),
        ));
  }
}
