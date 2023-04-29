import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/widgets/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyVideoPlayerDialog extends StatelessWidget {
  final String url;

  MyVideoPlayerDialog({Key key, this.url = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            child: MyVideoPlayer(url: url),
          ),
        ),
      ),
    );
  }
}