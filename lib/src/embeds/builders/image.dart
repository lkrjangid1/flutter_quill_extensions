import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../common/types.dart';
import '../view/image/image.dart';

/// This class is an implementation of the [EmbedBuilder] interface specific
/// to rendering image embeds in the Quill editor.
class ImageEmbedBuilder extends EmbedBuilder {
  ImageEmbedBuilder(this.imageBuilder);

  final ImageBuilder? imageBuilder;

  @override
  String get key => BlockEmbed.imageType;

  @override
  Widget build(BuildContext context,
      QuillController controller,
      Embed node,
      bool readOnly,
      bool inline,
      TextStyle textStyle,) {
    return ImageWrapperView(
      isReadOnly: readOnly,
      controller: controller,
      url: node.value.data,
      attributes: node.style.attributes,
      imageBuilder: imageBuilder,
    );
  }
}
