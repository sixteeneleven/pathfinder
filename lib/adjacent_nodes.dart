//given a 2d map of bool nodes and a single stepped node to check,
//returns a list of adjacent nodes that are valid for traversal
List<List<int>> generateAdjacentCells(List<int> node, List<List<bool>> maze) {

 //list of valid nodes to return
  List<List<int>> adjCells = [];

  //node [x,y,step]
  //maze [y,x,bool]

  //node for x position
  int x = 0;
  //node for y position
  int y = 1;
  //node for amount of steps
  int step = 2;

  //if cell to right (x + 1) is out of bounds
  if (node[x] + 1 >= maze[x].length) {
    print("right edge reached at node x" +
        node[x].toString() +
        "y" +
        node[y].toString());
  } else {
    //if not, check if x + 1 is traversable
    if (maze[node[y]][node[x] + 1]) {
      //if so add to valid cells list with +1 step value
      adjCells.add([node[x] + 1, node[y], node[step] + 1]);
    }
  }

  //check if cell below (y + 1) is out of bounds
  if (node[y] + 1 >= maze.length) {
    print("bottom edge reached at node x" +
        node[x].toString() +
        "y" +
        node[y].toString());
  } else {
    print('check bottom');
    //if not, check if its traversable
    if (maze[node[y] + 1][node[x]]) {
      //if so add to valid cells list with +1 step value
      adjCells.add([node[x], node[y] + 1, node[step] + 1]);
    }
  }

  //check if cell to left (x - 1) is out of bounds
  if (node[x] - 1 < 0) {
    print("left edge reached at node x" +
        node[x].toString() +
        "y" +
        node[y].toString());
  } else {
    //if not, check if its traversable
    if (maze[node[y]][node[x] - 1]) {
      //if so add to valid cells list with +1 step value
      adjCells.add([node[x] - 1, node[y], node[step] + 1]);
    }
  }

  //check if cell above (y-1) is out of bounds
  if (node[y] - 1 < 0) {
    print("top edge reached at node x" +
        node[x].toString() +
        "y" +
        node[y].toString());
  } else {
    //if not, check if its traversable
    if (maze[node[y] - 1][node[x]]) {
      //if so add to valid cells list with +1 step value
      adjCells.add([node[x], node[y] - 1, node[step] + 1]);
    }
  }

  return adjCells;
}
