// --- Day 13: Care Package ---
// https://adventofcode.com/2019/day/13

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2019/day13.dart';

const String dataFilePath = 'test/data/day13.txt';

void main() {
  group('Part One', () {
    test('Solution', () {
      expect(solveA(File(dataFilePath).readAsLinesSync().first), equals(247));
    });
  });
  group('Part Two', () {
    test('Solution', () {
      expect(solveB(File(dataFilePath).readAsLinesSync().first), equals(12954));
    });
  });
}
