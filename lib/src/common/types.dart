import 'package:flutter/material.dart';

import 'common.dart';

typedef ImageBuilder = Widget Function(
  Image image,
  AttributesUtils attributes,
  OptionsImage optionsImage,
  bool readOnly,
);

typedef TableBuilder = Widget Function(
  AttributesUtils attributes,
  List<List<String>> data,
  VoidCallback showEditDialog,
  bool readOnly,
);

typedef BoxBuilder = Widget Function(
  AttributesUtils attributes,
  String value,
  VoidCallback showEditDialog,
  bool readOnly,
);

typedef DividerBuilder = Divider Function(AttributesUtils attributes, bool readOnly);
