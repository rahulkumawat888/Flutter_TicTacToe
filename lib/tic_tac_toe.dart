import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  final List<String>_board = List.filled(9, '');
  String _currentplayer = 'x';
  String _winner = '';
  bool _isTie = false;
  _play(int index) {
    if(_winner != ''||_board[index]!=''){
      return;
    }
    setState(() {
      _board[index] = _currentplayer;
      _currentplayer = _currentplayer == 'X' ? 'O' : 'X';
      _checkForWinner();
    });
  }
  _checkForWinner(){
    List<List<int>> lines = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6],
    ];
    for(List<int> line in lines){
      String player1 = _board[line[0]];
      String player2 = _board[line[1]];
      String player3 = _board[line[2]];
      if(player1 ==''||player2 ==''||player3 ==''){
        continue;
      }
      if(player1 == player2 && player2 == player3){
        setState(() {
          _winner = player1;
        });
        return;
      }
    }
    if(!_board.contains('')){
      setState(() {
        _isTie = true;
      });
    }
  }
  _resetGame(){
    setState(() {
      _board.fillRange(0, 9,'');
      _currentplayer = 'X';
      _winner = '';
      _isTie = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(color: Colors.black38,blurRadius: 3)],
                    border: Border.all(
                      color: _currentplayer == "X"
                          ? Colors.amber
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(Icons.person,
                          size: 55,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'BOT 1',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "X",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: size.width*0.075,),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,blurRadius: 3),
                    ],
                    border: Border.all(
                      color: _currentplayer =="O"
                          ? Colors.amber
                          : Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(Icons.person,
                        size:55,
                        color:Colors.white,
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'BOT 2',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'O',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height*0.04,),
            // Display winner message
            if(_winner != "")
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _winner,
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'WON!',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            // Display tie messsage
            if(_isTie)
              Text(
                'It\'s a Tie! ',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            // Game board
            Padding(
                padding: EdgeInsets.all(10),
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                  ),
                  itemBuilder: (context,index) {
                  return GestureDetector(
                    onTap: (){
                      _play(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _board[index],
                          style: TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                  },
              ),
            ),
            // Reset button
            if(_winner != "" || _isTie)
              ElevatedButton(
                  onPressed: _resetGame, // Reset the game
                  child: Text('Play Again'),
              ),
          ],
        ),
      ),
    );
  }
}
