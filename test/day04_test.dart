// --- Day 4: Secure Container ---
// https://adventofcode.com/2019/day/4

import 'package:test/test.dart';
import 'package:advent_of_code_2019/day04.dart';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA('111111-111111'), equals(1));
    });
    test('Example 2', () {
      expect(solveA('223450-223450'), equals(0));
    });
    test('Example 3', () {
      expect(solveA('123789-123789'), equals(0));
    });
    test('Solution', () {
      expect(solveA('231832-767346'), equals(1330));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(solveB('112233-112233'), equals(1));
    });
    test('Example 2', () {
      expect(solveB('123444-123444'), equals(0));
    });
    test('Example 3', () {
      expect(solveB('111122-111122'), equals(1));
    });
    test('Solution', () {
      expect(solveB('231832-767346'), equals(876));
    });
  });
}
