import 'package:flutter/material.dart';
import 'node.dart';

class Maze {
  List<Node> nodes;

  generateMaze(int xsize, int ysize) {
   List<List<Node>> maze = List.generate(xsize, (int index){
      return listGenerator(ysize);
    });
   return maze;
  }

  listGenerator(int ysize) {
    List<Node> column = List.generate(ysize, (int index) {
      return Node.withValue('empty');
    });
    return column;
  }
}
