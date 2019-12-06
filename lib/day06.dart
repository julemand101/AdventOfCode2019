// --- Day 6: Universal Orbit Map ---
// https://adventofcode.com/2019/day/6

class ObjectInSpace {
  ObjectInSpace orbitAround;

  int get directAndIndirectOrbits =>
      orbitAround == null ? 0 : 1 + orbitAround.directAndIndirectOrbits;
}

int solveA(Iterable<String> inputs) {
  final map = <String, ObjectInSpace>{};

  for (final input in inputs) {
    final parts = input.split(')');
    final o1 = map.putIfAbsent(parts[0], () => ObjectInSpace());
    final o2 = map.putIfAbsent(parts[1], () => ObjectInSpace());
    o2.orbitAround = o1;
  }

  return map.values
      .map((o) => o.directAndIndirectOrbits)
      .reduce((sum, e) => sum + e);
}

class ObjectInSpaceTwoWay {
  final List<ObjectInSpaceTwoWay> orbitedBy = [];
  ObjectInSpaceTwoWay orbitAround;
  int distanceFromStart;

  Iterable<ObjectInSpaceTwoWay> get orbitsNotVisited sync* {
    if (orbitAround != null && orbitAround.distanceFromStart == null) {
      yield orbitAround;
    }

    yield* orbitedBy.where((o) => o.distanceFromStart == null);
  }

  void visit([int distance = 0]) {
    distanceFromStart = distance;
    orbitsNotVisited.forEach((o) => o.visit(distance + 1));
  }
}

int solveB(Iterable<String> inputs) {
  final map = <String, ObjectInSpaceTwoWay>{};

  for (final input in inputs) {
    final parts = input.split(')');
    final o1 = map.putIfAbsent(parts[0], () => ObjectInSpaceTwoWay());
    final o2 = map.putIfAbsent(parts[1], () => ObjectInSpaceTwoWay());
    o2.orbitAround = o1;
    o1.orbitedBy.add(o2);
  }

  map['YOU'].orbitAround.visit();
  return map['SAN'].orbitAround.distanceFromStart;
}
