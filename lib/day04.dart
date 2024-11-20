// --- Day 4: Secure Container ---
// https://adventofcode.com/2019/day/4

int solveA(String input) => solve(input, false);
int solveB(String input) => solve(input, true);

int solve(String input, bool checkLargeGroup) {
  final parts = input.split('-');
  final from = int.parse(parts[0]);
  final to = int.parse(parts[1]);
  var validPasswords = 0;

  for (var i = from; i <= to; i++) {
    if (validatePassword(i.toString(), checkLargeGroup)) {
      validPasswords++;
    }
  }

  return validPasswords;
}

final RegExp adjacentDigitsAreTheSameRegExp = RegExp(r'(.)\1+');

bool validatePassword(String password, bool checkLargeGroup) {
  // It is a six-digit number.
  if (password.length != 6) return false;

  final matches = adjacentDigitsAreTheSameRegExp.allMatches(password);
  if (checkLargeGroup) {
    // Part B: Part of a larger group of matching digits (but still allow the
    // password if there are a group in the password with the size of exact 2)
    if (matches.where((match) => match.group(0)!.length == 2).isEmpty) {
      return false;
    }
  } else {
    // Two adjacent digits are the same (like 22 in 122345).
    if (matches.isEmpty) {
      return false;
    }
  }

  // Going from left to right, the digits never decrease;
  for (var i = 1; i < password.length; i++) {
    final prev = int.parse(password[i - 1]);
    final current = int.parse(password[i]);

    if (current < prev) {
      return false;
    }
  }

  return true;
}
