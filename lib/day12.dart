// --- Day 12: The N-Body Problem ---
// https://adventofcode.com/2019/day/12

class Moon {
  late int positionX, positionY, positionZ;
  int velocityX = 0, velocityY = 0, velocityZ = 0;

  // <x=2, y=-10, z=-7>
  static final _pattern = RegExp(r'-?\d+');

  Moon(String input) {
    final parsed = _pattern
        .allMatches(input)
        .map((match) => int.parse(match.group(0)!))
        .toList(growable: false);

    positionX = parsed[0];
    positionY = parsed[1];
    positionZ = parsed[2];
  }

  Moon.clone(Moon moon)
    : positionX = moon.positionX,
      positionY = moon.positionY,
      positionZ = moon.positionZ;

  void updateVelocity(Moon other) {
    velocityX += other.positionX.compareTo(positionX);
    velocityY += other.positionY.compareTo(positionY);
    velocityZ += other.positionZ.compareTo(positionZ);
  }

  void applyVelocity() {
    positionX += velocityX;
    positionY += velocityY;
    positionZ += velocityZ;
  }

  int get potentialEnergy =>
      positionX.abs() + positionY.abs() + positionZ.abs();

  int get kineticEnergy => velocityX.abs() + velocityY.abs() + velocityZ.abs();

  int get totalEnergy => potentialEnergy * kineticEnergy;
}

int solveA(Iterable<String> input, int steps) {
  final moons = input.map((line) => Moon(line)).toList(growable: false);

  for (var i = 0; i < steps; i++) {
    simulate(moons);
  }

  return moons.fold<int>(0, (energySum, moon) => energySum + moon.totalEnergy);
}

int solveB(Iterable<String> input) {
  final moons = input.map((line) => Moon(line)).toList(growable: false);

  // Find the point for each axis where velocity is zero. At this point we are
  // halfway in the simulation since hereafter we backtrack the same number of
  // steps before the position are the same.
  //
  // After finding this point for each axis we use LCM to find the least
  // common multiplier of all axis to find the point in time where we are back
  // to start.
  return [
    loopUntil(moons, (moon) => moon.velocityX == 0) * 2,
    loopUntil(moons, (moon) => moon.velocityY == 0) * 2,
    loopUntil(moons, (moon) => moon.velocityZ == 0) * 2,
  ].reduce((int a, int b) => a * b ~/ a.gcd(b)); // least common multiple (LCM)
}

int loopUntil(List<Moon> moons, bool Function(Moon) check) {
  final clone = moons.map((moon) => Moon.clone(moon)).toList(growable: false);
  var count = 0;

  do {
    count++;
    simulate(clone);
  } while (!clone.every(check));

  return count;
}

void simulate(List<Moon> moons) {
  for (final moon1 in moons) {
    for (final moon2 in moons) {
      if (moon1 != moon2) {
        moon1.updateVelocity(moon2);
      }
    }
  }

  for (final moon in moons) {
    moon.applyVelocity();
  }
}
