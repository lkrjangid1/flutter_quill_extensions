import 'package:flutter/material.dart';

import '../common.dart';

/// A utility class providing methods for handling colors and converting color codes.
class ColorUtils {
  ColorUtils._();

  /// Converts a hexadecimal color [hexString] to a [Color] object.
  /// If [hexString] is null or invalid, returns the default color [Colors.black].
  static Color hexToColor(String? hexString) {
    if (hexString == null) {
      return Colors.black;
    }

    hexString = hexString.replaceAll('#', '');
    if (!ValidatorUtils.isHex(hexString)) return Colors.black;

    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString);
    return Color(int.tryParse(buffer.toString(), radix: 16) ?? 0xFF000000);
  }

  /// Converts a [Color] object to its hexadecimal representation.
  /// Returns the hexadecimal color code as a string.
  static String colorToHex(Color color) {
    return color.value.toRadixString(16).padLeft(8, '0').toUpperCase();
  }
}
