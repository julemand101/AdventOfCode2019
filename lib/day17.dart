// --- Day 17: Set and Forget ---
// https://adventofcode.com/2019/day/17

import 'dart:convert';

import 'intcode_computer.dart';

int solveA(String line) {
  final computer = IntcodeComputer.fromString(line);
  final grid = LineSplitter.split(ascii.decode(computer.compute().toList()))
      .toList()
    ..removeLast(); // Remove empty line at the end
  var result = 0;

  for (var y = 1; y < grid.length - 1; y++) {
    for (var x = 1; x < grid[y].length - 1; x++) {
      if (grid[y][x] == '#' &&
          grid[y - 1][x] == '#' &&
          grid[y + 1][x] == '#' &&
          grid[y][x - 1] == '#' &&
          grid[y][x + 1] == '#') {
        result += x * y;
      }
    }
  }

  return result;
}

int solveB(String line) {
  final computer = IntcodeComputer.fromString(line);
  final grid = LineSplitter.split(ascii.decode(computer.compute().toList()))
      .toList()
    ..removeLast(); // Remove empty line at the end
  grid.forEach(print);

  return 0;
}

enum Orientation { up, right, down, left }

Iterable<String> getRoute(List<String> grid) sync* {
  //int x, y;
  Orientation? orientation;

  findXYOfVacuumRobotLoop:
  for (var y = 0; y < grid.length; y++) {
    for (var x = 0; x < grid[y].length; x++) {
      switch (grid[y][x]) {
        case '^':
          orientation = Orientation.up;
          break;
        case 'v':
          orientation = Orientation.down;
          break;
        case '<':
          orientation = Orientation.left;
          break;
        case '>':
          orientation = Orientation.right;
          break;
      }

      if (orientation != null) {
        //x = _x;
        //y = _y;
        break findXYOfVacuumRobotLoop;
      }
    }
  }
}
