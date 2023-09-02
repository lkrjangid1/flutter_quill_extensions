import 'package:flutter/material.dart';
import 'package:flutter_quill/translations.dart';

import '../../../common/common.dart';
import 'menu.dart';

class MenuPopupSizeClassification extends StatelessWidget {
  final SizeClassification sizeClassification;
  final QuillControllerUtils quillControllerUtils;
  final ValueChanged<(dynamic data, SizeClassification s)> onChange;

  const MenuPopupSizeClassification({
    super.key,
    required this.onChange,
    required this.sizeClassification,
    required this.quillControllerUtils,
  });

  @override
  Widget build(BuildContext context) {
    return BaseMenu(
      quillControllerUtils: quillControllerUtils,
      onSelectValue: (value) => onChange(value),
      icon: Icons.photo_size_select_large,
      color: Colors.red.shade200,
      text: 'Resize'.i18n,
      value: sizeClassification,
      list: SizeClassification.values,
    );
  }
}
