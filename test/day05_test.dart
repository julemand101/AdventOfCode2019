// --- Day 5: Sunny with a Chance of Asteroids ---
// https://adventofcode.com/2019/day/5

import 'dart:io';
import 'package:advent_of_code_2019/day05.dart';
import 'package:test/test.dart';

const String dataFilePath = 'test/data/day05.txt';

void main() {
  group('Part One', () {
    test('Solution', () {
      expect(
          solveA(File(dataFilePath).readAsLinesSync().first), equals(7839346));
    });
  });
  group('Part Two', () {
    test('Solution', () {
      expect(
          solveB(File(dataFilePath).readAsLinesSync().first), equals(447803));
    });
  });
}
