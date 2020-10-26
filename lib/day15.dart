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

int solveA(String inputProgram) {
  final memoryMasterCopy = Memory.fromString(inputProgram);
  final map = ShipMap();

  final unvisited = {const Point(0, 0)};

  while (unvisited.isNotEmpty) {
    final pointWithLowestRouteLength = unvisited.reduce((p1, p2) =>
        map.get(p1).route.length < map.get(p2).route.length ? p1 : p2);
    final nodeWithLowestRuteLength = map.get(pointWithLowestRouteLength);

    unvisited.remove(pointWithLowestRouteLength);
    nodeWithLowestRuteLength.isVisited = true;

    final neighbourPoints = {
      north:
          Point(pointWithLowestRouteLength.x, pointWithLowestRouteLength.y - 1),
      south:
          Point(pointWithLowestRouteLength.x, pointWithLowestRouteLength.y + 1),
      west:
          Point(pointWithLowestRouteLength.x - 1, pointWithLowestRouteLength.y),
      east:
          Point(pointWithLowestRouteLength.x + 1, pointWithLowestRouteLength.y),
    }..removeWhere((_, point) => map.get(point).isVisited);
    unvisited.addAll(neighbourPoints.values);

    final computer = IntcodeComputer(memoryMasterCopy);
    final input = [...nodeWithLowestRuteLength.route];
    final iterator = computer.compute(input: input).iterator;

    while (input.isNotEmpty) {
      iterator.moveNext();
    }

    for (final entry in neighbourPoints.entries) {
      final direction = entry.key;
      final point = entry.value;
      final node = map.get(point);

      input.add(direction);
      final result = (iterator..moveNext()).current;

      if (result == hit_wall) {
        node.isWall = true;
        node.isVisited = true;
        unvisited.remove(point);
      } else if (result == moved_step ||
          result == moved_step_and_found_oxygen) {
        node.isOxygen = result == moved_step_and_found_oxygen;

        final newRoute = [...nodeWithLowestRuteLength.route, direction];
        if (node.route.isEmpty || newRoute.length < node.route.length) {
          node.route = newRoute;
        }

        // Move back
        input.add(oppositeDirection[direction]);
        iterator.moveNext();
      } else {
        throw Exception('Should never happen!');
      }
    }
  }

  print(map);
  return map.getOxygen().route.length;
}
