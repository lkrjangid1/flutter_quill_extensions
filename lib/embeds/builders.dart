import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/extensions.dart' as base;
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/translations.dart';
import 'package:math_keyboard/math_keyboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;

import '../shims/dart_ui_fake.dart'
    if (dart.library.html) '../shims/dart_ui_real.dart' as ui;
import 'utils.dart';
import 'widgets/image.dart';
import 'widgets/image_resizer.dart';
import 'widgets/video_app.dart';
import 'widgets/youtube_video_app.dart';

StreamController<bool> showResizerControllersStream =
    StreamController<bool>.broadcast();

class ImageEmbedBuilder extends EmbedBuilder {
  @override
  String get key => BlockEmbed.imageType;

  @override
  bool get expanded => false;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    base.Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    assert(!kIsWeb, 'Please provide image EmbedBuilder for Web');

    var image;
    final imageUrl = standardizeImageUrl(node.value.data);
    OptionalSize? _imageSize;
    final style = node.style.attributes['style'];
    if (base.isMobile() && style != null) {
      final _attrs = base.parseKeyValuePairs(style.value.toString(), {
        Attribute.mobileWidth,
        Attribute.mobileHeight,
        Attribute.mobileMargin,
        Attribute.mobileAlignment
      });
      if (_attrs.isNotEmpty) {
        assert(
            _attrs[Attribute.mobileWidth] != null &&
                _attrs[Attribute.mobileHeight] != null,
            'mobileWidth and mobileHeight must be specified');
        final w = double.parse(_attrs[Attribute.mobileWidth]!);
        final h = double.parse(_attrs[Attribute.mobileHeight]!);
        _imageSize = OptionalSize(w, h);
        final m = _attrs[Attribute.mobileMargin] == null
            ? 0.0
            : double.parse(_attrs[Attribute.mobileMargin]!);
        final a = base.getAlignment(_attrs[Attribute.mobileAlignment]);
        image = Padding(
            padding: EdgeInsets.all(m),
            child: imageByUrl(imageUrl, width: w, height: h, alignment: a));
      }
    }

    if (_imageSize == null) {
      image = imageByUrl(imageUrl);
      _imageSize = OptionalSize((image as Image).width, image.height);
    }

    if (!readOnly && base.isMobile()) {
      return GestureDetector(
        onTap: () {
          showResizerControllersStream.add(false);
          showDialog(
            context: context,
            builder: (context) {
              final resizeOption = _SimpleDialogItem(
                icon: Icons.settings_outlined,
                color: Colors.lightBlueAccent,
                text: 'Resize'.i18n,
                onPressed: () {
                  Navigator.pop(context);
                  showResizerControllersStream.add(true);
                },
              );
              final copyOption = _SimpleDialogItem(
                icon: Icons.copy_all_outlined,
                color: Colors.cyanAccent,
                text: 'Copy'.i18n,
                onPressed: () {
                  final imageNode =
                      getEmbedNode(controller, controller.selection.start)
                          .value;
                  final imageUrl = imageNode.value.data;
                  controller.copiedImageUrl =
                      ImageUrl(imageUrl, getImageStyleString(controller));
                  Navigator.pop(context);
                },
              );
              final removeOption = _SimpleDialogItem(
                icon: Icons.delete_forever_outlined,
                color: Colors.red.shade200,
                text: 'Remove'.i18n,
                onPressed: () {
                  final offset =
                      getEmbedNode(controller, controller.selection.start)
                          .offset;
                  controller.replaceText(
                      offset, 1, '', TextSelection.collapsed(offset: offset));
                  Navigator.pop(context);
                },
              );
              return Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: SimpleDialog(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    children: [resizeOption, copyOption, removeOption]),
              );
            },
          );
        },
        child: StreamBuilder(
          stream: showResizerControllersStream.stream,
          builder: (context, snap) {
            return ResizeableWidget(
              child: image,
              initHeight: _imageSize!.width ?? 200,
              initWidth: _imageSize.width ?? 300,
              showHandles: snap.data ?? false,
              onImageResize: (w, h) {
                final res =
                    getEmbedNode(controller, controller.selection.start);
                final attr = base.replaceStyleString(
                    getImageStyleString(controller), w, h);
                controller
                  ..skipRequestKeyboard = true
                  ..formatText(res.offset, 1, StyleAttribute(attr));
              },
            );
          },
        ),
      );
    }

    if (!readOnly || !base.isMobile() || isImageBase64(imageUrl)) {
      return image;
    }

    // We provide option menu for mobile platform excluding base64 image
    return _menuOptionsForReadonlyImage(context, imageUrl, image);
  }
}

