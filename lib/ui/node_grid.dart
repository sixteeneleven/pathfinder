import 'dart:async';
import 'package:pathfinder/models/maze_model.dart';
import 'grid_builder.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/models/node_button.dart';
import '../pathfinder/future_stream_pathfinder.dart';
import 'package:pathfinder/db/mysql.dart';

//widget that produces a visual representation of maze to solve, and shows how
//the sorting algorithm processes the maze. includes a RaisedButton to start the
// pathfinder and a status string which changes to reflect the current state
// of the algorithm
class NodeGrid extends StatefulWidget {
  NodeGrid({Key key, @required this.data, this.newd}) : super(key: key);

  MazeData data;
  bool newd;

  _NodeGridState createState() => _NodeGridState();
}

class _NodeGridState extends State<NodeGrid> {
  //current state of the maze
  List<List<NodeButton>> _allNodesModel = [];

  //whether or not pathfinder has completed for disabling button
  bool _completed;

  Future<int> _result;

  //controller for stream of node model updates
  StreamController<List<List<NodeButton>>> _nodeStream = new StreamController();

  //controller for stream of status string updates
  StreamController<String> _stringStream = new StreamController();

  @override
  void initState() {
    _completed = false;
    //initialise the status string with the startpoint and endpoint that is trying to be reached
    _stringStream.add("P " +
        widget.data.startpointP.toString() +
        " -> Q " +
        widget.data.endpointQ.toString());
    _allNodesModel = boolMazeToNodes();
    //add new event update to stream of current node state
    _nodeStream.add(_allNodesModel);

    super.initState();
  }

  //build method runs every frame with UI instructions
  @override
  Widget build(BuildContext context) {
    print("rebuild");

    return Center(
      child: Column(
        children: <Widget>[
          //if there is a stream event, rebuild produce a NodeMapGrid with latest event
          //using nodestream for data
          StreamBuilder<List<List<NodeButton>>>(
            stream: _nodeStream.stream, // a Stream<int> or null
            builder: (BuildContext context,
                AsyncSnapshot<List<List<NodeButton>>> snapshot) {
              return snapshot.hasData
                  ? NodeMapGrid(snapshot.data)

                  //return loading spinner if no events yet
                  : new CircularProgressIndicator();
            },
          ),
          //button which starts pathfinder function on press
          !_completed
              ? RaisedButton(
                  child: Text("Pathfinder"),
                  onPressed: () async {
                    print("press");
                    setState(() {
                      _result = pathfinder(widget.data, _stringStream,
                          _nodeStream, _allNodesModel);
                      _completed = true;
                    });
                  },
                )
              : RaisedButton(
                  child: Text("Pathfinder"),
                  onPressed: null,
                ),

          //if there is a stream event, rebuild produce a large Text widget with latest event
          //using string status stream for data
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<String>(
              stream: _stringStream.stream, // a Stream<int> or null
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return snapshot.hasData
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data,
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    //return loading spinner if no events yet
                    : new CircularProgressIndicator();
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: FutureBuilder(
              future: _result,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
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
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Result: " + snapshot.data.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    //return loading spinner if no events yet
                    : new Icon(Icons.error);
              },
            ),
          ),
          RaisedButton(
            child: Text("load maze from list"),
            onPressed: () {
              setState(() {
                _completed = false;
              });
              _stringStream.add("P " +
                  widget.data.startpointP.toString() +
                  " -> Q " +
                  widget.data.endpointQ.toString());
              _allNodesModel = boolMazeToNodes();
              _nodeStream.add(_allNodesModel);
            },
          ),
        ],
      ),
    );
  }

  List<List<NodeButton>> boolMazeToNodes() {
    print("oop");
    List<List<NodeButton>> model = [];
    //for each tier of boolean maze
    for (int y = 0; y < widget.data.maze.length; y++) {
      List<NodeButton> rowModel = [];
      //go through each node of that tier
      for (int x = 0; x < widget.data.maze[y].length; x++) {
        //if it is a wall add generic wall node
        if (!widget.data.maze[y][x]) {
          rowModel.add(NodeButton(
            node: [x, y, 0],
            wall: true,
          ));
        } else {
          //else add generic non-wall node
          rowModel.add(NodeButton(
            node: [x, y, 0],
            wall: false,
          ));
        }
      }
      //add the completed row to model of all nodes
      model.add(rowModel);
    }
    return model;
  }
}
