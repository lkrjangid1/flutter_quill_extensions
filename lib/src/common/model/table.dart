import 'model.dart';

class TableModel extends BaseModel {
  final int rowNumber;
  final int columnsNumber;
  final List<List<String>> data;

  TableModel({
    required this.rowNumber,
    required this.columnsNumber,
    required this.data,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    final List<List<String>> table = [];

    for (var element in json['data']) {
      table.add(List.from(element));
    }

    return TableModel(
      rowNumber: json['rowNumber'],
      columnsNumber: json['columnsNumber'],
      data: table.isNotEmpty ? table : [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'rowNumber': rowNumber,
      'columnsNumber': columnsNumber,
      'data': data,
    };
  }
}
