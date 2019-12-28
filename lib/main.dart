import 'package:flutter/material.dart';
import 'pathfinder.dart';
import 'dart:developer';

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
  void initState() {
    var boolMaze = [
      //y0
      [true, true, true, true, true], //x5
      //y1
      [true, false, false, false, true],
      //y2
      [true, true, true, true, true],
      //y3
      [true, true, true, true, true],
      //y4
      [true, true, true, true, true],
    ];

    print('maze');
    //for each row depth level  (y0-y^n)
    for (int y = 0; y < boolMaze.length; y++) {
      //for each node until end of that row (x0-x^n)
      String row = '';

      for (int x = 0; x < boolMaze[y].length; x++) {
        //if the node at that depth in the maze is true
        if (boolMaze[y][x]) {
          //print x(n)-y(n) true
          //print("x" + node.toString() + "-" + "y" + depth.toString() + " true");
          row = row + ". ";
        } else {
          //else print x(n)-y(n) false
          //print("x" + node.toString() + "-" + "y" + depth.toString() + " false");
          row = row + "# ";
        }
      }
      print(row);
    }

    log('result: ' + pathfinder(boolMaze).toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[],
        ));
  }
}
