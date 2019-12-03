// --- Day 3: Crossed Wires ---
// https://adventofcode.com/2019/day/3

import 'dart:math';

const direction_up = 'U';
const direction_down = 'D';
const direction_left = 'L';
const direction_right = 'R';

int solveA(List<String> input) {
  final globalPoints = <Point<int>>{};
  final intersections = <Point<int>>{};

  for (final line in input) {
    final points = <Point<int>>{};
    var currentPoint = const Point(0, 0);

    for (final instruction in line.split(',')) {
      final direction = instruction[0];
      final length = int.parse(instruction.substring(1));

      if (direction == direction_up) {
        for (var i = 0; i < length; i++) {
          points.add(currentPoint = currentPoint.moveUp());
        }
      } else if (direction == direction_down) {
        for (var i = 0; i < length; i++) {
          points.add(currentPoint = currentPoint.moveDown());
        }
      } else if (direction == direction_left) {
        for (var i = 0; i < length; i++) {
          points.add(currentPoint = currentPoint.moveLeft());
        }
      } else if (direction == direction_right) {
        for (var i = 0; i < length; i++) {
          points.add(currentPoint = currentPoint.moveRight());
        }
      } else {
        throw Exception('Unsupported direction: $direction');
      }
    }

    // Find intersections
    for (final point in points) {
      if (!globalPoints.add(point)) {
        intersections.add(point);
      }
    }
  }

  var manhattanDistanceOfClosestIntersection = 0;

  for (final intersection in intersections) {
    final manhattanDistance = intersection.manhattanDistanceFromZero();

    if (manhattanDistanceOfClosestIntersection == 0 ||
        manhattanDistance < manhattanDistanceOfClosestIntersection) {
      manhattanDistanceOfClosestIntersection = manhattanDistance;
    }
  }

  return manhattanDistanceOfClosestIntersection;
}

extension PointExtension on Point<int> {
  int manhattanDistanceFromZero() => this.x.abs() + this.y.abs();

  Point<int> moveUp() => Point(this.x, this.y + 1);
  Point<int> moveDown() => Point(this.x, this.y - 1);
  Point<int> moveLeft() => Point(this.x - 1, this.y);
  Point<int> moveRight() => Point(this.x + 1, this.y);
}
