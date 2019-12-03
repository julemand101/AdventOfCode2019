// --- Day 3: Crossed Wires ---
// https://adventofcode.com/2019/day/3

import 'dart:math';

const direction_up = 'U';
const direction_down = 'D';
const direction_left = 'L';
const direction_right = 'R';

int solveA(List<String> input) {
  var manhattanDistanceOfClosestIntersection = 0;

  for (final intersection in findIntersections(input).keys) {
    final manhattanDistance = intersection.manhattanDistanceFromZero();

    if (manhattanDistanceOfClosestIntersection == 0 ||
        manhattanDistance < manhattanDistanceOfClosestIntersection) {
      manhattanDistanceOfClosestIntersection = manhattanDistance;
    }
  }

  return manhattanDistanceOfClosestIntersection;
}

int solveB(List<String> input) => findIntersections(input).values.reduce(min);

Map<Point<int>, int> findIntersections(List<String> input) {
  final globalPoints = <Point<int>, int>{};
  final intersections = <Point<int>, int>{};

  for (final line in input) {
    final points = <Point<int>, int>{};
    var currentPoint = const Point(0, 0);
    var currentDistance = 0;

    for (final instruction in line.split(',')) {
      final direction = instruction[0];
      final length = int.parse(instruction.substring(1));

      if (direction == direction_up) {
        for (var i = 0; i < length; i++) {
          currentPoint = currentPoint.moveUp();
          currentDistance++;
          if (!points.containsKey(currentPoint)) {
            points[currentPoint] = currentDistance;
          }
        }
      } else if (direction == direction_down) {
        for (var i = 0; i < length; i++) {
          currentPoint = currentPoint.moveDown();
          currentDistance++;
          if (!points.containsKey(currentPoint)) {
            points[currentPoint] = currentDistance;
          }
        }
      } else if (direction == direction_left) {
        for (var i = 0; i < length; i++) {
          currentPoint = currentPoint.moveLeft();
          currentDistance++;
          if (!points.containsKey(currentPoint)) {
            points[currentPoint] = currentDistance;
          }
        }
      } else if (direction == direction_right) {
        for (var i = 0; i < length; i++) {
          currentPoint = currentPoint.moveRight();
          currentDistance++;
          if (!points.containsKey(currentPoint)) {
            points[currentPoint] = currentDistance;
          }
        }
      } else {
        throw Exception('Unsupported direction: $direction');
      }
    }

    // Find intersections
    for (final point in points.entries) {
      if (!globalPoints.containsKey(point.key)) {
        globalPoints[point.key] = point.value;
      } else {
        intersections[point.key] = globalPoints[point.key] + point.value;
      }
    }
  }

  print(intersections.values);

  return intersections;
}

extension PointExtension on Point<int> {
  int manhattanDistanceFromZero() => this.x.abs() + this.y.abs();

  Point<int> moveUp() => Point(this.x, this.y + 1);
  Point<int> moveDown() => Point(this.x, this.y - 1);
  Point<int> moveLeft() => Point(this.x - 1, this.y);
  Point<int> moveRight() => Point(this.x + 1, this.y);
}
