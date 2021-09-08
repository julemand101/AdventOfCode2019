// --- Day 12: The N-Body Problem ---
// https://adventofcode.com/2019/day/12

import 'package:advent_of_code_2019/day12.dart';
import 'package:test/test.dart';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
          solveA(const [
            '<x=-1, y=0, z=2>',
            '<x=2, y=-10, z=-7>',
            '<x=4, y=-8, z=8>',
            '<x=3, y=5, z=-1>',
          ], 10),
          equals(179));
    });
    test('Example 2', () {
      expect(
          solveA(const [
            '<x=-8, y=-10, z=0>',
            '<x=5, y=5, z=10>',
            '<x=2, y=-7, z=3>',
            '<x=9, y=-8, z=-3>',
          ], 100),
          equals(1940));
    });
    test('Solution', () {
      expect(
          solveA(const [
            '<x=-6, y=-5, z=-8>',
            '<x=0, y=-3, z=-13>',
            '<x=-15, y=10, z=-11>',
            '<x=-3, y=-8, z=3>',
          ], 1000),
          equals(5937));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(
          solveB(const [
            '<x=-1, y=0, z=2>',
            '<x=2, y=-10, z=-7>',
            '<x=4, y=-8, z=8>',
            '<x=3, y=5, z=-1>',
          ]),
          equals(2772));
    });
    test('Example 2', () {
      expect(
          solveB(const [
            '<x=-8, y=-10, z=0>',
            '<x=5, y=5, z=10>',
            '<x=2, y=-7, z=3>',
            '<x=9, y=-8, z=-3>',
          ]),
          equals(4686774924));
    });
    test('Solution', () {
      expect(
          solveB(const [
            '<x=-6, y=-5, z=-8>',
            '<x=0, y=-3, z=-13>',
            '<x=-15, y=10, z=-11>',
            '<x=-3, y=-8, z=3>',
          ]),
          equals(376203951569712));
    });
  });
}
