import 'dart:async';
import 'grid_builder.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/node_button.dart';
import 'adjacent_nodes.dart';
import 'visualiser.dart';

class NodeGrid extends StatefulWidget {
  const NodeGrid({Key key, this.maze, this.startpointP, this.endpointQ})
      : super(key: key);

  final List<List<bool>> maze;
  final List<int> startpointP;
  final List<int> endpointQ;

  _NodeGridState createState() => _NodeGridState();
}

class _NodeGridState extends State<NodeGrid> {
  //
  List<List<int>> queue = [];
  int result = 0;
  List<List<NodeButton>> allNodesModel = [];
  String status;
  Duration delay = Duration(milliseconds: 200);

  StreamController<List<List<NodeButton>>> nodeStream = new StreamController();

  StreamController<String> stringStream = new StreamController();

  @override
  void initState() {
    queue.add([widget.startpointP[0], widget.startpointP[1], 0]);
    stringStream.add("P " +
        widget.startpointP.toString() +
        " -> Q " +
        widget.endpointQ.toString());
    //for each tier of maze
    for (int y = 0; y < widget.maze.length; y++) {
      List<NodeButton> rowModel = [];
      //go through each node of that tier
      for (int x = 0; x < widget.maze[y].length; x++) {
        //if it is a wall add wall node
        if (!widget.maze[y][x]) {
          rowModel.add(NodeButton(
            node: [x, y, 0],
            wall: true,
          ));
        } else {
          //else add node
          rowModel.add(NodeButton(
            node: [x, y, 0],
            wall: false,
          ));
        }
      }
      allNodesModel.add(rowModel);
    }
    nodeStream.add(allNodesModel);
    super.initState();
  }

  void pathfinder() async {
    for (int qIndex = 0; qIndex < queue.length; qIndex++) {
      allNodesModel[queue[qIndex][1]][queue[qIndex][0]] = NodeButton(
        node: queue[qIndex],
        checking: true,
        checked: false,
        wall: false,
      );

      await Future.delayed(delay, () {
        nodeStream.add(allNodesModel);
        stringStream.add("checking node " + queue[qIndex].toString());
      });

      if (queue[qIndex][0] == widget.endpointQ[0] &&
          queue[qIndex][1] == widget.endpointQ[1]) {
        print(queue[qIndex].toString() +
            ' matches objective ' +
            widget.endpointQ.toString());
        stringStream.add("Shortest amount of steps to " +
            widget.endpointQ.toString() +
            ": " +
            queue[qIndex][2].toString());
        setState(() {
          result = (queue[qIndex][2]);
        });
        stringStream.close();
        nodeStream.close();
        break;
      }

      await Future.delayed(delay, () {
        nodeStream.add(allNodesModel);
        stringStream.add("Checking adjacent cells for valid steps");
      });

      //generate valid adjacent nodes to step to
      List<List<int>> validSteps =
          generateAdjacentCells(queue[qIndex], widget.maze);
      List<List<int>> toRemove = [];
      // print('valid steps ' + validSteps.toString());

      //if there are valid steps, see if any have been stepped on in queue
      //and prep for removal
      if (validSteps.isNotEmpty) {
        for (List<int> step in validSteps) {
          //for each node in the queue
          for (List<int> node in queue) {
            if (node[0] == step[0] &&
                node[1] == step[1] &&
                node[2] <= step[2]) {
              print(node.toString() + ' matches ' + step.toString());
              print('removed ' + step.toString());
              toRemove.add(step);
            }
          }
        }

        //remove any visited steps
        validSteps.removeWhere((node) => toRemove.contains(node));
        //add unstepped steps to queue

        queue.addAll(validSteps);
      } else {
        print("steps empty");
      }
      allNodesModel[queue[qIndex][1]][queue[qIndex][0]] = NodeButton(
        node: queue[qIndex],
        checking: false,
        checked: true,
        wall: false,
      );
      await Future.delayed(delay, () {
        stringStream
            .add(validSteps.length.toString() + " valid steps added to queue");
        nodeStream.add(allNodesModel);
      });

      postvisualise(queue, widget.maze);
    }
    //if not found
    nodeStream.close();
    stringStream.close();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");

    return Center(
      child: Column(
        children: <Widget>[
          StreamBuilder<List<List<NodeButton>>>(
            stream: nodeStream.stream, // a Stream<int> or null
            builder: (BuildContext context,
                AsyncSnapshot<List<List<NodeButton>>> snapshot) {
              return snapshot.hasData
                  ? NodeMapGrid(snapshot.data)

                  ///build your widget tree

                  : new CircularProgressIndicator();
              // unreachable
            },
          ),
          RaisedButton(
            child: Text("Pathfinder"),
            onPressed: () async {
              print("press");
              pathfinder();
            },
          ),
          StreamBuilder<String>(
            stream: stringStream.stream, // a Stream<int> or null
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return snapshot.hasData
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snapshot.data, style: TextStyle(fontSize: 20),),
                    )

                  ///build your widget tree

                  : new CircularProgressIndicator();
              // unreachable
            },
          ),
        ],
      ),
    );
  }
}
