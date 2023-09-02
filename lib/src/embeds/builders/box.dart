import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../common/types.dart';
import '../custom/box.dart';
import '../view/box/box.dart';

/// This class is an implementation of the [EmbedBuilder] interface specific
/// to rendering Box in the Quill editor.
class BoxEmbedBuilder extends EmbedBuilder {
  BoxEmbedBuilder(this.boxBuilder);

  final BoxBuilder? boxBuilder;

  @override
  String get key => CustomBoxEmbeddable.boxType;

  @override
  bool get expanded => false;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    return BoxView(
      boxBuilder: boxBuilder,
      readOnly: readOnly,
      controller: controller,
      attributes: node.style.attributes,
    );
  }
}
