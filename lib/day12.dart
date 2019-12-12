// --- Day 12: The N-Body Problem ---
// https://adventofcode.com/2019/day/12

class Moon {
  int positionX, positionY, positionZ;
  int velocityX = 0, velocityY = 0, velocityZ = 0;

  // <x=2, y=-10, z=-7>
  static final _pattern = RegExp(r'-?\d+');

  Moon(String input) {
    final parsed = _pattern
        .allMatches(input)
        .map((match) => int.parse(match.group(0)))
        .toList(growable: false);

    positionX = parsed[0];
    positionY = parsed[1];
    positionZ = parsed[2];
  }

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
    for (final moon1 in moons) {
      moons
          .where((moon) => moon != moon1)
          .forEach((moon2) => moon1.updateVelocity(moon2));
    }

    moons.forEach((moon) => moon.applyVelocity());
  }

  return moons.fold<int>(0, (energySum, moon) => energySum + moon.totalEnergy);
}
