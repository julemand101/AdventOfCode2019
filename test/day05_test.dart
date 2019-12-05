//
// https://adventofcode.com/2019/day/5

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2019/day05.dart';

const String dataFilePath = 'test/data/day05.txt';

void main() {
  group('Part One', () {
    test('Solution', () {
      expect(
          solveA(File(dataFilePath).readAsLinesSync().first), equals(7839346));
    });
  });
}
