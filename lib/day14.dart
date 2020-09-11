// --- Day 14: Space Stoichiometry ---
// https://adventofcode.com/2019/day/14

class Chemical {
  final String name;
  final int quantity;

  const Chemical(this.name, this.quantity);

  factory Chemical.fromString(String input) {
    final split = input.split(' ');
    return Chemical(split[1], int.parse(split[0]));
  }

  @override
  String toString() => '$quantity $name';
}

class Reaction {
  final List<Chemical> inputs;
  final Chemical out;

  const Reaction(this.inputs, this.out);

  factory Reaction.fromString(String line) {
    final parts = line.split(' => ');
    return Reaction(
        [...parts[0].split(', ').map((string) => Chemical.fromString(string))],
        Chemical.fromString(parts[1]));
  }

  @override
  String toString() => '$inputs => $out';
}

// Key: Name of output from reaction | Value: Reaction
int calcOresNeeded(Map<String, Reaction> reactions, int fuelNeeded) {
  final storage = {'FUEL': -fuelNeeded};
  var chemicalNeeded = storage.entries.first;
  var ores = 0;

  // Run as long we still have chemicals in storage in negative quantities
  while (chemicalNeeded != null) {
    final reaction = reactions[chemicalNeeded.key];
    final factor = (chemicalNeeded.value.abs() / reaction.out.quantity).ceil();

    // Put chemical produced in storage
    storage.update(
        reaction.out.name, (value) => value + reaction.out.quantity * factor);

    // Remove chemical we need from storage.
    for (final chemical in reaction.inputs) {
      if (chemical.name == 'ORE') {
        ores += chemical.quantity * factor;
      } else {
        storage.update(
            chemical.name, (value) => value - (chemical.quantity * factor),
            ifAbsent: () => -(chemical.quantity * factor));
      }
    }

    // Find next chemical we need to make
    chemicalNeeded = storage.entries
        .firstWhere((element) => element.value < 0, orElse: () => null);
  }

  return ores;
}

int solveA(Iterable<String> lines) {
  final reactions = Map.fromEntries(lines
      .map((line) => Reaction.fromString(line))
      .map((reaction) => MapEntry(reaction.out.name, reaction)));
  return calcOresNeeded(reactions, 1);
}

int solveB(Iterable<String> lines) {
  final reactions = Map.fromEntries(lines
      .map((line) => Reaction.fromString(line))
      .map((reaction) => MapEntry(reaction.out.name, reaction)));
  return binarySearch(reactions, 1000000000000, 1, 1000000000000);
}

int binarySearch(Map<String, Reaction> reactions, int value, int min, int max) {
  if (min > max) {
    return max;
  }

  final mid = (max + min) ~/ 2;
  final midValue = calcOresNeeded(reactions, mid);

  if (value < midValue) {
    return binarySearch(reactions, value, min, mid - 1);
  } else if (value > midValue) {
    return binarySearch(reactions, value, mid + 1, max);
  } else {
    return mid;
  }
}
