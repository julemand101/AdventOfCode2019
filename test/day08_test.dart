// --- Day 8: Space Image Format ---
// https://adventofcode.com/2019/day/8

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2019/day08.dart';

const String dataFilePath = 'test/data/day08.txt';

void main() {
  group('Part One', () {
    test('Solution', () {
      expect(solveA(File(dataFilePath).readAsLinesSync().first), equals(1950));
    });
  });
  group('Part Two', () {
    test('Solution', () {
      expect(solveB(File(dataFilePath).readAsLinesSync().first), equals('''
████ █  █  ██  █  █ █    
█    █ █  █  █ █  █ █    
███  ██   █  █ ████ █    
█    █ █  ████ █  █ █    
█    █ █  █  █ █  █ █    
█    █  █ █  █ █  █ ████ '''));
    });
  });
}
