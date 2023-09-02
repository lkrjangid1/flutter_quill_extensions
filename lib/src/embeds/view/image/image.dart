import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../common/common.dart';
import '../dialogs/remove.dart';
import '../menus/alignment.dart';
import '../menus/box_fit.dart';
import '../menus/size.dart';
import 'preview.dart';

class ImageWrapperView extends StatefulWidget {
  final String url;
  final ImageBuilder? imageBuilder;

  final Map<String, Attribute<dynamic>> attributes;
  final QuillController controller;
  final bool isReadOnly;

  const ImageWrapperView({
    Key? key,
    required this.url,
    required this.controller,
    required this.isReadOnly,
    required this.attributes,
    required this.imageBuilder,
  }) : super(key: key);

  @override
  State<ImageWrapperView> createState() => _ImageWrapperViewState();
}

class _ImageWrapperViewState extends State<ImageWrapperView> {
  late int width;
  late int height;

  @override
  void initState() {
    super.initState();
    resolveImage();
  }

  void resolveImage() {
    final resolve = _image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(
      ImageStreamListener((image, synchronousCall) {
        width = image.image.width;
        height = image.image.height;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageBuilder != null) {
      return widget.imageBuilder!(
        _image,
        attributesUtils,
        OptionsImage(
          sizeClassification: sizeClassificationImageButton,
          alignment: alignmentImageButton,
          boxFit: boxFitImageButton,
          remove: removeImageButton,
        ),
        widget.isReadOnly,
      );
    } else {
      return GestureDetector(
        onTap: () {
          if (widget.isReadOnly) {
            showImagePreview(context, _image);
          }
        },
        onLongPress: () {
          if (!widget.isReadOnly) {
            _showSimpleDialog(context);
          }
        },
        child: _image,
      );
    }
  }

  void _showSimpleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        children: [
          sizeClassificationImageButton,
          alignmentImageButton,
          boxFitImageButton,
          removeImageButton,
        ],
      ),
    ).then((value) => FocusScope.of(context).unfocus());
  }

  Widget get sizeClassificationImageButton {
    return MenuPopupSizeClassification(
      quillControllerUtils: widget.controller.utils,
      sizeClassification: SizeClassificationExtension.getClassification(Size(
        imageModel.width.toDouble(),
        imageModel.height.toDouble(),
      )),
      onChange: (value) {
        final imageModel = ImageModel.fromJson(value.$1);
        if (value.$2 == SizeClassification.originalSize) {
          widget.controller.utils.updateAttribute(
            ImageModel(
              width: width,
              height: height,
              boxFit: imageModel.boxFit,
              alignment: imageModel.alignment,
            ).toAttribute(),
          );
        } else {
          final size = value.$2.getSize();
          widget.controller.utils.updateAttribute(
            ImageModel(
              width: size.width.toInt(),
              height: size.height.toInt(),
              boxFit: imageModel.boxFit,
              alignment: imageModel.alignment,
            ).toAttribute(),
          );
        }
      },
    );
  }

  Widget get alignmentImageButton {
    return MenuPopupAlignment(
      quillControllerUtils: widget.controller.utils,
      alignmentName: imageModel.alignment.name,
      onChange: (value) {
        final imageModel = ImageModel.fromJson(value.$1);
        widget.controller.utils.updateAttribute(
          ImageModel(
            width: imageModel.width,
            height: imageModel.height,
            boxFit: imageModel.boxFit,
            alignment: value.$2,
          ).toAttribute(),
        );
      },
    );
  }

  Widget get boxFitImageButton {
    return MenuPopupBoxFit(
      quillControllerUtils: widget.controller.utils,
      boxFit: imageModel.boxFit,
      onChange: (value) {
        final imageModel = ImageModel.fromJson(value.$1);
        widget.controller.utils.updateAttribute(
          ImageModel(
            width: imageModel.width,
            height: imageModel.height,
            alignment: imageModel.alignment,
            boxFit: value.$2,
          ).toAttribute(),
        );
      },
    );
  }

  Widget get removeImageButton => RemoveOption(controller: widget.controller);

  Image get _image {
    if (widget.attributes.isNotEmpty) {
      return ImageUtils.imageByUrl(widget.url, imageModel);
    } else {
      return ImageUtils.imageByUrl(widget.url);
    }
  }

  ImageModel get imageModel {
    final imageAttributes = widget.attributes["data"]!.value;
    return ImageModel.fromJson(imageAttributes);
  }

  AttributesUtils get attributesUtils => AttributesUtils(widget.attributes);
}
