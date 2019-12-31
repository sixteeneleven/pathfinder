//given a 2d map of bool nodes and a single stepped node to check,
//returns a list of adjacent nodes that are valid for traversal
List<List<int>> generateAdjacentCells(List<int> node, List<List<bool>> maze) {
  print('');
  print('checking ' + node.toString());
  //list of valid nodes to return
  List<List<int>> adjCells = [];

  //node [x,y,step]
  //maze [y,x,bool]

  //node for x position
  int x = 0;
  int y = 1;
  int step = 2;

  //if cell to right (x + 1) is out of row bounds
  if (node[x] + 1 >= maze[x].length) {
    //print("r oob");
  } else {
    //if not, check if x + 1 is traversable
    if (!maze[node[y]][(node[x]) + 1]) {
      //if so add to valid cells list with +1 step value
      //  print('r wall');
    } else {
      //  print('r ok');
      adjCells.add([node[x] + 1, node[y], node[step] + 1]);
    }
  }

  //if cell below (y + 1) is out of depth bounds
  if ((node[y]) + 1 >= maze.length) {
    print("d oob");
  } else {
    //if not, check if y + 1 is traversable
    if (!maze[(node[y] + 1)][node[x]]) {
      //if so add to valid cells list with +1 step value
      // print('d wall');
    } else {
      //  print('d ok');
      adjCells.add([node[x], node[y] + 1, node[step] + 1]);
    }
  }

  //if cell to left (x - 1) is out of row bounds
  if (node[x] - 1 < 0) {
    //  print("l oob");
  } else {
    //if not, check if x - 1 is traversable
    //  print('l =' + maze[node[y]][(node[x]) - 1].toString());

    if (!maze[node[y]][(node[x]) - 1]) {
      //if so add to valid cells list with +1 step value
      // print('l wall');
    } else {
      //  print('l ok');
      adjCells.add([node[x] - 1, node[y], node[step] + 1]);
    }
  }

  //if cell above (y - 1) is out of row bounds
  if (node[y] - 1 < 0) {
    //  print("u ob");
  } else {
    //if not, check if y - 1 is traversable
    // print('u =' + maze[(node[y]) - 1][node[x]].toString());
    if (!maze[(node[y]) - 1][node[x]]) {
      //if so add to valid cells list with +1 step value
      // print('u wall');
    } else {
      //   print('u ok');
      adjCells.add([node[x], node[y] - 1, node[step] + 1]);
    }
  }
  print('valid steps for ' + node.toString() + ':');
  print(' -> ' + adjCells.toString());
  print('');
  return adjCells;
}
