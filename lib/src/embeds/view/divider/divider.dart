import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../common/common.dart';

class DividerView extends StatelessWidget {
  final bool readOnly;
  final Map<String, Attribute<dynamic>> attributes;
  final DividerBuilder? dividerBuilder;

  const DividerView({
    super.key,
    required this.readOnly,
    required this.attributes,
    required this.dividerBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (dividerBuilder != null) {
      return dividerBuilder!(attributesUtils, readOnly);
    } else {
      return Divider(
        color: attributesUtils.color ??
            (brightness == Brightness.dark ? Colors.white : Colors.black),
        thickness: attributesUtils.isBold ? 5 : null,
      );
    }
  }

  AttributesUtils get attributesUtils => AttributesUtils(attributes);
}
