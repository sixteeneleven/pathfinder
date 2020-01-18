class MazeData {
  String id;
  List<int> startpointP;
  List<int> endpointQ;
  List<List<bool>> maze;

  MazeData(this.id, this.startpointP, this.endpointQ, this.maze);

  MazeData.fromJSON(String id, Map<String, dynamic> data) {

    //builds new list<int> by iterating through list<dynamic>
    id = id;
    startpointP = List.from(data['startpointp']);
    endpointQ = List.from(data['endpointq']);
    maze = _parseMaze(data['boolmaze']);
  }

  Map dataToJSON() =>
      {"startpointp": startpointP, "endpointq": endpointQ, "boolmaze": maze};

  //parses List<dynamic> JSON response into usable 2d array of bool
  List<List<bool>> _parseMaze(List<dynamic> data) {
    List<List<bool>> fullmaze = new List<List<bool>>(data.length);
    for (int i = 0; i < fullmaze.length; i++) {
      List<bool> mazerow = List.from(data[i]);
      fullmaze[i] = mazerow;
    }
    return fullmaze;
  }
}
