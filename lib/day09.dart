// --- Day 9: Sensor Boost ---
// https://adventofcode.com/2019/day/9

import 'intcode_computer.dart';

int solveA(String s) => IntcodeComputer.fromString(s).compute([1]).first;
int solveB(String s) => IntcodeComputer.fromString(s).compute([2]).first;
