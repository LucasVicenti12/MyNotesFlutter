import 'dart:math';

String stringGenerator() {
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqTtUuVvWwXxYyZz1234567890';
  Random random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      20,
          (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ),
  );
}