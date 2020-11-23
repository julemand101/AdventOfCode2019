// --- Day 13: Care Package ---
// https://adventofcode.com/2019/day/13

import 'dart:math';
import 'intcode_computer.dart';

enum Tile { empty, wall, block, horizontalPaddle, ball }

int solveA(String sourceCode) {
  final screen = <Point<int>, Tile>{};
  final outputList = <int>[];

  for (final output in IntcodeComputer.fromString(sourceCode).compute()) {
    outputList.add(output);

    if (outputList.length == 3) {
      final x = outputList[0];
      final y = outputList[1];
      final tile = Tile.values[outputList[2]];

      screen[Point(x, y)] = tile;
      outputList.clear();
    }
  }

  return screen.values.where((tile) => tile == Tile.block).length;
}

int solveB(String sourceCode) {
  var score = 0;
  int? paddleXPosition;
  final output = <int>[];
  final input = <int>[0];
  final computer = IntcodeComputer.fromString(sourceCode);
  computer.memory[0] = 2; // set it to 2 to play for free

  for (final out in computer.compute(input: input, removeFromList: false)) {
    output.add(out);

    if (output.length == 3) {
      final x = output[0];
      final y = output[1];

      if (x == -1 && y == 0) {
        score = output[2];
      } else {
        final tile = Tile.values[output[2]];

        if (tile == Tile.horizontalPaddle) {
          paddleXPosition = x;
        }

        if (tile == Tile.ball && paddleXPosition != null) {
          if (x > paddleXPosition) {
            input[0] = 1;
          } else if (x < paddleXPosition) {
            input[0] = -1;
          } else {
            input[0] = 0;
          }
        }
      }

      output.clear();
    }
  }

  return score;
}
