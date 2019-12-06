// --- Day 6: Universal Orbit Map ---
// https://adventofcode.com/2019/day/6

class ObjectInSpace {
  final String name;
  final List<ObjectInSpace> orbits = [];

  ObjectInSpace(this.name);

  int get directIndirectOrbits => name == 'COM'
      ? 0
      : 1 + orbits.map((o) => o.directIndirectOrbits).reduce((a, b) => a + b);

  @override
  String toString() => orbits.length.toString();
}

int solveA(Iterable<String> inputs) {
  final map = <String, ObjectInSpace>{};

  for (final input in inputs) {
    final parts = input.split(')');
    final o1 = map.putIfAbsent(parts[0], () => ObjectInSpace(parts[0]));
    final o2 = map.putIfAbsent(parts[1], () => ObjectInSpace(parts[1]));
    o2.orbits.add(o1);
  }

  return map.values
      .map((o) => o.directIndirectOrbits)
      .reduce((sum, e) => sum + e);
}
