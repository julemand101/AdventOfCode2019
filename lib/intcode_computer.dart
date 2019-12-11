import 'dart:math';

class Memory {
  final Map<int, int> _data = {};

  int operator [](int pos) => _data[pos] ?? 0;
  void operator []=(int pos, int value) => _data[pos] = value;

  Memory(Iterable<int> input) {
    var i = 0;
    for (final value in input) {
      this[i++] = value;
    }
  }

  Memory.clone(Memory memory) {
    _data.addAll(memory._data);
  }

  List<int> toList() {
    final maxKey = _data.keys.reduce(max) + 1;
    final result = List<int>(maxKey);

    for (var i = 0; i < maxKey; i++) {
      result[i] = this[i];
    }

    return result;
  }
}

class IntcodeComputer {
  static const mode_position = '0';
  static const mode_immediate = '1';
  static const mode_relative = '2';

  final Memory memory;
  int relativeBase = 0;
  bool isRunning = true;

  IntcodeComputer(Memory memory) : this.memory = Memory.clone(memory);
  IntcodeComputer.fromString(String input) : this.memory = parse(input);

  static Memory parse(String input) => Memory(input.split(',').map(int.parse));

  void computeWithoutOutput() {
    for (final _ in compute()) {
      // Empty since we just want to throw the output away
    }
  }

  Iterable<int> compute(
      {List<int> input = const [], bool removeFromList = true}) sync* {
    var pos = 0;

    // 99 = halt
    while (!memory[pos].toString().endsWith('99')) {
      final parameter = memory[pos++].toString().padLeft(5, '0');
      final mode1 = parameter[2];
      final mode2 = parameter[1];
      final mode3 = parameter[0];
      final opCode = parameter.substring(3);

      switch (opCode) {
        case '01': // adds
          final val1 = _getValueInterpreted(pos++, mode1);
          final val2 = _getValueInterpreted(pos++, mode2);
          final val3 = _getValueLiteral(pos++, mode3);

          memory[val3] = val1 + val2;
          break;
        case '02': // multiplies
          final val1 = _getValueInterpreted(pos++, mode1);
          final val2 = _getValueInterpreted(pos++, mode2);
          final val3 = _getValueLiteral(pos++, mode3);

          memory[val3] = val1 * val2;
          break;
        case '03': // input:
          final val1 = _getValueLiteral(pos++, mode1);

          memory[val1] = removeFromList ? input.removeAt(0) : input[0];
          break;
        case '04': // output
          final val1 = _getValueInterpreted(pos++, mode1);

          yield val1;
          break;
        case '05': // jump-if-true
          final val1 = _getValueInterpreted(pos++, mode1);
          final val2 = _getValueInterpreted(pos++, mode2);

          if (val1 != 0) pos = val2;
          break;
        case '06': // jump-if-false
          final val1 = _getValueInterpreted(pos++, mode1);
          final val2 = _getValueInterpreted(pos++, mode2);

          if (val1 == 0) pos = val2;
          break;
        case '07': // less than
          final val1 = _getValueInterpreted(pos++, mode1);
          final val2 = _getValueInterpreted(pos++, mode2);
          final val3 = _getValueLiteral(pos++, mode3);

          memory[val3] = val1 < val2 ? 1 : 0;
          break;
        case '08': // equals
          final val1 = _getValueInterpreted(pos++, mode1);
          final val2 = _getValueInterpreted(pos++, mode2);
          final val3 = _getValueLiteral(pos++, mode3);

          memory[val3] = val1 == val2 ? 1 : 0;
          break;
        case '09': // adjusts the relative base
          final val1 = _getValueInterpreted(pos++, mode1);
          relativeBase += val1;
          break;
        default:
          throw Exception('OpCode $opCode is not supported');
      }
    }

    isRunning = false;
  }

  int _getValueInterpreted(int pos, String mode) {
    switch (mode) {
      case mode_position:
        return memory[memory[pos]];
        break;
      case mode_immediate:
        return memory[pos];
        break;
      case mode_relative:
        return memory[memory[pos] + relativeBase];
      default:
        throw Exception('Mode $mode is not supported!');
    }
  }

  int _getValueLiteral(int pos, String mode) {
    switch (mode) {
      case mode_position:
      case mode_immediate:
        return memory[pos];
        break;
      case mode_relative:
        return memory[pos] + relativeBase;
      default:
        throw Exception('Mode $mode is not supported!');
    }
  }
}
