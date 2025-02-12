// --- Day 3: Crossed Wires ---
// https://adventofcode.com/2019/day/3

import 'dart:math';

int solveA(Iterable<String> input) =>
    findIntersections(input).keys.map(manhattanDistance).reduce(min);

int solveB(Iterable<String> input) =>
    findIntersections(input).values.reduce(min);

int manhattanDistance(Point<int> point) => point.x.abs() + point.y.abs();

typedef MoveOperation = Point<int> Function(Point<int> point);

final Map<String, MoveOperation> moveOperationMap = {
  'U': (Point<int> point) => Point(point.x, point.y + 1), // Up
  'D': (Point<int> point) => Point(point.x, point.y - 1), // Down
  'L': (Point<int> point) => Point(point.x - 1, point.y), // Left
  'R': (Point<int> point) => Point(point.x + 1, point.y), //  Right
};

Map<Point<int>, int> findIntersections(Iterable<String> input) {
  final globalPoints = <Point<int>, int>{};
  final intersections = <Point<int>, int>{};

  for (final line in input) {
    final points = <Point<int>, int>{};
    var currentPoint = const Point(0, 0);
    var currentDistance = 0;

    for (final instruction in line.split(',')) {
      final move = moveOperationMap[instruction[0]]!;
      final length = int.parse(instruction.substring(1));

      for (var i = 0; i < length; i++) {
        currentPoint = move(currentPoint);
        currentDistance++;
        if (!points.containsKey(currentPoint)) {
          points[currentPoint] = currentDistance;
        }
      }
    }

    // Find intersections
    for (final point in points.entries) {
      if (!globalPoints.containsKey(point.key)) {
        globalPoints[point.key] = point.value;
      } else {
        intersections[point.key] = globalPoints[point.key]! + point.value;
      }
    }
  }

  return intersections;
}
