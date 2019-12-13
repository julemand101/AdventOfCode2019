// --- Day 13: Care Package ---
// https://adventofcode.com/2019/day/13

import 'dart:math';
import 'intcode_computer.dart';

enum Tile { empty, wall, block, horizontalPaddle, ball }

int solveA(String input) {
  final screen = <Point<int>, Tile>{};

  final outputList = <int>[];
  for (final output in IntcodeComputer.fromString(input).compute()) {
    outputList.add(output);

    if (outputList.length == 3) {
      final x = outputList[0];
      final y = outputList[1];
      final tile = intToTile(outputList[2]);

      screen[Point(x, y)] = tile;
      outputList.clear();
    }
  }

  return screen.values.where((tile) => tile == Tile.block).length;
}

Tile intToTile(int input) => Tile.values[input];
