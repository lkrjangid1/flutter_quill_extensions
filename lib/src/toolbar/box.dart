import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../embeds/view/box/widgets/box_editor.dart';

/// A button widget for adding box to the Quill editor toolbar.
class BoxToolbarButton extends StatelessWidget {
  const BoxToolbarButton({
    required this.controller,
    this.iconSize = kDefaultIconSize,
    this.fillColor,
    this.afterPressed,
    this.iconTheme,
    this.dialogTheme,
    this.tooltip,
    Key? key,
  }) : super(key: key);

  final double iconSize;
  final Color? fillColor;
  final String? tooltip;
  final VoidCallback? afterPressed;
  final QuillController controller;
  final QuillIconTheme? iconTheme;
  final QuillDialogTheme? dialogTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = iconTheme?.iconUnselectedColor ?? theme.iconTheme.color;
    final iconFillColor = iconTheme?.iconUnselectedFillColor ?? (fillColor ?? theme.canvasColor);

    return QuillIconButton(
      icon: Icon(Icons.rectangle_rounded, size: iconSize, color: iconColor),
      tooltip: tooltip ?? 'box',
      highlightElevation: 0,
      hoverElevation: 0,
      size: iconSize * 1.77,
      fillColor: iconFillColor,
      borderRadius: iconTheme?.borderRadius ?? 2,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => BoxWriteEditValue(quillController: controller),
      ),
      afterPressed: afterPressed,
    );
  }
}
