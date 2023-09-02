import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import 'text.dart';

class EditorTableRows {
  final TableModel _tableModel;

  final List<List<TextEditingController>> _table;
  final List<bool> _tableLockStatus;

  final VoidCallback _addRow;
  final ValueChanged<int>? _deleteRow;
  final ValueChanged<int>? _toggleLockRow;

  const EditorTableRows({
    required List<List<TextEditingController>> table,
    required TableModel tableModel,
    required List<bool> tableLockStatus,
    required VoidCallback addRow,
    required ValueChanged<int> toggleLockRow,
    required ValueChanged<int> deleteRow,
  })  : _addRow = addRow,
        _toggleLockRow = toggleLockRow,
        _deleteRow = deleteRow,
        _tableLockStatus = tableLockStatus,
        _table = table,
        _tableModel = tableModel;

  List<TableRow> buildEditorTableRows(BuildContext context) {
    return _table.asMap().entries.map(
      (entry) {
        final index = entry.key;
        final rowData = entry.value;
        final isRowLocked = _tableLockStatus[index];

        return TableRow(
          children: [
            TextTable(('${index + 1}')),
            ...rowData.map(
              (controller) {
                final offsetController = rowData.indexOf(controller);
                if (_tableModel.data.isNotEmpty && controller.text.isEmpty) {
                  final data = _tableModel.data.isNotEmpty
                      ? _tableModel.data[index][offsetController]
                      : '';
                  controller.text = data;
                }
                return _buildTextField(controller, isRowLocked, context);
              },
            ).toList(),
            _buildButtonsOption(index, isRowLocked, context),
          ],
        );
      },
    ).toList();
  }

  Widget _buildTextField(
    TextEditingController controller,
    bool isRowLocked,
    BuildContext context,
  ) =>
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextField(
          controller: controller,
          enabled: !isRowLocked,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          maxLines: 5,
          minLines: 1,
          maxLength: 350,
          decoration: const InputDecoration(border: InputBorder.none),
          mouseCursor: SystemMouseCursors.click,
        ),
      );

  Widget _buildButtonsOption(int index, bool isRowLocked, BuildContext context) {
    return FittedBox(
      fit: _tableModel.rowNumber <= 2 ? BoxFit.scaleDown : BoxFit.contain,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(() {
            if (index == 0 && _table.length <= 1) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            } else {
              _deleteRow?.call(index);
            }
          }, Icons.remove),
          _buildButton(
            () => _toggleLockRow?.call(index),
            isRowLocked ? Icons.lock_open : Icons.lock,
          ),
          _buildButton(_addRow, Icons.add),
        ],
      ),
    );
  }

  Widget _buildButton(VoidCallback? onPressed, IconData? icon) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: IconButton.outlined(
        onPressed: onPressed,
        icon: Icon(icon),
      ),
    );
  }
}
