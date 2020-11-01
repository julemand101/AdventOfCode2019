// --- Day 15: Oxygen System ---
// https://adventofcode.com/2019/day/15

import 'dart:math';

import 'intcode_computer.dart';

class Node {
  List<int> route = const [];
  bool isVisited = false;
  bool isOxygen = false;
  bool isWall = false;
}

class ShipMap {
  final Map<Point<int>, Node> _data = {};

  Node get(Point<int> point) => _data.putIfAbsent(point, () => Node());
  Node getOxygen() => _data.values.firstWhere((node) => node.isOxygen);
  List<Point<int>> get pointsNotFilledWithOxygenList => _data.entries
      .where((entry) => !entry.value.isOxygen && !entry.value.isWall)
      .map((entry) => entry.key)
      .toList(growable: false);

  @override
  String toString() {
    var minX = 0, maxX = 0;
    var minY = 0, maxY = 0;

    for (final point in _data.keys) {
      minX = min(minX, point.x);
      maxX = max(maxX, point.x);
      minY = min(minY, point.y);
      maxY = max(maxY, point.y);
    }

    final sb = StringBuffer();
    for (var y = minY; y <= maxY; y++) {
      for (var x = minX; x <= maxX; x++) {
        final point = Point(x, y);

        if (_data.containsKey(point)) {
          final value = _data[point];

          if (value.isWall) {
            sb.write('#');
          } else if (value.isOxygen) {
            sb.write('X');
          } else {
            sb.write('.');
          }
        } else {
          sb.write(' ');
        }
      }
      sb.writeln();
    }
    return sb.toString();
  }
}

const north = 1, south = 2, west = 3, east = 4;
const hit_wall = 0, moved_step = 1, moved_step_and_found_oxygen = 2;
const oppositeDirection = [null, south, north, east, west];

int solveA(String inputProgram) => solve(inputProgram).getOxygen().route.length;

int solveB(String inputProgram) {
  final map = solve(inputProgram);
  List<Point<int>> points;
  var minutes = 0;

  while ((points = map.pointsNotFilledWithOxygenList).isNotEmpty) {
    final nodesToFillWithOxygen = <Node>[];
    minutes++;

    for (final point in points) {
      if (point.neighbours.any((neighbour) => map.get(neighbour).isOxygen)) {
        nodesToFillWithOxygen.add(map.get(point));
      }
    }
    nodesToFillWithOxygen.forEach((node) => node.isOxygen = true);
  }

  return minutes;
}

ShipMap solve(String inputProgram) {
  final unvisited = {
    const Point(0, 0): IntcodeComputer.fromString(inputProgram)
  };
  final map = ShipMap();

  while (unvisited.isNotEmpty) {
    final pointWithLowestRouteLength = unvisited.keys.reduce((p1, p2) =>
        map.get(p1).route.length < map.get(p2).route.length ? p1 : p2);
    final nodeWithLowestRuteLength = map.get(pointWithLowestRouteLength);

    final computer = unvisited.remove(pointWithLowestRouteLength);
    nodeWithLowestRuteLength.isVisited = true;

    final neighbourPoints = {
      north: pointWithLowestRouteLength.north,
      south: pointWithLowestRouteLength.south,
      west: pointWithLowestRouteLength.west,
      east: pointWithLowestRouteLength.east,
    }..removeWhere((_, point) => map.get(point).isVisited);

    for (final entry in neighbourPoints.entries) {
      final direction = entry.key;
      final point = entry.value;
      final node = map.get(point);
      final newComputer = IntcodeComputer.fromIntCodeComputer(computer);
      final result = (newComputer..input.add(direction)).runUntilOutputOrDone();

      if (result == hit_wall) {
        node.isWall = true;
        node.isVisited = true;
      } else if (result == moved_step ||
          result == moved_step_and_found_oxygen) {
        node.isOxygen = result == moved_step_and_found_oxygen;

        final newRoute = [...nodeWithLowestRuteLength.route, direction];
        if (node.route.isEmpty || newRoute.length < node.route.length) {
          node.route = newRoute;
        }

        unvisited[point] = newComputer;
      } else {
        throw Exception('Should never happen!');
      }
    }
  }

  return map;
}

extension DirectionsOnPoint on Point<int> {
  Point<int> get north => Point(x, y - 1);
  Point<int> get south => Point(x, y + 1);
  Point<int> get west => Point(x - 1, y);
  Point<int> get east => Point(x + 1, y);
  List<Point<int>> get neighbours => [north, south, west, east];
}
