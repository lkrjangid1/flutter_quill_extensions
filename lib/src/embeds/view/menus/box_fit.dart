import 'package:flutter/material.dart';

import '../../../common/common.dart';
import 'menu.dart';

class MenuPopupBoxFit extends StatelessWidget {
  final QuillControllerUtils quillControllerUtils;
  final ValueChanged<(dynamic data, BoxFit e)> onChange;
  final BoxFit boxFit;

  const MenuPopupBoxFit({
    super.key,
    required this.quillControllerUtils,
    required this.onChange,
    required this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return BaseMenu(
      quillControllerUtils: quillControllerUtils,
      onSelectValue: (value) => onChange(value),
      icon: Icons.fit_screen_rounded,
      color: Colors.red.shade200,
      text: 'boxFit',
      value: boxFit,
      list: BoxFit.values,
    );
  }
}
