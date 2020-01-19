import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pathfinder/models/maze_model.dart';
import 'package:pathfinder/ui/node_grid.dart';
import 'db/mysql.dart';
import 'db/validate_mazedata.dart';
import 'models/local_maze.dart';

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
  int mazeIndex;
  MazeData localMaze;
  MazeData activeMaze;
  List<MazeData> mazes = [];
  NodeGrid grid;
  bool loadFailure = true;

  @override
  void initState() {
    //init page/maze index
    mazeIndex = 0;
    //init list of mazes with locally made maze
    localMaze = makeLocalMaze(mazeIndex);
    mazes = [localMaze];
    //fetch mazes from mysql then replace list of mazes
    loadMazeDataListFromDB().then((value) {
      if (value != null) {
        mazes = value;
        loadFailure = false;
      } else {
        loadFailure = true;
      }
    });
    //set active maze to maze in list at cyclable index
    activeMaze = mazes[mazeIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            //main grid display with buttons
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NodeGrid(
                      data: activeMaze,
                      newd: true,
                    ))),
            //current maze indicator
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Maze " +
                  (mazeIndex + 1).toString() +
                  " of " +
                  mazes.length.toString()+ " in list."),
            ),
            //row containing back button and next button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //if maze index is not at start,
                  mazeIndex != 0
                      //return button to go back
                      ? RaisedButton(
                          onPressed: () {
                            setState(() {
                              mazeIndex--;
                              activeMaze = mazes[mazeIndex];
                              localMaze.id = mazeIndex.toString();
                            });
                          },
                          child: Text("back"),
                        )
                      //else return disabled button
                      : RaisedButton(
                          onPressed: null,
                          child: Text('back'),
                        ),
                  //if maze index is not at end
                  mazeIndex != mazes.length - 1
                      //return button to go next
                      ? RaisedButton(
                          onPressed: () {
                            setState(() {
                              mazeIndex++;
                              activeMaze = mazes[mazeIndex];
                              localMaze.id = mazeIndex.toString();
                            });
                          },
                          child: Text("next"),
                        )
                      //else return disabled button
                      : RaisedButton(
                          onPressed: null,
                          child: Text('next'),
                        ),
                ],
              ),
            ),

            Container(
              child: !loadFailure
                  ? Column(
                      children: <Widget>[
                        Builder(
                          builder: (context) => Center(
                            child: RaisedButton(
                              onPressed: () {
                                //with scaffold context to pop snackbar feedback
                                insertMaze(context, validate(localMaze));
                              },
                              child: Text("overwrite maze " +
                                  (mazeIndex + 1).toString() +
                                  " with local maze"),
                            ),
                          ),
                        ),
                        Builder(
                          builder: (context) => Center(
                            child: RaisedButton(
                              onPressed: () {
                                var newmaze = localMaze;
                                newmaze.id = mazes.length.toString();
                                //with scaffold context to pop snackbar feedback
                                insertMaze(context, validate(localMaze));

                                setState(() {
                                  loadMazeDataListFromDB().then((value) {
                                    mazes = value;
                                  });
                                });
                              },
                              child: Text("save local maze as maze " +
                                  (mazes.length + 1).toString()),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Text("failure to load from mysql"),
            )
            //buttons to insert local maze to mysql
          ],
        ),
      ),
    );
  }

  //function which produces pop up with result of mysql validation
  //and inserts to mysql if passes
  void insertMaze(BuildContext context, bool validation) {
    final scaffold = Scaffold.of(context);

    if (validation) {
      saveMazeDataToDB(localMaze);
    }
    scaffold.showSnackBar(
      SnackBar(
          content: validation
              ? Text("Inserting to MySQL")
              : Text("Failed validation")),
    );
  }
}
