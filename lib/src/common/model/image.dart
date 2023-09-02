import 'package:flutter/widgets.dart';

import '../common.dart';
import 'model.dart';

/// Model class representing image attributes like width, height, and alignment.
class ImageModel extends BaseModel {
  final int width;
  final int height;
  final AlignmentCRL alignment;
  final BoxFit boxFit;

  ImageModel({
    required this.width,
    required this.height,
    required this.alignment,
    required this.boxFit,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      height: json['height'],
      width: json['width'],
      alignment: AlignmentImageEx.getAlignment(json['alignment']),
      boxFit: BoxFit.values.firstWhere(
        (element) => element.name.contains(json['boxFit']),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'alignment': alignment.name,
      'boxFit': boxFit.name
    };
  }
}
