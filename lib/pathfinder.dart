import 'adjacent_nodes.dart';
import 'visualiser.dart';

int pathfinder(
    List<List<bool>> maze, List<int> startpointP, List<int> endpointQ) {
  visualise(maze);
  // [true, true, true]
  // [true, false, true]
  // [true, true, true]
  //
  // false at x1,y1 or at maze[depth 1][node 1]
  int result = (solve(maze, startpointP, endpointQ));

  return result;
}

int solve(List<List<bool>> maze, List<int> startpointP, List<int> endpointQ) {
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
      postvisualise(queue, maze);
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
      postvisualise(queue, maze);
    } else {
      print("steps empty");
    }
  }
}
