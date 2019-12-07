// --- Day 5: Sunny with a Chance of Asteroids ---
// https://adventofcode.com/2019/day/5

import 'intcode_computer.dart';

int solveA(String s) => IntcodeComputer.fromString(s).compute([1]).first;
int solveB(String s) => IntcodeComputer.fromString(s).compute([5]).first;
