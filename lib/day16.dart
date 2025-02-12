// --- Day 16: Flawed Frequency Transmission ---
// https://adventofcode.com/2019/day/16

List<int> parse(String line) => List.generate(
  line.length,
  (index) => int.parse(line[index]),
  growable: false,
);

String solveA(String line, {int phases = 100}) {
  var signal = parse(line);

  for (var phase = 0; phase < phases; phase++) {
    final newSignal = List.filled(signal.length, 0, growable: false);

    for (var i = 0; i < signal.length; i++) {
      final pattern = generatePattern(i).iterator;

      for (var k = 0; k < signal.length; k++) {
        newSignal[i] += signal[k] * (pattern..moveNext()).current;
      }

      newSignal[i] = newSignal[i].lastDigit;
    }

    signal = newSignal;
  }

  return signal.take(8).join();
}

String solveB(String line, {int phases = 100}) {
  final offset = int.parse(line.substring(0, 7));
  var signal = parse((line * 10000).substring(offset));

  for (var phase = 0; phase < phases; phase++) {
    final newSignal = List.filled(signal.length, 0, growable: false);
    var sum = 0;

    for (var i = signal.length - 1; i >= 0; i--) {
      newSignal[i] = (sum += signal[i]) % 10;
    }

    signal = newSignal;
  }

  return signal.take(8).join();
}

Iterable<int> generatePattern(int positionInTheOutputList) => () sync* {
  // ignore: literal_only_boolean_expressions
  while (true) {
    for (var i = 0; i <= positionInTheOutputList; i++) {
      yield 0;
    }
    for (var i = 0; i <= positionInTheOutputList; i++) {
      yield 1;
    }
    for (var i = 0; i <= positionInTheOutputList; i++) {
      yield 0;
    }
    for (var i = 0; i <= positionInTheOutputList; i++) {
      yield -1;
    }
  }
}().skip(1);

extension LastDigit on int {
  int get lastDigit => abs() % 10;
}
