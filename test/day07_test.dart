// --- Day 7: Amplification Circuit ---
// https://adventofcode.com/2019/day/7

import 'dart:io';
import 'package:advent_of_code_2019/day07.dart';
import 'package:test/test.dart';

const String dataFilePath = 'test/data/day07.txt';

void main() {
  group('Part One', () {
    test('Solution', () {
      expect(
        solveA(File(dataFilePath).readAsLinesSync().first),
        equals(117312),
      );
    });
  });
  group('Part Two', () {
    test('Solution', () {
      expect(
        solveB(File(dataFilePath).readAsLinesSync().first),
        equals(1336480),
      );
    });
  });
}
