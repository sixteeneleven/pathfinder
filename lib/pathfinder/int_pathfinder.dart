import 'adjacent_nodes.dart';
import 'visualiser.dart';

//pathfinder algorithm which finds the shortest amount of steps required to meet
//endpoint q, returns result <int> equal to number of steps required to reach the target
int pathfinder(
    //bool version of maze used for valid adjacent cell calculation
    List<List<bool>> maze,
    //start point p used for navigation
    List<int> startpointP,
    //endpoint q used for navigation
    List<int> endpointQ) {

  //visualise bool map in text-based grid
  //
  // [true, true, true]
  // [true, false, true]
  // [true, true, true]
  //
  // false at x1,y1 or at maze[depth 1][node 1]
  visualise(maze);



  //empty queue of co-ords and their weighting
  List<List<int>> queue = [];

  //add end point to queue
  queue.add([startpointP[0], startpointP[1], 0]);
  // for each node in the queue
  for (int qIndex = 0; qIndex < queue.length; qIndex++) {
    if (queue[qIndex][0] == endpointQ[0] && queue[qIndex][1] == endpointQ[1]) {
      print(queue[qIndex].toString() +
          ' matches objective ' +
          endpointQ.toString());
      visualiseWithQueue(queue, maze);
      return queue[qIndex][2];
    }

    //generate valid adjacent nodes to step to
    List<List<int>> validSteps = generateAdjacentCells(queue[qIndex], maze);
    List<List<int>> toRemove = [];
    // print('valid steps ' + validSteps.toString());

    if (validSteps.isNotEmpty) {
      for (List<int> step in validSteps) {
        //for each node in the queue
        for (List<int> node in queue) {
          if (node[0] == step[0] && node[1] == step[1] && node[2] <= step[2]) {
            print(node.toString() + ' matches ' + step.toString());
            print('removed ' + step.toString());
            toRemove.add(step);
          }
        }
      }
      validSteps.removeWhere((node) => toRemove.contains(node));
      queue.addAll(validSteps);
      visualiseWithQueue(queue, maze);
    } else {
      print("steps empty");
    }
  }

  return null;
}

int solve(List<List<bool>> maze, List<int> startpointP, List<int> endpointQ) {}
