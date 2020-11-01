// --- Day 16: Flawed Frequency Transmission ---
// https://adventofcode.com/2019/day/16

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2019/day16.dart';

const String dataFilePath = 'test/data/day16.txt';

void main() {
  group('Part One', () {
    test('Example 1a', () {
      expect(solveA('12345678', phases: 1), equals('48226158'));
    });
    test('Example 1b', () {
      expect(solveA('12345678', phases: 2), equals('34040438'));
    });
    test('Example c', () {
      expect(solveA('12345678', phases: 3), equals('03415518'));
    });
    test('Example 1d', () {
      expect(solveA('12345678', phases: 4), equals('01029498'));
    });
    test('Example 2', () {
      expect(solveA('80871224585914546619083218645595'), equals('24176176'));
    });
    test('Example 3', () {
      expect(solveA('19617804207202209144916044189917'), equals('73745418'));
    });
    test('Example 4', () {
      expect(solveA('69317163492948606335995924319873'), equals('52432133'));
    });
    test('Solution', () {
      expect(solveA(File(dataFilePath).readAsLinesSync().first),
          equals('77038830'));
    });
  });
}
