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
