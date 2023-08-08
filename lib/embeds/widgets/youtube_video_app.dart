import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/embeds/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:html' as h;
import 'dart:ui' as ui;

class YoutubeVideoApp extends StatefulWidget {
  const YoutubeVideoApp(
      {required this.videoUrl, required this.context, required this.readOnly});

  final String videoUrl;
  final BuildContext context;
  final bool readOnly;

  @override
  _YoutubeVideoAppState createState() => _YoutubeVideoAppState();
}

class _YoutubeVideoAppState extends State<YoutubeVideoApp> {
  var _youtubeController;

  @override
  void initState() {
    super.initState();
    final videoId = ytConvertUrlToId(widget.videoUrl);
    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Uri? currentPath;
    if (kIsWeb) {
      currentPath = Uri.parse(h.window.location.href);
    }
    final defaultStyles = DefaultStyles.getInstance(context);
    if (_youtubeController == null) {
      if (widget.readOnly) {
        return RichText(
          text: TextSpan(
              text: widget.videoUrl,
              style: defaultStyles.link,
              recognizer: TapGestureRecognizer()
                ..onTap = () => launchUrl(Uri.parse(widget.videoUrl))),
        );
      }

      return RichText(
          text: TextSpan(text: widget.videoUrl, style: defaultStyles.link));
    }

    return Container(
      height: 300,
      child: kIsWeb
          ? IframeView(
              source:
                  'https://www.youtube.com/embed/${ytConvertUrlToId(widget.videoUrl)}?origin=${currentPath!.host}&video-id=${ytConvertUrlToId(widget.videoUrl)}&ps=play&vq=large&rel=0&autohide=1&showinfo=1&autoplay=1',
              allow:
                  'accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture',
            )
          : YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _youtubeController,
                showVideoProgressIndicator: true,
              ),
              builder: (context, player) {
                return Column(
                  children: [
                    // some widgets
                    player,
                    //some other widgets
                  ],
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _youtubeController.dispose();
  }
}

class IframeView extends StatefulWidget {
  final String source;
  final String? allow;
  const IframeView({super.key, required this.source, this.allow});

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
      (int viewId) => _iframeElement,
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
