import 'package:pathfinder/models/maze_model.dart';

//maze to upload to mysql
MazeData makeLocalMaze(int id) {
  return MazeData(id.toString(), [
    1,
    0
  ], [
    2,
    3
  ], [
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
  ]);
}