class ImageEmbedBuilderWeb extends EmbedBuilder {
  ImageEmbedBuilderWeb({this.constraints})
      : assert(kIsWeb, 'ImageEmbedBuilderWeb is only for web platform');

  final BoxConstraints? constraints;

  @override
  String get key => BlockEmbed.imageType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final imageUrl = node.value.data;

    ui.platformViewRegistry.registerViewFactory(imageUrl, (viewId) {
      return html.ImageElement()
        ..src = imageUrl
        ..style.height = 'auto'
        ..style.width = 'auto';
    });

    return ConstrainedBox(
      constraints: constraints ?? BoxConstraints.loose(const Size(200, 200)),
      child: HtmlElementView(
        viewType: imageUrl,
      ),
    );
  }
}

class VideoEmbedBuilder extends EmbedBuilder {
  VideoEmbedBuilder({this.onVideoInit});

  final void Function(GlobalKey videoContainerKey)? onVideoInit;

  @override
  String get key => BlockEmbed.videoType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    base.Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final videoUrl = node.value.data;
    if (videoUrl.contains('youtube.com') || videoUrl.contains('youtu.be')) {
      return YoutubeVideoApp(
          videoUrl: videoUrl, context: context, readOnly: readOnly);
    }
    return VideoApp(
      videoUrl: videoUrl,
      context: context,
      readOnly: readOnly,
      onVideoInit: onVideoInit,
    );
  }
}

class FormulaEmbedBuilder extends EmbedBuilder {
  @override
  String get key => BlockEmbed.formulaType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    base.Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    assert(!kIsWeb, 'Please provide formula EmbedBuilder for Web');

    final mathController = MathFieldEditingController();
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          // If the MathField is tapped, hides the built in keyboard
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          debugPrint(mathController.currentEditingValue());
        }
      },
      child: MathField(
        controller: mathController,
        variables: const ['x', 'y', 'z'],
        onChanged: (value) {},
        onSubmitted: (value) {},
      ),
    );
  }
}

Widget _menuOptionsForReadonlyImage(
    BuildContext context, String imageUrl, Widget image) {
  return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              final saveOption = _SimpleDialogItem(
                icon: Icons.save,
                color: Colors.greenAccent,
                text: 'Save'.i18n,
                onPressed: () {
                  imageUrl = appendFileExtensionToImageUrl(imageUrl);
                  downloadFile(imageUrl);
                },
              );
              final zoomOption = _SimpleDialogItem(
                icon: Icons.zoom_in,
                color: Colors.cyanAccent,
                text: 'Zoom'.i18n,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageTapWrapper(imageUrl: imageUrl),
                    ),
                  );
                },
              );
              return Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: SimpleDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    children: [saveOption, zoomOption]),
              );
            });
      },
      child: image);
}

Future<bool> downloadFile(String fileUrl) async {
  var directory = await getExternalStorageDirectory();
  if (directory != null) {
    var newPath = '';
    final paths = directory.path.split('/');
    for (var x = 1; x < paths.length; x++) {
      final folder = paths[x];
      if (folder != 'Android') {
        newPath += '/$folder';
      } else {
        break;
      }
    }
    directory = Directory('$newPath/Download');
    try {
      final response = await Dio().download(
        fileUrl,
        '${directory.path}/${DateTime.now()}',
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
  }
  return false;
}

class _SimpleDialogItem extends StatelessWidget {
  const _SimpleDialogItem(
      {required this.icon,
      required this.color,
      required this.text,
      required this.onPressed,
      Key? key})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(icon, size: 36, color: color),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16),
            child:
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
