import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../../common/common.dart';
import '../dialogs/simple.dart';

class BaseMenu<T> extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback? onPressed;

  final T value;
  final List<T> list;
  final QuillControllerUtils quillControllerUtils;
  final ValueChanged<dynamic> onSelectValue;

  const BaseMenu({
    required this.icon,
    required this.color,
    required this.text,
    required this.list,
    required this.onSelectValue,
    required this.quillControllerUtils,
    required this.value,
    super.key,
    this.onPressed,
  });

  @override
  State<BaseMenu> createState() => _BaseMenuState();
}

class _BaseMenuState extends State<BaseMenu> {
  dynamic type;

  @override
  void initState() {
    super.initState();
    type = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        final left = details.globalPosition.dx;
        final top = details.globalPosition.dy;
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(left, top, left, 0),
          items: _buildMenuPopup(),
        );
      },
      child: SimpleDialogItem(
        icon: widget.icon,
        color: widget.color,
        text: widget.text,
        onPressed: widget.onPressed,
      ),
    );
  }

  List<PopupMenuEntry<dynamic>> _buildMenuPopup() {
    return widget.list.map(
      (element) {
        return PopupMenuItem(
          child: Card(
            color: type == element ? Colors.cyan : Colors.transparent,
            child: Padding(
              padding: const EdgeInsetsDirectional.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(element.toString().split('.')[1]),
              ),
            ),
          ),
          onTap: () {
            setState(() => type = element);
            _onTapHandler(type);
          },
        );
      },
    ).toList();
  }

  void _onTapHandler<T>(T element) {
    final style = widget.quillControllerUtils.controller.getSelectionStyle();
    final data = style.attributes["data"]?.value;

    if (data == null) {
      _showSnackBar('Please select an item before doing this.');
    } else {
      widget.onSelectValue((data, element));
      widget.quillControllerUtils.controller.updateSelection(
        widget.quillControllerUtils.controller.selection,
        ChangeSource.REMOTE,
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
