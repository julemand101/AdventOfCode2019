// --- Day 2: 1202 Program Alarm ---
// https://adventofcode.com/2019/day/2

import 'dart:io';
import 'package:advent_of_code_2019/day02.dart';
import 'package:test/test.dart';

const String dataFilePath = 'test/data/day02.txt';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(testParseAndCompute('1,9,10,3,2,3,11,0,99,30,40,50'),
          equals(const [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50]));
    });
    test('Example 2', () {
      expect(testParseAndCompute('1,0,0,0,99'), equals(const [2, 0, 0, 0, 99]));
    });
    test('Example 3', () {
      expect(testParseAndCompute('2,3,0,3,99'), equals(const [2, 3, 0, 6, 99]));
    });
    test('Example 4', () {
      expect(testParseAndCompute('2,4,4,5,99,0'),
          equals(const [2, 4, 4, 5, 99, 9801]));
    });
    test('Example 5', () {
      expect(testParseAndCompute('1,1,1,4,99,5,6,0,99'),
          equals(const [30, 1, 1, 4, 2, 5, 6, 0, 99]));
    });
    test('Solution', () {
      expect(
          solveA(File(dataFilePath).readAsLinesSync().first), equals(4090689));
    });
  });
  group('Part Two', () {
    test('Solution', () {
      expect(solveB(File(dataFilePath).readAsLinesSync().first), equals(7733));
    });
  });
}
