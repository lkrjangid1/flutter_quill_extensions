import 'package:flutter_quill/flutter_quill.dart';

class CustomDividerEmbeddable extends Embeddable {
  static const String dividerType = 'divider';

  CustomDividerEmbeddable() : super(dividerType, dividerType.toLowerCase());
}
