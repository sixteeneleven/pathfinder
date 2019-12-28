import 'package:flutter/material.dart';
import 'package:pathfinder/visualiser.dart';
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

    visualise(boolMaze);
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
