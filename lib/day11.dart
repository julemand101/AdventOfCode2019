// --- Day 11: Space Police ---
// https://adventofcode.com/2019/day/11

import 'dart:math';
import 'intcode_computer.dart';

const int black = 0;
const int white = 1;

const int left = 0;
const int right = 1;

enum Direction { up, right, down, left }

int solveA(String intcodeProgram) {
  final computer = IntcodeComputer.fromString(intcodeProgram);
  final panels = <Point<int>, int>{};

  var currentPosition = const Point(0, 0);
  var currentDirection = Direction.up;

  final input = <int>[0];
  final outputPair = <int>[];

  for (final out in computer.compute(input: input, removeFromList: false)) {
    outputPair.add(out);

    if (outputPair.length == 2) {
      final color = outputPair[0];
      final leftOrRight = outputPair[1];

      panels[currentPosition] = color;
      currentDirection = changeDirection(leftOrRight, currentDirection);
      currentPosition = move(currentPosition, currentDirection);

      // Change input to color of new position
      input[0] = panels.putIfAbsent(currentPosition, () => 0);
      outputPair.clear();
    }
  }

  return panels.length;
}

Direction changeDirection(int move, Direction currentDirection) {
  if (move != left && move != right) {
    throw Exception('$move is not a valid move!');
  }

  switch (currentDirection) {
    case Direction.up:
      return (move == left) ? Direction.left : Direction.right;
    case Direction.right:
      return (move == left) ? Direction.up : Direction.down;
    case Direction.down:
      return (move == left) ? Direction.right : Direction.left;
    case Direction.left:
      return (move == left) ? Direction.down : Direction.up;
  }

  throw Exception('Should never happen!');
}

Point<int> move(Point<int> currentPosition, Direction direction) {
  switch (direction) {
    case Direction.up:
      return Point(currentPosition.x, currentPosition.y - 1);
    case Direction.right:
      return Point(currentPosition.x + 1, currentPosition.y);
    case Direction.down:
      return Point(currentPosition.x, currentPosition.y + 1);
    case Direction.left:
      return Point(currentPosition.x - 1, currentPosition.y);
  }

  throw Exception('Should never happen!');
}
