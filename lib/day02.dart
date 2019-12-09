// --- Day 2: 1202 Program Alarm ---
// https://adventofcode.com/2019/day/2

import 'intcode_computer.dart';

int solveA(String input) {
  final memory = IntcodeComputer.parse(input);

  // Once you have a working computer, the first step is to restore the gravity
  // assist program (your puzzle input) to the "1202 program alarm" state it had
  // just before the last computer caught fire. To do this, before running the
  // program, replace position 1 with the value 12 and replace position 2 with
  // the value 2. What value is left at position 0 after the program halts?
  memory[1] = 12;
  memory[2] = 2;

  return (IntcodeComputer(memory)..computeWithoutOutput()).memory[0];
}

int solveB(String input) {
  final memory = IntcodeComputer.parse(input);

  for (var noun = 0; noun <= 99; noun++) {
    for (var verb = 0; verb <= 99; verb++) {
      memory[1] = noun;
      memory[2] = verb;
      final result = (IntcodeComputer(memory)..computeWithoutOutput()).memory;

      if (result[0] == 19690720) {
        return 100 * noun + verb;
      }
    }
  }

  throw Exception('Did not find any result!');
}

List<int> testParseAndCompute(String input) =>
    (IntcodeComputer.fromString(input)..computeWithoutOutput()).memory.toList();
