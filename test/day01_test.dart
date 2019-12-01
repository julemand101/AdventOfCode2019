// --- Day 1: The Tyranny of the Rocket Equation ---
// https://adventofcode.com/2019/day/1

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2019/day01.dart';

const String dataFilePath = 'test/data/day01.txt';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(const ['12']), equals(2));
    });
    test('Example 2', () {
      expect(solveA(const ['14']), equals(2));
    });
    test('Example 3', () {
      expect(solveA(const ['1969']), equals(654));
    });
    test('Example 4', () {
      expect(solveA(const ['100756']), equals(-1));
    });
    test('Solution', () {
      expect(solveA(File(dataFilePath).readAsLinesSync()), equals(3152375));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(const ['14']), equals(2));
    });
    test('Example 2', () {
      expect(solveB(const ['1969']), equals(966));
    });
    test('Example 3', () {
      expect(solveB(const ['100756']), equals(50346));
    });
    test('Solution', () {
      expect(solveB(File(dataFilePath).readAsLinesSync()), equals(4725720));
    });
  });
}
