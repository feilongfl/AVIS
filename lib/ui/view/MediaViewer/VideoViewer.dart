import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../media/Media.dart';
import 'common/ViewerState.dart';

class VideoViewer extends ViewerState {
  final Media media;
  final String eposide;
  final String chapter;

  VideoViewer({this.media, this.eposide, this.chapter})
      : assert(media != null),
        super(media: media, eposide: eposide, chapter: chapter);

  Future<Media> _getMedias(BuildContext context) async {
    print("get source");
//    return ParseRunner.Source(context, media);
    return Media();
  }

  bool loaded = false;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded)
      _getMedias(context).then((media) {
//        this.media.episode[0].chapter[0].info.url =
//            media.episode[0].chapter[0].info.url;
        videoPlayerController =
            VideoPlayerController.network(media.episode[0].chapter[0].info.url);
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          aspectRatio: 16 / 10,
          autoPlay: true,
          looping: false,
        );
        setState(() => loaded = true);
      });
    return Scaffold(
      appBar: AppBar(
        title: Text(media.info.title),
      ),
      body: loaded
          ? Chewie(controller: chewieController)
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
