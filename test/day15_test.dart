// --- Day 15: Oxygen System ---
// https://adventofcode.com/2019/day/15

import 'dart:io';
import 'package:advent_of_code_2019/day15.dart';
import 'package:test/test.dart';

const String dataFilePath = 'test/data/day15.txt';

void main() {
  group('Part One', () {
    test('Solution', () {
      expect(solveA(File(dataFilePath).readAsLinesSync().first), equals(308));
    });
  });
  group('Part Two', () {
    test('Solution', () {
      expect(solveB(File(dataFilePath).readAsLinesSync().first), equals(328));
    });
  });
}
