import 'package:flutter/material.dart';

import '../../../common/common.dart';

/// select a data operation: Export or Restore.
class DataOperationSelect extends StatelessWidget {
  const DataOperationSelect({Key? key}) : super(key: key);

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
              icon: const Icon(Icons.upload_file_rounded, color: Colors.orangeAccent),
              label: const Text('Export'),
              onPressed: () => Navigator.pop(context, DataOperationSetting.export),
            ),
          ),
          const SizedBox(height: 8.0, child: VerticalDivider()),
          Expanded(
            child: TextButton.icon(
              icon: const Icon(
                Icons.restore_page_rounded,
                color: Colors.cyanAccent,
              ),
              label: const Text('Restore'),
              onPressed: () => Navigator.pop(context, DataOperationSetting.restore),
            ),
          ),
        ],
      ),
    );
  }

  /// Shows the DataOperationSelect dialog and returns the selected data operation setting.
  Future<DataOperationSetting?> show(BuildContext context) async {
    return showDialog<DataOperationSetting>(
      context: context,
      builder: (ctx) => this,
    );
  }
}
