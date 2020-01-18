import 'dart:convert';
import 'package:mysql1/mysql1.dart';
import 'dart:developer';

import 'package:pathfinder/models/maze_model.dart';

var _dbSettings = new ConnectionSettings(
    host: 'localhost',
    port: 8889,
    user: 'root',
    password: 'root',
    db: 'pathfinder');

void saveMazeDataToDB(MazeData data) async {
  final conn = await MySqlConnection.connect(_dbSettings);

  //encode arrays to json string for storage
  String id = data.id;
  String encodeddata = jsonEncode(data.dataToJSON());

  //query string
  await conn.query(
      'insert into maze (id, data) values (?, ?) on duplicate key update data = values(data)',
      ['$id', '$encodeddata']);

  print('inserted');
  //close connection
  await conn.close();
}

Future<MazeData> loadMazeDataFromDB(String id) async {
  log('querying mysql db');
  //create connection to db
  final conn = await MySqlConnection.connect(_dbSettings);
//query string
  final response = await conn.query("select data from maze where 'id' =  $id");
//close connection to db
  await conn.close();
  //return decoded response
  if (response == null) {
    print("not found");
    return(MazeData(id, [0,0], [0,0], [[false, false],[false,false]]));
  }

  List<MazeData> dlist = [];
  for (var row in response) {
    dlist.add(MazeData.fromJSON(id, jsonDecode(row[0])));
  }

  return dlist[0];
}
