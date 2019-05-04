import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';
import 'package:video_player/video_player.dart';

import '../../../media/Media.dart';
import '../../../parse/common/ParseRunner.dart';
import 'common/ViewerState.dart';

class VideoViewer extends ViewerState {
  final Media media;
  final String eposide;
  final String chapter;

  VideoViewer({this.media, this.eposide, this.chapter})
      : assert(media != null),
        super(media: media, eposide: eposide, chapter: chapter);

  Future<Media> _getMedias(BuildContext context) async {
    print("get source[${media.info.ID}][$eposide][$chapter]");
    return ParseRunner.runSource(context, media,
        eposideId: eposide, chapterId: chapter);
  }

  bool loaded = false;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Screen.keepOn(true);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    if (videoPlayerController != null) videoPlayerController.dispose();
    if (chewieController != null) chewieController.dispose();
    Screen.keepOn(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded)
      _getMedias(context).then((media) {
        setState(() => loaded = true);
//        this.media.episode[0].chapter[0].info.url =
//            media.episode[0].chapter[0].info.url;
        videoPlayerController = VideoPlayerController.network(media.episode
            .firstWhere((ep) => ep.info.ID == eposide)
            .chapter
            .firstWhere((cp) => cp.info.ID == chapter)
            .sources[0]
            .urls[0]);
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          aspectRatio: 16 / 10,
          autoPlay: true,
          looping: false,
        );
      });
    return Scaffold(
//      appBar: AppBar(
//        title: Text(media.info.title),
//      ),
      body: videoPlayerController != null
          ? Chewie(controller: chewieController)
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
