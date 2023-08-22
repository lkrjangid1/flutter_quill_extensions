import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final defaultStyles = DefaultStyles.getInstance(context);
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
}
