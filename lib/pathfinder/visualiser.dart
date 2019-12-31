visualise(List<List<bool>> maze) {
  print('maze');
  //for each row depth level  (y0-y^n)
  for (int y = 0; y < maze.length; y++) {
    //for each node until end of that row (x0-x^n)
    String row = '';

    for (int x = 0; x < maze[y].length; x++) {
      //if the node at that depth in the maze is true
      if (maze[y][x]) {
        //print x(n)-y(n) true
        //print("x" + node.toString() + "-" + "y" + depth.toString() + " true");
        row = row + ". ";
      } else {
        //else print x(n)-y(n) false
        //print("x" + node.toString() + "-" + "y" + depth.toString() + " false");
        row = row + "# ";
      }
    }
    print(row);
  }
}

postvisualise(List<List<int>> queue, List<List<bool>> maze) {
  print('');
  //for each row depth level  (y0-y^n)
  for (int y = 0; y < maze.length; y++) {
    //for each node until end of that row (x0-x^n)
    String row = '';
    bool found = false;

    for (int x = 0; x < maze[y].length; x++) {
      //if the node at that depth in the maze is true
      if (maze[y][x]) {
        //print x(n)-y(n) true
        //print("x" + node.toString() + "-" + "y" + depth.toString() + " true");
        found = false;
        for (List<int> node in queue) {
          if (node[1] == y && node[0] == x) {
            row = row + node[2].toString() + " ";
            found = true;
          }
        }
        if (!found) {
          row = row + ". ";
        }
      } else {
        //else print x(n)-y(n) false
        //print("x" + node.toString() + "-" + "y" + depth.toString() + " false");
        row = row + "# ";
      }
    }
    print(row);
  }
}
