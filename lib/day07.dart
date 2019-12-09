// --- Day 7: Amplification Circuit ---
// https://adventofcode.com/2019/day/7

import 'dart:math';
import 'intcode_computer.dart';

int solveA(String input) {
  final memory = IntcodeComputer.parse(input);
  var maxThrusterSignal = 0;

  for (final combination in combinations(List.generate(5, (i) => i))) {
    final amqA = IntcodeComputer(memory).compute([combination[0], 0]);
    final amqB = IntcodeComputer(memory).compute([combination[1], amqA.first]);
    final amqC = IntcodeComputer(memory).compute([combination[2], amqB.first]);
    final amqD = IntcodeComputer(memory).compute([combination[3], amqC.first]);
    final amqE = IntcodeComputer(memory).compute([combination[4], amqD.first]);

    maxThrusterSignal = max(maxThrusterSignal, amqE.first);
  }

  return maxThrusterSignal;
}

int solveB(String input) {
  final memory = IntcodeComputer.parse(input);
  var maxThrusterSignal = 0;

  for (final combination in combinations(List.generate(5, (i) => 5 + i))) {
    final amps = List.generate(5, (_) => IntcodeComputer(memory));
    maxThrusterSignal = max(maxThrusterSignal, loop(amps, memory, combination));
  }

  return maxThrusterSignal;
}

int loop(List<IntcodeComputer> amps, Memory memory, List<int> combination) {
  final inputA = [combination[0], 0];
  final inputB = [combination[1]];
  final inputC = [combination[2]];
  final inputD = [combination[3]];
  final inputE = [combination[4]];

  final amqAOut = amps[0].compute(inputA).iterator;
  final amqBOut = amps[1].compute(inputB).iterator;
  final amqCOut = amps[2].compute(inputC).iterator;
  final amqDOut = amps[3].compute(inputD).iterator;
  final amqEOut = amps[4].compute(inputE).iterator;

  var lastValue = 0;

  while (amps.any((amp) => amp.isRunning)) {
    amqAOut.moveNext();
    inputB.add(amqAOut.current);

    amqBOut.moveNext();
    inputC.add(amqBOut.current);

    amqCOut.moveNext();
    inputD.add(amqCOut.current);

    amqDOut.moveNext();
    inputE.add(amqDOut.current);

    if (amqEOut.moveNext()) lastValue = amqEOut.current;
    inputA.add(amqEOut.current);
  }

  return lastValue;
}

Iterable<List<int>> combinations(Iterable<int> inputs) sync* {
  if (inputs.length == 1) {
    yield inputs.toList();
  } else {
    for (final input in inputs) {
      for (final combine in combinations(inputs.where((x) => x != input))) {
        yield [input, ...combine];
      }
    }
  }
}
