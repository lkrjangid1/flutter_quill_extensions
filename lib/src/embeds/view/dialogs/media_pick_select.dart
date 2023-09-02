import 'package:flutter/material.dart';
import 'package:flutter_quill/translations.dart';

import '../../../common/common.dart';

/// select a MediaPickSelect: Link or Gallery
class MediaPickSelect extends StatelessWidget {
  const MediaPickSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton.icon(
              icon: const Icon(Icons.collections, color: Colors.orangeAccent),
              label: Text('Gallery'.i18n),
              onPressed: () => Navigator.pop(context, MediaPickSetting.gallery),
            ),
          ),
          const SizedBox(height: 8.0, child: VerticalDivider()),
          Expanded(
            child: TextButton.icon(
              icon: const Icon(Icons.link, color: Colors.cyanAccent),
              label: Text('Link'.i18n),
              onPressed: () => Navigator.pop(context, MediaPickSetting.link),
            ),
          ),
        ],
      ),
    );
  }

  /// Shows the MediaPickSelect dialog and returns the selected MediaPickSetting.
  Future<MediaPickSetting?> show(BuildContext context) async {
    return showDialog<MediaPickSetting>(
        context: context, builder: (ctx) => this);
  }
}
