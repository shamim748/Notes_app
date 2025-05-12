import 'dart:ui';

class Helper {
  Color colorFromHex(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex'; // Add default alpha if missing
    return Color(int.parse(hex, radix: 16));
  }
}
