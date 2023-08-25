import 'dart:html' as h;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../utils.dart';

class YoutubeVideo extends StatefulWidget {
  const YoutubeVideo(
      {required this.videoUrl, required this.context, required this.readOnly});

  final String videoUrl;
  final BuildContext context;
  final bool readOnly;
  @override
  _YoutubeVideoState createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  @override
  Widget build(BuildContext context) {
    Uri? currentPath;
    final videoId = ytConvertUrlToId(widget.videoUrl);
    if (kIsWeb) {
      currentPath = Uri.parse(h.window.location.href);
    }
    return Container(
      height: 300,
      child: IframeView(
        source:
            'https://www.youtube.com/embed/$videoId?origin=${currentPath!.host}&video-id=$videoId&ps=play&vq=large&rel=0&autohide=1&showinfo=1&autoplay=1',
        allow:
            'accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture',
      ),
    );
  }
}

class IframeView extends StatefulWidget {
  const IframeView({required this.source, super.key, this.allow});
  final String source;
  final String? allow;

  @override
  _IframeViewState createState() => _IframeViewState();
}

class _IframeViewState extends State<IframeView> {
  // Widget _iframeWidget;
  final h.IFrameElement _iframeElement = h.IFrameElement();

  @override
  void initState() {
    super.initState();
    _iframeElement.src = widget.source;
    _iframeElement.style.border = 'none';
    _iframeElement.allow = 'none';

    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      widget.source, //use source as registered key to ensure uniqueness
      (viewId) => _iframeElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(
      key: UniqueKey(),
      viewType: widget.source,
    );
  }
}
