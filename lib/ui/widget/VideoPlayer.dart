import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final String video_url;

  VideoPlayer(this.video_url, {Key key})
      : assert(video_url != null),
        super(key: key);

  @override
  State<VideoPlayer> createState() => VideoPlayerState(video_url);
}

class VideoPlayerState extends State<VideoPlayer> {
  ChewieController chewieController;
  final String video_url;
  VideoPlayerController videoPlayerController;

  VideoPlayerState(this.video_url) : super();

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(video_url);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 10,
      autoPlay: true,
      looping: false,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: chewieController,
    );
  }
}
