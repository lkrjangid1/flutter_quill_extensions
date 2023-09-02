import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../common.dart';

/// A utility class providing getter methods to access various attributes of the editor content.
/// This class is helpful for retrieving information about the text attributes.
class AttributesUtils<T> {
  final Map<String, Attribute<dynamic>> _attributes;

  AttributesUtils(this._attributes);

  /// Returns the background color of the text.
  Color? get backgroundColor => _getHexColor(Attribute.background.key);

  /// Returns the text color.
  Color? get color => _getHexColor(Attribute.color.key);

  /// Returns whether the text is in bold format.
  bool get isBold => _validate(Attribute.bold.key);

  /// Returns whether the text is in italic format.
  bool get isItalic => _validate(Attribute.italic.key);

  /// Returns whether the text has a strike-through style.
  bool get isStrike => _validate(Attribute.strikeThrough.key);

  /// Returns whether the text is underlined.
  bool get isUnderline => _validate(Attribute.underline.key);

  /// Returns a TextStyle object representing the current text style based on the attributes.
  TextStyle get style {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : null,
      fontStyle: isItalic ? FontStyle.italic : null,
      fontFamily: fontFamily,
      fontSize: fontSize,
      decoration: decoration,
    );
  }

  /// Returns a TextDecoration object representing the text decoration (underline or strikethrough).
  TextDecoration? get decoration {
    if (isUnderline) {
      return TextDecoration.underline;
    }
    if (isStrike) {
      return TextDecoration.lineThrough;
    }
    return null;
  }

  /// Returns the custom data associated with the editor content.
  ///
  /// The type of the returned data is generic, represented by the type parameter `T`.
  T? get data {
    final value = _attributes["data"]?.value;

    if (value == null || value.isEmpty) return null;

    return value;
  }

  /// Get the fontFamily
  ///
  /// Returns a `String` or `null` if the attribute is not found.
  String? get fontFamily {
    final String? value = _attributes[Attribute.font.key]?.value;

    if (value == null || value.isEmpty) return null;

    return value;
  }

  /// Get the header level.
  ///
  /// Returns a `Header` or `null` if the attribute is not found.
  Header? get header {
    final String? value = _attributes[Attribute.header.key]?.value;

    if (value == null || value.isEmpty) return null;

    return Header.values.firstWhere((element) => element.name.contains(value));
  }

  /// Get the text size.
  ///
  /// Returns a `Sizes` or `null` if the attribute is not found.
  Sizes? get sizes {
    final String? value = _attributes[Attribute.size.key]?.value;

    if (value == null || value.isEmpty) return null;

    return Sizes.values.firstWhere((element) => element.name.contains(value));
  }

  /// Returns the size of the text in `double`.
  double? get fontSize {
    switch (sizes) {
      case Sizes.small:
        return 12;
      case Sizes.large:
        return 18;
      case Sizes.huge:
        return 24;
      default:
        return null;
    }
  }

  /// Get the hex color from the attribute.
  ///
  /// Returns a `Color` or `null` if the attribute is not found.
  Color? _getHexColor(String hex) {
    final value = _attributes[hex]?.value;
    if (value != null) {
      return ColorUtils.hexToColor(value);
    }
    return null;
  }

  /// Validates the presence of certain styles (bold, italic, strike, underline).
  bool _validate(String style) {
    final bool? isEnable = _attributes[style]?.value;
    if (isEnable != null && isEnable) {
      return true;
    }
    return false;
  }
}

/// different sizes for the text.
enum Sizes { small, large, huge }

/// different header styles for the text.
enum Header { h1, h2, h3 }
