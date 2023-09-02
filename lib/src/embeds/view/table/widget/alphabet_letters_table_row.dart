import 'package:flutter/material.dart';

import 'text.dart';

class AlphabetLettersTableRow extends TableRow {
  final int rowNumber;

  const AlphabetLettersTableRow({required this.rowNumber});

  @override
  List<Widget> get children {
    return List.generate(
      rowNumber + 2,
      (index) {
        if (index == 0) {
          return const SizedBox();
        } else {
          return TextTable(
            index <= rowNumber
                ? String.fromCharCode(65 + index - 1)
                : "options",
          );
        }
      },
    );
  }
}
