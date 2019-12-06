// --- Day 6: Universal Orbit Map ---
// https://adventofcode.com/2019/day/6

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2019/day06.dart';

const String dataFilePath = 'test/data/day06.txt';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
          solveA(const [
            'COM)B',
            'B)C',
            'C)D',
            'D)E',
            'E)F',
            'B)G',
            'G)H',
            'D)I',
            'E)J',
            'J)K',
            'K)L',
          ]),
          equals(42));
    });
    test('Solution', () {
      expect(solveA(File(dataFilePath).readAsLinesSync()), equals(253104));
    });
  });
}
