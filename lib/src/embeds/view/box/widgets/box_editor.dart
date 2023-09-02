import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../../../common/common.dart';
import '../../../custom/box.dart';

class BoxWriteEditValue extends StatefulWidget {
  final String? value;
  final QuillController quillController;

  const BoxWriteEditValue({
    super.key,
    this.value,
    required this.quillController,
  });

  @override
  State<BoxWriteEditValue> createState() => _BoxWriteEditValueState();
}

class _BoxWriteEditValueState extends State<BoxWriteEditValue> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.value == null ? 'Write BoxValue' : 'Edit BoxValue'),
      content: TextField(controller: controller, maxLines: 10, minLines: 1),
      actions: [
        TextButton(onPressed: onTap, child: const Text('Add')),
        TextButton(
            onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
      ],
    );
  }

  void onTap() {
    if (controller.text.isNotEmpty) {
      if (widget.value == null) {
        widget.quillController.utils
            .addValue(CustomBoxEmbeddable(), _attributes);
      } else {
        widget.quillController.utils.updateAttribute(_attributes);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Attribute get _attributes =>
      Attribute("data", AttributeScope.INLINE, controller.text.trim());
}
