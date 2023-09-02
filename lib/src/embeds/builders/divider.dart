import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../common/types.dart';
import '../custom/divider.dart';
import '../view/divider/divider.dart';

class DividerEmbedBuilder extends EmbedBuilder {
  DividerEmbedBuilder(this.dividerBuilder);

  final DividerBuilder? dividerBuilder;

  @override
  String get key => CustomDividerEmbeddable.dividerType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    return DividerView(
      readOnly: readOnly,
      attributes: node.style.attributes,
      dividerBuilder: dividerBuilder,
    );
  }
}
