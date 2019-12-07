// --- Day 7: Amplification Circuit ---
// https://adventofcode.com/2019/day/7

import 'dart:math';
import 'intcode_computer.dart';

int solveA(String input) {
  final memory = IntcodeComputer.parse(input);
  var maxThrusterSignal = 0;

  for (final combinationIterable in combinations(List.generate(5, (i) => i))) {
    final combination = combinationIterable.toList(growable: false);

    final amqA = IntcodeComputer(memory).compute([combination[0], 0]);
    final amqB = IntcodeComputer(memory).compute([combination[1], amqA.first]);
    final amqC = IntcodeComputer(memory).compute([combination[2], amqB.first]);
    final amqD = IntcodeComputer(memory).compute([combination[3], amqC.first]);
    final amqE = IntcodeComputer(memory).compute([combination[4], amqD.first]);

    maxThrusterSignal = max(maxThrusterSignal, amqE.first);
  }

  return maxThrusterSignal;
}

Iterable<Iterable<int>> combinations(Iterable<int> inputs) sync* {
  if (inputs.length == 1) {
    yield inputs;
  } else {
    for (final input in inputs) {
      for (final combine in combinations(inputs.where((x) => x != input))) {
        yield [input, ...combine];
      }
    }
  }
}
