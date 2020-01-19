import 'package:pathfinder/models/maze_model.dart';

validate(MazeData data) {
  //check to see if id does not exist or longer than is valid for mysql length
  if (data.id == null || data.id == "" || data.id.length > 6) {
    return false;
  }

  //check to see if p does not exist, is not the correct type, or contains no values
  else if (data.maze == null ||
      !(data.maze is List<List<bool>>) ||
      data.maze.length < 0 ||
      data.maze[0].length < 0) {
    return false;
  }

  //check to see if p does not exist,  or either coord does not exist
  else if (data.startpointP == null ||
      //or longer than valid length (x,y)
      data.startpointP.length != 2 ||
      //if single coord is null
      (data.startpointP[0] == null || data.startpointP[1] == null) ||
      //if points are outside bounds
      (data.startpointP[0] < 0 || data.startpointP[0] > data.maze[0].length) ||
      (data.startpointP[1] < 0 || data.startpointP[0] > data.maze.length) ||
      //if point is a wall
      (data.maze[data.startpointP[1]][data.startpointP[0]] == false)) {
    return false;
  }
  //check to see if q does not exist, or longer than valid (x,y) or either coord does not exist
  else if (data.endpointQ == null ||
      //or longer than valid length (x,y)
      data.endpointQ.length > 2 ||
      //if single coord is null
      (data.endpointQ[0] == null || data.endpointQ[1] == null) ||
      //if points are outside bounds
      (data.endpointQ[0] < 0 || data.endpointQ[0] > data.maze[0].length) ||
      (data.endpointQ[1] < 0 || data.endpointQ[0] > data.maze.length) ||
      //if point is a wall
      (data.maze[data.endpointQ[1]][data.endpointQ[0]] == false)) {
    return false;
  } else
    return true;
}
