// --- Day 10: Monitoring Station ---
// https://adventofcode.com/2019/day/10

import 'dart:io';
import 'package:advent_of_code_2019/day10.dart';
import 'package:test/test.dart';

const String dataFilePath = 'test/data/day10.txt';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(
          solveA(const [
            '.#..#',
            '.....',
            '#####',
            '....#',
            '...##',
          ]),
          equals(8));
    });
    test('Example 2', () {
      expect(
          solveA(const [
            '......#.#.',
            '#..#.#....',
            '..#######.',
            '.#.#.###..',
            '.#..#.....',
            '..#....#.#',
            '#..#....#.',
            '.##.#..###',
            '##...#..#.',
            '.#....####',
          ]),
          equals(33));
    });
    test('Example 3', () {
      expect(
          solveA(const [
            '#.#...#.#.',
            '.###....#.',
            '.#....#...',
            '##.#.#.#.#',
            '....#.#.#.',
            '.##..###.#',
            '..#...##..',
            '..##....##',
            '......#...',
            '.####.###.',
          ]),
          equals(35));
    });
    test('Example 4', () {
      expect(
          solveA(const [
            '.#..#..###',
            '####.###.#',
            '....###.#.',
            '..###.##.#',
            '##.##.#.#.',
            '....###..#',
            '..#.#..#.#',
            '#..#.#.###',
            '.##...##.#',
            '.....#.#..',
          ]),
          equals(41));
    });
    test('Example 5', () {
      expect(
          solveA(const [
            '.#..##.###...#######',
            '##.############..##.',
            '.#.######.########.#',
            '.###.#######.####.#.',
            '#####.##.#.##.###.##',
            '..#####..#.#########',
            '####################',
            '#.####....###.#.#.##',
            '##.#################',
            '#####.##.###..####..',
            '..######..##.#######',
            '####.##.####...##..#',
            '.#####..#.######.###',
            '##...#.##########...',
            '#.##########.#######',
            '.####.#.###.###.#.##',
            '....##.##.###..#####',
            '.#.#.###########.###',
            '#.#.#.#####.####.###',
            '###.##.####.##.#..##',
          ]),
          equals(210));
    });
    test('Solution', () {
      expect(solveA(File(dataFilePath).readAsLinesSync()), equals(280));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(
          solveB(const [
            '.#..##.###...#######',
            '##.############..##.',
            '.#.######.########.#',
            '.###.#######.####.#.',
            '#####.##.#.##.###.##',
            '..#####..#.#########',
            '####################',
            '#.####....###.#.#.##',
            '##.#################',
            '#####.##.###..####..',
            '..######..##.#######',
            '####.##.####...##..#',
            '.#####..#.######.###',
            '##...#.##########...',
            '#.##########.#######',
            '.####.#.###.###.#.##',
            '....##.##.###..#####',
            '.#.#.###########.###',
            '#.#.#.#####.####.###',
            '###.##.####.##.#..##',
          ]),
          equals(802));
    });
    test('Solution', () {
      expect(solveB(File(dataFilePath).readAsLinesSync()), equals(706));
    });
  });
}
