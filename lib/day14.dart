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
  final List<Chemical> from;
  final Chemical to;

  const Reaction(this.from, this.to);

  factory Reaction.fromString(String line) {
    final parts = line.split(' => ');
    return Reaction(
        parts[0]
            .split(', ')
            .map((string) => Chemical.fromString(string))
            .toList(growable: false),
        Chemical.fromString(parts[1]));
  }

  @override
  String toString() => '$from => $to';
}

int solveA(Iterable<String> lines) {
  final reactions =
      lines.map((line) => Reaction.fromString(line)).toList(growable: false);

  final start = reactions.firstWhere((reaction) => reaction.to.name == 'FUEL');

  reactions.forEach(print);
  print(start);

  return 0;
}
