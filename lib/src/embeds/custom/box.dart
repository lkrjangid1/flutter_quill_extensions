import 'package:flutter_quill/flutter_quill.dart';

class CustomBoxEmbeddable extends Embeddable {
  static const String boxType = 'box';

  CustomBoxEmbeddable() : super(boxType, boxType.toUpperCase());
}
