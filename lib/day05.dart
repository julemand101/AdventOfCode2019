//
// https://adventofcode.com/2019/day/5

const op_adds = '01';
const op_multiplies = '02';
const op_input = '03';
const op_output = '04';
const op_halt = '99';

const mode_position = '0';
const mode_immediate = '1';

int solveA(String input) => compute(parse(input), [1]);

List<int> parse(String input) =>
    input.split(',').map(int.parse).toList(growable: false);

int compute(List<int> memory, List<int> input) {
  var pos = 0;

  while (!memory[pos].toString().endsWith(op_halt)) {
    final parameter = memory[pos++].toString().padLeft(5, '0');
    final mode1 = parameter[2];
    final mode2 = parameter[1];
    // final mode3 = parameter[0];
    final opCode = parameter.substring(3);

    switch (opCode) {
      case op_adds:
        final pos1 = getValue(memory, pos++, mode1);
        final pos2 = getValue(memory, pos++, mode2);
        final pos3 = getValue(memory, pos++, mode_immediate);

        memory[pos3] = pos1 + pos2;
        break;
      case op_multiplies:
        final pos1 = getValue(memory, pos++, mode1);
        final pos2 = getValue(memory, pos++, mode2);
        final pos3 = getValue(memory, pos++, mode_immediate);

        memory[pos3] = pos1 * pos2;
        break;
      case op_input:
        final pos1 = getValue(memory, pos++, mode_immediate);

        memory[pos1] = input.removeAt(0);
        break;
      case op_output:
        final pos1 = getValue(memory, pos++, mode1);
        if (pos1 != 0) {
          return pos1;
        }
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
