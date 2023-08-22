import 'package:flutter/material.dart';

import 'yt_not_support.dart'
    if (dart.library.io) 'yt_app.dart'
    if (dart.library.html) 'yt_web.dart';

class YoutubeVideoApp extends StatelessWidget {
  const YoutubeVideoApp(
      {required this.videoUrl, required this.context, required this.readOnly});

  final String videoUrl;
  final BuildContext context;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return YoutubeVideo(
      videoUrl: videoUrl,
      context: context,
      readOnly: readOnly,
    );
  }
}
