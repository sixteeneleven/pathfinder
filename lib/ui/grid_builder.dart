import 'package:flutter/material.dart';
import 'node_button.dart';

NodeMapGrid(List<List<NodeButton>> map) {
  List<Row> rowsToBuildWith = [];
  for (int y = 0; y < map.length; y++) {

    List<NodeButton> row = [];
    //for each node until end of that row (x0-x^n)
    for (int x = 0; x < map[y].length; x++) {
      row.add(map[y][x]);
    }

    rowsToBuildWith.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[...row],
    ));
  }
  return Container(
    child: Column(
      children: <Widget>[...rowsToBuildWith],
    ),
  );
}