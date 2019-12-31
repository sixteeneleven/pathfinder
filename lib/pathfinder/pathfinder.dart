import 'dart:async';
import 'adjacent_nodes.dart';
import 'visualiser.dart';
import '../ui/node_button.dart';


//pathfinder algorithm which finds the shortest amount of steps required to meet
//endpoint q, does not return int but Future<int> so it can be ran as an
//async method in the build function, and return int once future completes.
// adds new events to stream as they occur
Future<int> pathfinder(
    //bool version of maze used for valid adjacent cell calculation
    List<List<bool>> maze,
    //start point p used for navigation
    List<int> startpointP,
    //endpoint q used for navigation
    List<int> endpointQ,
    //streams to push state updates to
    StreamController<String> stringStream,
    StreamController<List<List<NodeButton>>> nodeStream,
    //initialised nodes model to begin with
    List<List<NodeButton>> allNodesModel) async {


  //debug variable to control delay in algorithm processing
  Duration delay = Duration(milliseconds: 200);

  //queue of nodes to progressively check for new steps
  List<List<int>> queue = [];

  //initalise queue with startpoint to begin outwards search
  queue.add([startpointP[0], startpointP[1], 0]);

  //current state of the maze
  List<List<NodeButton>> currentNodesModel = allNodesModel ;

  //for every node in the queue
  for (int qIndex = 0; qIndex < queue.length; qIndex++) {
    //update that node in the model to 'checking' status
    currentNodesModel[queue[qIndex][1]][queue[qIndex][0]] = NodeButton(
      node: queue[qIndex],
      checking: true,
      checked: false,
      wall: false,
    );

    //add event + status to stream with debug delay
    await Future.delayed(delay, () {
      nodeStream.add(currentNodesModel);
      stringStream.add("checking node " + queue[qIndex].toString());
    });

    //if the current queue node matches the objective endpoint node
    if (queue[qIndex][0] == endpointQ[0] &&
        queue[qIndex][1] == endpointQ[1]) {
      //print console notification
      print(queue[qIndex].toString() +
          ' matches objective ' +
          endpointQ.toString());
      //add event + status to stream with delay
      stringStream.add("Shortest amount of steps to " +
         endpointQ.toString() +
          ": " +
          queue[qIndex][2].toString());


      //close the streams + exit loop
      stringStream.close();
      nodeStream.close();
      //set result variable
      return(queue[qIndex][2]);

    }

    //else add status event to stream w delay
    await Future.delayed(delay, () {
      stringStream.add("Checking adjacent cells for valid steps");
    });

    //generate valid adjacent nodes to step to from current queue node
    List<List<int>> validSteps =
    generateAdjacentCells(queue[qIndex], maze);

    //init removal list
    List<List<int>> toRemove = [];

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
            //add them to list of steps to remove from valid steps
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
    //set this node in model to 'checked' status
    currentNodesModel[queue[qIndex][1]][queue[qIndex][0]] = NodeButton(
      node: queue[qIndex],
      checking: false,
      checked: true,
      wall: false,
    );

    //update stream model + status with delay
    await Future.delayed(delay, () {
      stringStream
          .add(validSteps.length.toString() + " valid steps added to queue");
      nodeStream.add(currentNodesModel);
    });
    //console output visual representation
    postvisualise(queue, maze);
  }
  //if not found
  nodeStream.close();
  stringStream.close();
}
