import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyVideoPlayer extends StatefulWidget {
  final String url;

  MyVideoPlayer({Key key, this.url = ""}) : super(key: key);

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    String videoId = widget.url;
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller != null
          ? YoutubePlayer(
              aspectRatio: 16 / 9,
              controller: _controller,
              showVideoProgressIndicator: true,
            )
          : Text('Invalid Google Drive file link'),
    );
  }

  @override
  void dispose() {
    _controller.toggleFullScreenMode();
    _controller?.dispose();
    super.dispose();
  }
}
