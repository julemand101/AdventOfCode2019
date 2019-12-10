// --- Day 10: Monitoring Station ---
// https://adventofcode.com/2019/day/10

import 'dart:math';

int solveA(List<String> input) {
  final asteroids = <Point>[];

  for (var y = 0; y < input.length; y++) {
    for (var x = 0; x < input[y].length; x++) {
      if (input[y][x] == '#') {
        asteroids.add(Point(x, y));
      }
    }
  }

  var maxAsteroidsDetected = 0;

  for (final asteroid1 in asteroids) {
    final set = <double>{};

    for (final asteroid2 in asteroids.where((a) => a != asteroid1)) {
      final x1 = asteroid1.x, y1 = asteroid1.y;
      final x2 = asteroid2.x, y2 = asteroid2.y;

      set.add(atan2(y2 - y1, x2 - x1));
    }

    maxAsteroidsDetected = max(maxAsteroidsDetected, set.length);
  }

  return maxAsteroidsDetected;
}
