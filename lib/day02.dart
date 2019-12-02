// --- Day 2: 1202 Program Alarm ---
// https://adventofcode.com/2019/day/2

const op_adds = 1;
const op_multiplies = 2;
const op_halt = 99;

int solveA(String input) {
  final memory = parse(input);

  // Once you have a working computer, the first step is to restore the gravity
  // assist program (your puzzle input) to the "1202 program alarm" state it had
  // just before the last computer caught fire. To do this, before running the
  // program, replace position 1 with the value 12 and replace position 2 with
  // the value 2. What value is left at position 0 after the program halts?
  memory[1] = 12;
  memory[2] = 2;

  return compute(memory).first;
}

int solveB(String input) {
  final rom = parse(input);

  for (var noun = 0; noun <= 99; noun++) {
    for (var verb = 0; verb <= 99; verb++) {
      var memory = rom.toList(growable: false);

      memory[1] = noun;
      memory[2] = verb;
      memory = compute(memory);

      if (memory.first == 19690720) {
        return 100 * noun + verb;
      }
    }
  }

  throw Exception('Did not find any result!');
}

List<int> testParseAndCompute(String input) => compute(parse(input));

List<int> parse(String input) =>
    input.split(',').map(int.parse).toList(growable: false);

List<int> compute(List<int> memory) {
  for (var pos = 0; memory[pos] != op_halt; pos += 4) {
    final opCode = memory[pos];
    final pos1 = memory[pos + 1];
    final pos2 = memory[pos + 2];
    final pos3 = memory[pos + 3];

    switch (opCode) {
      case op_adds:
        memory[pos3] = memory[pos1] + memory[pos2];
        break;
      case op_multiplies:
        memory[pos3] = memory[pos1] * memory[pos2];
        break;
      default:
        throw Exception('$opCode is not supported');
    }
  }

  return memory;
}
