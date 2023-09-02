import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../../common/common.dart';
import 'widgets/box_editor.dart';

const _kEdgeInsets8 = EdgeInsets.all(8.0);

class BoxView extends StatelessWidget {
  final bool readOnly;
  final BoxBuilder? boxBuilder;
  final QuillController controller;
  final Map<String, Attribute<dynamic>> attributes;

  const BoxView({
    super.key,
    required this.boxBuilder,
    required this.attributes,
    required this.controller,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (boxBuilder != null) {
      return boxBuilder!(attributesUtils, attributesUtils.data!,
          () => showBoxWriteEditValueDialog(context), readOnly);
    } else {
      return Container(
        margin: _kEdgeInsets8,
        padding: _kEdgeInsets8,
        decoration: BoxDecoration(
          color: attributesUtils.backgroundColor ?? theme.primaryColor,
          border: Border.all(
            color: attributesUtils.color ?? Colors.grey,
            width: attributesUtils.isBold ? 3.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Builder(
          builder: (context) {
            if (readOnly) {
              return _buildTextWithAttributes();
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextWithAttributes(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    color: attributesUtils.color,
                    onPressed: () => showBoxWriteEditValueDialog(context),
                    icon: const Icon(Icons.edit),
                  ),
                )
              ],
            );
          },
        ),
      );
    }
  }

  void showBoxWriteEditValueDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BoxWriteEditValue(quillController: controller, value: attributesUtils.data);
      },
    ).then((value) => controller.moveCursorToPosition(controller.utils.offset));
  }

  Widget _buildTextWithAttributes() {
    return Text(attributesUtils.data ?? '', style: attributesUtils.style);
  }

  AttributesUtils<String> get attributesUtils => AttributesUtils<String>(attributes);
}




