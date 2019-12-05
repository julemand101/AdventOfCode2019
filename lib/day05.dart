// --- Day 5: Sunny with a Chance of Asteroids ---
// https://adventofcode.com/2019/day/5

const mode_position = '0';
const mode_immediate = '1';

int solveA(String input) => compute(parse(input), [1]);
int solveB(String input) => compute(parse(input), [5]);

List<int> parse(String input) =>
    input.split(',').map(int.parse).toList(growable: false);

int compute(List<int> memory, List<int> input) {
  var pos = 0;

  // 99 = halt
  while (!memory[pos].toString().endsWith('99')) {
    final parameter = memory[pos++].toString().padLeft(5, '0');
    final mode1 = parameter[2];
    final mode2 = parameter[1];
    // final mode3 = parameter[0];
    final opCode = parameter.substring(3);

    switch (opCode) {
      case '01': // adds
        final val1 = getValue(memory, pos++, mode1);
        final val2 = getValue(memory, pos++, mode2);
        final val3 = getValue(memory, pos++, mode_immediate);

        memory[val3] = val1 + val2;
        break;
      case '02': // multiplies
        final val1 = getValue(memory, pos++, mode1);
        final val2 = getValue(memory, pos++, mode2);
        final val3 = getValue(memory, pos++, mode_immediate);

        memory[val3] = val1 * val2;
        break;
      case '03': // input:
        final val1 = getValue(memory, pos++, mode_immediate);

        memory[val1] = input.removeAt(0);
        break;
      case '04': // output
        final val1 = getValue(memory, pos++, mode1);

        if (val1 != 0) {
          return val1;
        }
        break;
      case '05': // jump-if-true
        final val1 = getValue(memory, pos++, mode1);
        final val2 = getValue(memory, pos++, mode2);

        if (val1 != 0) pos = val2;
        break;
      case '06': // jump-if-false
        final val1 = getValue(memory, pos++, mode1);
        final val2 = getValue(memory, pos++, mode2);

        if (val1 == 0) pos = val2;
        break;
      case '07': // less than
        final val1 = getValue(memory, pos++, mode1);
        final val2 = getValue(memory, pos++, mode2);
        final val3 = getValue(memory, pos++, mode_immediate);

        memory[val3] = val1 < val2 ? 1 : 0;
        break;
      case '08': // equals
        final val1 = getValue(memory, pos++, mode1);
        final val2 = getValue(memory, pos++, mode2);
        final val3 = getValue(memory, pos++, mode_immediate);

        memory[val3] = val1 == val2 ? 1 : 0;
        break;
      default:
        throw Exception('OpCode $opCode is not supported');
    }
  }

  throw Exception('Did not find any answer!');
}

int getValue(List<int> memory, int pos, String mode) {
  switch (mode) {
    case mode_immediate:
      return memory[pos];
      break;
    case mode_position:
      return memory[memory[pos]];
      break;
    default:
      throw Exception('Mode $mode is not supported!');
  }
}
