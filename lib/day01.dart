// --- Day 1: The Tyranny of the Rocket Equation ---
// https://adventofcode.com/2019/day/1

int solveA(Iterable<String> input) =>
    input.map(int.parse).map(calcFuel).reduce((i1, i2) => i1 + i2);

int solveB(Iterable<String> input) =>
    input.map(int.parse).map(calcFuelRecursive).reduce((i1, i2) => i1 + i2);

int calcFuel(int mass) => (mass / 3).floor() - 2;

int calcFuelRecursive(int mass) {
  int result = calcFuel(mass);
  return result > 0 ?
  result + calcFuelRecursive(result) : 0;
}
