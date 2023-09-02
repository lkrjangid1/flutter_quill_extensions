import 'package:flutter_quill/flutter_quill.dart';


class CustomTableEmbeddable extends Embeddable {
  static const String tableType = 'table';

  CustomTableEmbeddable() : super(tableType, tableType.toLowerCase());
}

