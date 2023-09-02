import 'package:flutter/material.dart';

class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem({
    required this.icon,
    required this.color,
    required this.text,
    this.onPressed,
    this.onTapDown,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback? onPressed;
  final GestureTapDownCallback? onTapDown;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      child: SimpleDialogOption(
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon, size: 36, color: color),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
