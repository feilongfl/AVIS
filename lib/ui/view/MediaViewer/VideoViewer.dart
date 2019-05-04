import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';
import 'package:video_player/video_player.dart';

import '../../../media/Media.dart';
import '../../../media/MediaChapter.dart';
import '../../../media/MediaEpisode.dart';
import '../../../parse/common/ParseRunner.dart';
import '../../widget/MediaCardView.dart';
import 'common/ViewerState.dart';

class VideoViewer extends ViewerState {
  final Media media;
  final String eposide;
  final String chapter;

  VideoViewer({this.media, this.eposide, this.chapter})
      : assert(media != null),
        super(media: media, eposide: eposide, chapter: chapter);

  Future<Media> _getMedias(BuildContext context,
      {String eposide, String chapter}) async {
    print(
        "get source[${media.info.ID}][${eposide ?? this.eposide}][${chapter ?? this.chapter}]");
    return ParseRunner.runSource(context, media,
        eposideId: eposide ?? this.eposide, chapterId: chapter ?? this.chapter);
  }

  bool loaded = false;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  final videoRatio = 16 / 10;
  final landSplit = 0.6;

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

  Widget _videoPlayer(BuildContext context) {
    return Expanded(
      child: videoPlayerController != null
          ? Chewie(controller: chewieController)
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _videoInfoLand(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * landSplit / 5,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.width * landSplit / videoRatio,
              child: MediaCardView(
                title: media.info.title,
                cover: media.info.cover,
                showTitle: false,
              )),
          Flexible(
            child: Column(
              children: <Widget>[
                Text(
                  media.info.title,
                  style: Theme.of(context).textTheme.title,
                ),
                Divider(),
                Text(
                  media.info.intro,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _videoInfo(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 2.5,
            child: MediaCardView(
              title: media.info.title,
              cover: media.info.cover,
              showTitle: false,
            )),
        SizedBox(width: 10),
        Flexible(
          child: Column(
            children: <Widget>[
              Text(
                media.info.title,
                style: Theme.of(context).textTheme.title,
              ),
              Divider(),
              Text(
                media.info.intro,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _playerMediaListItem(
      BuildContext context, MediaEpisode eposide, MediaChapter chapter) {
    return ListTile(
      title: Text(chapter.info.title),
      subtitle: Text(eposide.info.title),
      onTap: () {
        if (videoPlayerController != null)
          _loadMedia(context,
              eposide: eposide.info.ID, chapter: chapter.info.ID);
      },
    );
  }

  Widget _playerMediaList(BuildContext context) {
    return Expanded(
      child: ListView(
//        scrollDirection: Axis.horizontal,
          children: <Widget>[]..addAll((media.episode.map((ep) => ep.chapter
                  .map((cp) => _playerMediaListItem(context, ep, cp))))
              .expand((w) => w))),
    );
  }

  Widget _port(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[]
          ..add(_videoPlayer(context))
          ..add(_videoInfo(context))
          ..add(_playerMediaList(context)),
      ),
    );
  }

  Widget _land(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * landSplit,
            child: Column(
              children: <Widget>[]
                ..add(_videoPlayer(context))
                ..add(_videoInfoLand(context)),
            ),
          ),
          _playerMediaList(context),
        ],
      ),
    );
  }

  bool loading = false;

  void _loadMedia(BuildContext context, {String eposide, String chapter}) {
//    if (chewieController != null) chewieController.dispose();
//    if (videoPlayerController != null) videoPlayerController.dispose();

    setState(() => loaded = false);
    if (loading) return;
    loading = true;

    _getMedias(context, eposide: eposide, chapter: chapter).then((media) {
      setState(() => loaded = true);
      setState(() => loading = false);
//        this.media.episode[0].chapter[0].info.url =
//            media.episode[0].chapter[0].info.url;
      final oldvideoPlayerController = videoPlayerController;
      videoPlayerController = VideoPlayerController.network(media.episode
          .firstWhere((ep) => ep.info.ID == eposide ?? this.eposide)
          .chapter
          .firstWhere((cp) => cp.info.ID == chapter ?? this.chapter)
          .sources[0]
          .urls[0]);
      oldvideoPlayerController?.dispose();

      final oldchewieController = chewieController;
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: videoRatio,
        autoPlay: true,
        looping: false,
      );
      oldchewieController?.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded)
      _loadMedia(context, eposide: this.eposide, chapter: this.chapter);

    return (MediaQuery.of(context).orientation == Orientation.portrait)
        ? _port(context)
        : _land(context);
  }
}
