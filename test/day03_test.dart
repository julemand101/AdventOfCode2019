// --- Day 3: Crossed Wires ---
// https://adventofcode.com/2019/day/3

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2019/day03.dart';

const String dataFilePath = 'test/data/day03.txt';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(['R8,U5,L5,D3', 'U7,R6,D4,L4']), equals(6));
    });
    test('Example 2', () {
      expect(
          solveA([
            'R75,D30,R83,U83,L12,D49,R71,U7,L72',
            'U62,R66,U55,R34,D71,R55,D58,R83'
          ]),
          equals(159));
    });
    test('Example 3', () {
      expect(
          solveA([
            'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51',
            'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7'
          ]),
          equals(135));
    });
    test('Solution', () {
      expect(solveA(File(dataFilePath).readAsLinesSync()), equals(293));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(['R8,U5,L5,D3', 'U7,R6,D4,L4']), equals(30));
    });
    test('Example 2', () {
      expect(
          solveB([
            'R75,D30,R83,U83,L12,D49,R71,U7,L72',
            'U62,R66,U55,R34,D71,R55,D58,R83'
          ]),
          equals(610));
    });
    test('Example 3', () {
      expect(
          solveB([
            'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51',
            'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7'
          ]),
          equals(410));
    });
    test('Solution', () {
      expect(solveB(File(dataFilePath).readAsLinesSync()), equals(27306));
    });
  });
}
