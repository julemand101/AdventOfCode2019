// --- Day 11: Space Police ---
// https://adventofcode.com/2019/day/11

import 'dart:io';
import 'package:advent_of_code_2019/day11.dart';
import 'package:test/test.dart';

const String dataFilePath = 'test/data/day11.txt';

void main() {
  group('Part One', () {
    test('Solution', () {
      expect(solveA(File(dataFilePath).readAsLinesSync().first), equals(1883));
    });
  });
  group('Part Two', () {
    test('Solution', () {
      expect(
        solveB(File(dataFilePath).readAsLinesSync().first),
        equals('''
  ██  ███  █  █  ██  █  █ ███  ████ █  █
 █  █ █  █ █  █ █  █ █  █ █  █ █    █  █
 █  █ █  █ █  █ █    █  █ █  █ ███  ████
 ████ ███  █  █ █ ██ █  █ ███  █    █  █
 █  █ █    █  █ █  █ █  █ █ █  █    █  █
 █  █ █     ██   ███  ██  █  █ █    █  █
'''),
      );
    });
  });
}
