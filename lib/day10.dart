// --- Day 10: Monitoring Station ---
// https://adventofcode.com/2019/day/10

import 'dart:math';

class Result {
  final int maxAsteroidsDetected;
  final Point<int> maxAsteroidsDetectedPoint;

  Result(this.maxAsteroidsDetected, this.maxAsteroidsDetectedPoint);
}

int solveA(List<String> input) {
  final asteroids = <Point<int>>[];

  for (var y = 0; y < input.length; y++) {
    for (var x = 0; x < input[y].length; x++) {
      if (input[y][x] == '#') {
        asteroids.add(Point(x, y));
      }
    }
  }

  return findStation(asteroids).maxAsteroidsDetected;
}

/// The solution here needs some explanation since I sucks at geometry. So
/// please don't think this is the optimal solution for anything. :)
///
/// So, my solution is inspired to make use of the atan2 to get the degrees
/// between the station point and a given asteroid.
///
/// But because the scan should start at 90 degrees and make a 360 turn around
/// I found that a little complicated. What I wanted here is to use the atan2
/// and scan coordinates in the order from max to lowest degrees (180 to -180).
///
/// So to do that I ended up first flipping the map by the x-axis by negate the
/// y coordinate so the map ends up as a more traditional coordinate system:
///
/// (x,y) -> (x,-y)
///
/// Hereafter I rotated the map by 90 degrees counterclockwise:
///
/// (x,y) -> (-y,x)
///
/// Which combined gives:
///
/// (x,y) -> (y,x)
///
/// After all the calculations I need to reverse the coordinates again to give
/// the correct answer.
int solveB(List<String> input) {
  final asteroids = <Point<int>>[];

  for (var y = 0; y < input.length; y++) {
    for (var x = 0; x < input[y].length; x++) {
      if (input[y][x] == '#') {
        asteroids.add(Point(y, x));
      }
    }
  }

  final station = findStation(asteroids).maxAsteroidsDetectedPoint;
  asteroids.remove(station);
  var asteroidsDestroyed = 0;

  while (asteroids.isNotEmpty) {
    final angleToAsteroid = <double, Point<int>>{};

    for (final asteroid in asteroids) {
      final angle = atan2(asteroid.y - station.y, asteroid.x - station.x);

      if (angleToAsteroid.containsKey(angle)) {
        if (asteroid.distanceTo(station) <
            angleToAsteroid[angle].distanceTo(station)) {
          angleToAsteroid[angle] = asteroid;
        }
      } else {
        angleToAsteroid[angle] = asteroid;
      }
    }

    final anglesOfAsteroidsToDestroy = angleToAsteroid.keys.toList();
    anglesOfAsteroidsToDestroy.sort();

    for (final degree in anglesOfAsteroidsToDestroy.reversed) {
      final asteroidToRemove = angleToAsteroid[degree];
      asteroids.remove(asteroidToRemove);

      if (++asteroidsDestroyed == 200) {
        return (asteroidToRemove.y * 100) + asteroidToRemove.x;
      }
    }
  }

  throw Exception('Less than 200 asteroids destroyed!');
}

Result findStation(List<Point<int>> asteroids) {
  var maxAsteroidsDetected = 0;
  Point<int> maxAsteroidsDetectedPoint;

  for (final asteroid1 in asteroids) {
    final set = <double>{};

    for (final asteroid2 in asteroids.where((a) => a != asteroid1)) {
      final x1 = asteroid1.x, y1 = asteroid1.y;
      final x2 = asteroid2.x, y2 = asteroid2.y;

      set.add(atan2(y2 - y1, x2 - x1));
    }

    if (set.length > maxAsteroidsDetected) {
      maxAsteroidsDetected = set.length;
      maxAsteroidsDetectedPoint = asteroid1;
    }
  }

  return Result(maxAsteroidsDetected, maxAsteroidsDetectedPoint);
}
