import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/translations.dart';

import '../../../common/common.dart';
import 'simple.dart';

class RemoveOption extends StatelessWidget {
  final QuillController controller;

  const RemoveOption({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialogItem(
      icon: Icons.delete_forever_outlined,
      color: Colors.red.shade200,
      text: 'Remove'.i18n,
      onPressed: () {
        controller.utils.removeValue();
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
    );
  }
}
