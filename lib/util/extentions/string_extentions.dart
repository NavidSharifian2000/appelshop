import 'dart:ui';

extension colorparsing on String {
  Color parsetocolor() {
    Color color = Color(int.parse("ff" + this, radix: 16));
    return color;
  }
}
