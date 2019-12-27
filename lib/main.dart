import 'package:flutter/material.dart';
import 'maze.dart';
import 'node.dart';

void main() => runApp(RootOfMyApp());

class RootOfMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pathfinder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // List/array of a list of nodes
  List<List<Node>> maze;

  @override
  void initState() {

    maze = Maze().generateMaze(3, 3);
    for (int i = 0; i < maze.length; i++) {
      for (int j = 0; j < maze[i].length; j++) {
        print(i.toString() +
            "-" +
            j.toString() +
            ": " +
            maze[i][j].getNodeValue().toString());
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //debug
            FlatButton(
              child: Text("?"),
              onPressed: () {
                print(maze[2][2].getNodeValue());
              },
            ),

          ],
        ),
      ),
    );
  }
}
