import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../embeds/view/dialogs/remove.dart';
import '../common.dart';

/// A utility class providing methods for handling image attributes and embedding images.
class ImageUtils {
  ImageUtils._();

  /// Generates an [Image] widget based on the provided [imageUrl], [width], [height], and [alignmentImageButton].
  static Image imageByUrl(
    String imageUrl, [
    ImageModel? imageAttributeModel,
  ]) {
    final width = imageAttributeModel?.width.toDouble();
    final height = imageAttributeModel?.height.toDouble();
    final alignment =
        imageAttributeModel?.alignment.alignmentGeometry ?? Alignment.center;
    final boxFit = imageAttributeModel?.boxFit;
    if (ValidatorUtils.isImageBase64(imageUrl)) {
      return Image.memory(
        base64.decode(imageUrl),
        width: width,
        height: height,
        alignment: alignment,
        fit: boxFit,
      );
    }

    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        alignment: alignment,
        fit: boxFit,
      );
    }
    return Image.file(
      File(imageUrl),
      width: width,
      height: height,
      alignment: alignment,
      fit: boxFit,
    );
  }

  static const List<String> allowedExtensions = [
    'png',
    'jpg',
    'jpeg',
    'gif',
    'webp',
    'bmp',
    'tiff',
    'heic',
    'heif',
  ];
}

/// class representing options dialog that controller in image like
/// * ---> [SizeClassification], [Alignment], [BoxFit], [RemoveOption].
class OptionsImage {
  final Widget sizeClassification;
  final Widget alignment;
  final Widget boxFit;
  final Widget remove;

  OptionsImage({
    required this.sizeClassification,
    required this.alignment,
    required this.boxFit,
    required this.remove,
  });
}
