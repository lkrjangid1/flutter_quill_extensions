import 'package:flutter/material.dart' hide Alignment;

import '../../../common/common.dart';
import 'menu.dart';

class MenuPopupAlignment extends StatelessWidget {
  final QuillControllerUtils quillControllerUtils;
  final ValueChanged<(dynamic data, AlignmentCRL e)> onChange;
  final String alignmentName;

  const MenuPopupAlignment({
    super.key,
    required this.quillControllerUtils,
    required this.onChange,
    required this.alignmentName,
  });

  @override
  Widget build(BuildContext context) {
    return BaseMenu(
      quillControllerUtils: quillControllerUtils,
      onSelectValue: (value) => onChange(value),
      value: AlignmentImageEx.getAlignment(alignmentName),
      list: AlignmentCRL.values,
      icon: Icons.format_align_center_rounded,
      color: Colors.red.shade200,
      text: 'alignment',
    );
  }
}
