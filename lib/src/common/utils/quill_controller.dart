import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

/// A utility class extending `QuillController` to provide additional methods for text manipulation.
class QuillControllerUtils {
  final QuillController controller;

  static QuillControllerUtils? _instance;

  factory QuillControllerUtils._getInstance(QuillController controller) {
    _instance ??= QuillControllerUtils._(controller);
    return _instance!;
  }

  QuillControllerUtils._(this.controller);

  /// Retrieves the offset of the currently selected embed in the [controller].
  int get offset => getEmbedNode(controller, controller.selection.start).offset;

  /// Retrieves the base offset of the current selection in the [controller].
  int get index => controller.selection.baseOffset;

  /// Retrieves the length of the current selection in the [controller].
  int get length => controller.selection.extentOffset - index;

  /// Returns the JSON representation of the [controller]'s document.
  String get data {
    return jsonEncode(controller.document.toDelta().toJson());
  }

  /// Inserts a [List] of [dynamic] JSON data into the [controller]'s document.
  void insert(List<dynamic> json) {
    controller.document = Document.fromJson(json);
  }

  /// move Cursor To select Position.
  void moveCursorToPosition() => controller.moveCursorToPosition(offset);

  /// Copies the JSON data of the [controller]'s document to the clipboard.
  void copy() => Clipboard.setData(ClipboardData(text: data));

  /// Retrieves JSON data from the clipboard and returns it as a [List<dynamic>].
  /// Returns `null` if the clipboard data is not valid JSON or if no data is available.
  Future<List<dynamic>?> past() async {
    ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData?.text != null) {
      try {
        List<dynamic> jsonData = jsonDecode(clipboardData!.text!);
        return jsonData;
      } catch (e) {
        throw 'Invalid JSON data, $e';
      }
    }
    return null;
  }

  /// Removes the currently selected value (embed or text) from the [controller].
  void removeValue() {
    controller.replaceText(
        offset, 1, '', TextSelection.collapsed(offset: offset));
  }

  /// Adds a new value (embed or text) to the [controller] at the current selection.
  /// Optionally, an [attribute] can be applied to the added value.
  void addValue(Object value, [Attribute<dynamic>? attribute]) {
    controller.replaceText(index, length, value, null);

    // add attribute
    if (attribute != null) {
      updateAttribute(attribute);
    }
  }

  /// Updates the attributes of the currently selected in the [controller].
  void updateAttribute(
    Attribute<dynamic>? attribute,
  ) => controller.document.format(offset, 1, attribute);

  /// Retrieves the style string of the currently selected in the [controller].
  String getStyleString() {
    final List<Style?> listStyle = controller.getAllSelectionStyles();
    final style = listStyle.firstWhere(
      (s) => s!.attributes.containsKey(Attribute.style.key),
      orElse: Style.new,
    );

    return style?.attributes[Attribute.style.key]?.value ?? '';
  }
}

/// Extension on [QuillController] to provide easy access to [QuillControllerUtils].
extension QuillControllerUtilsExtension on QuillController {
  /// Gets a [QuillControllerUtils] instance associated with the [QuillController].
  QuillControllerUtils get utils => QuillControllerUtils._getInstance(this);
}
