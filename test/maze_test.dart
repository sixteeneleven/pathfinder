import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:pathfinder/pathfinder/int_pathfinder.dart';

void main() {
  test('six steps', () {
    final sixMaze = [
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
    ];

    final twelveMaze = [
      //y0
      [true, true, true, true, true], //x5
      //y1
      [true, false, false, false, false],
      //y2
      [true, false, false, false, false],
      //y3
      [true, false, false, false, false],
      //y4
      [true, true, true, true, true],
    ];

    expect(pathfinder(sixMaze, [1, 0], [2, 3]), 6);
  });

  test('large size', () {
    final twelveMaze = [
      [
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
      ],
      [
      true,
      false,
      false,
      false,
      false,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
    ]
    ,
    [
    true,
    false,
    false,
    false,
    false,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    ],
    [
    true,
    false,
    false,
    false,
    false,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    ],
    [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    ],
    ];
    expect(pathfinder(twelveMaze, [4, 4], [10, 10]), 12);
  });

  test('branching path', () {
    final karaMaze = [
      //y0
      [false, false, true, false, false], //x5
      //y1
      [false, true, true, true, false],
      //y2
      [false, true, false, true, false],
      //y3
      [false, true, true, true, false],
      //y4
      [false, false, true, false, false],
    ];
    expect(pathfinder(karaMaze, [2, 0], [2, 4]), 6);
  });

  test('null', () {
    final nullMaze = [
      //y0
      [false, false, false, false, false], //x5
      //y1
      [false, false, false, false, false],
      //y2
      [false, false, false, false, false],
      //y3
      [false, false, false, false, false],
      //y4
      [false, false, false, false, false],
    ];
    expect(pathfinder(nullMaze, [2, 0], [2, 4]), null);
  });
  test('bad data', () {
    final baddata = [
      //y0
      [false, false, false, false, false], //x5
      //y1
      [false, 'hello', false, false, false],
      //y2
      [false, false, false, false, false],
      //y3
      [false, false, false, 'whoops', false],
      //y4
      ['uh', false, false, false, false],
    ];
    expect(pathfinder(baddata, [2, 0], [3, 4]), TestFailure);
  });
}
