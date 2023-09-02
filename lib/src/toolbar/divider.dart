import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../embeds/custom/divider.dart';
import '../common/common.dart';

/// A button widget for adding line to the Quill editor toolbar.
class DividerToolbarButton extends StatelessWidget {
  const DividerToolbarButton({
    required this.controller,
    this.iconSize = kDefaultIconSize,
    this.afterPressed,
    this.fillColor,
    this.iconTheme,
    this.dialogTheme,
    this.tooltip,
    Key? key,
  }) : super(key: key);

  final double iconSize;
  final Color? fillColor;
  final VoidCallback? afterPressed;
  final QuillController controller;
  final QuillIconTheme? iconTheme;
  final QuillDialogTheme? dialogTheme;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = iconTheme?.iconUnselectedColor ?? theme.iconTheme.color;
    final iconFillColor =
        iconTheme?.iconUnselectedFillColor ?? (fillColor ?? theme.canvasColor);

    return QuillIconButton(
      icon:
          Icon(Icons.horizontal_rule_rounded, size: iconSize, color: iconColor),
      tooltip: tooltip ?? 'line',
      highlightElevation: 0,
      hoverElevation: 0,
      size: iconSize * 1.77,
      fillColor: iconFillColor,
      borderRadius: iconTheme?.borderRadius ?? 2,
      onPressed: () => controller.utils.addValue(CustomDividerEmbeddable()),
      afterPressed: afterPressed,
    );
  }
}
