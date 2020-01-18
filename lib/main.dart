import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pathfinder/models/maze_model.dart';
import 'package:pathfinder/ui/node_grid.dart';
import 'mysql.dart';

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
  @override
  Future<MazeData> futureMaze;

  void initState() {
    //log('result: ' + pathfinder(maze, [1, 0], [2, 3]).toString());

    super.initState();
    futureMaze = loadMazeDataFromDB('0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: futureMaze,
                builder:
                    (BuildContext context, AsyncSnapshot<MazeData> snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return Text("Waiting for Pathfinder to complete");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    );
                  }
                  return snapshot.hasData
                      ? NodeGrid(
                      data: snapshot.data,)
                  //return loading spinner if no events yet
                      : new Text("Failed to load Maze data");
                  },
              ),
            ],
          ),
        ),
        /*
       
         */
      ),
    );
  }
}
