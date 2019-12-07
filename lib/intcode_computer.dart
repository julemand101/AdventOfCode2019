class IntcodeComputer {
  static const mode_position = '0';
  static const mode_immediate = '1';

  final List<int> memory;

  IntcodeComputer(this.memory);
  IntcodeComputer.fromString(String input) : memory = parse(input);

  static List<int> parse(String input) =>
      input.split(',').map(int.parse).toList(growable: false);

  void computeWithoutOutput() {
    for (final _ in compute()) {
      // Empty since we just want to throw the output away
    }
  }

  Iterable<int> compute([Iterable<int> input = const []]) sync* {
    final inputStream = input.iterator;
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
          final val1 = _getValue(memory, pos++, mode1);
          final val2 = _getValue(memory, pos++, mode2);
          final val3 = _getValue(memory, pos++, mode_immediate);

          memory[val3] = val1 + val2;
          break;
        case '02': // multiplies
          final val1 = _getValue(memory, pos++, mode1);
          final val2 = _getValue(memory, pos++, mode2);
          final val3 = _getValue(memory, pos++, mode_immediate);

          memory[val3] = val1 * val2;
          break;
        case '03': // input:
          final val1 = _getValue(memory, pos++, mode_immediate);

          memory[val1] = inputStream.moveNext()
              ? inputStream.current
              : throw Exception('No more input!');
          break;
        case '04': // output
          final val1 = _getValue(memory, pos++, mode1);

          if (val1 != 0) {
            yield val1;
          }
          break;
        case '05': // jump-if-true
          final val1 = _getValue(memory, pos++, mode1);
          final val2 = _getValue(memory, pos++, mode2);

          if (val1 != 0) pos = val2;
          break;
        case '06': // jump-if-false
          final val1 = _getValue(memory, pos++, mode1);
          final val2 = _getValue(memory, pos++, mode2);

          if (val1 == 0) pos = val2;
          break;
        case '07': // less than
          final val1 = _getValue(memory, pos++, mode1);
          final val2 = _getValue(memory, pos++, mode2);
          final val3 = _getValue(memory, pos++, mode_immediate);

          memory[val3] = val1 < val2 ? 1 : 0;
          break;
        case '08': // equals
          final val1 = _getValue(memory, pos++, mode1);
          final val2 = _getValue(memory, pos++, mode2);
          final val3 = _getValue(memory, pos++, mode_immediate);

          memory[val3] = val1 == val2 ? 1 : 0;
          break;
        default:
          throw Exception('OpCode $opCode is not supported');
      }
    }
  }

  static int _getValue(List<int> memory, int pos, String mode) {
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
}
