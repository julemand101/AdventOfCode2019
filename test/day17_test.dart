// --- Day 16: Flawed Frequency Transmission ---
// https://adventofcode.com/2019/day/16

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2019/day17.dart';

const String dataFilePath = 'test/data/day17.txt';

void main() {
  group('Part One', () {
    test('Solution', () {
      expect(solveA(File(dataFilePath).readAsLinesSync().first), equals(6448));
    });
  });
  group('Part Two', () {
    test('Solution', () {
      expect(solveB(File(dataFilePath).readAsLinesSync().first), equals(-1));
    });
  });
}
