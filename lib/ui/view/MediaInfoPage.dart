import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../ParseRunner/ParseRunner.dart';
import '../../common/AppShareData.dart';
import '../../media/Media.dart';
import '../../media/MediaEpisode.dart';
import '../widget/ActionButton.dart';

class MediaInfoPage extends StatefulWidget {
  Media media;

  MediaInfoPage(this.media, {Key key}) : super(key: key);

  @override
  MediaInfoPageState createState() => MediaInfoPageState(this.media);
}

class MediaInfoPageState extends StateMVC {
  Media media;

  MediaInfoPageState(this.media) : super();

  Widget _EpisodeList(BuildContext context, MediaEpisode episode, Media media) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? 3
                  : 2,
          childAspectRatio: 5.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final chapter = episode.chapter[index];
          return OutlineButton(
            child: Text(
              chapter.info.title,
//              textAlign: TextAlign.center,
            ),
            onPressed: () {
              Map<String, dynamic> data = new Map();
              data[AppRoutes.MediaViewArg_Media] = media;
              data[AppRoutes.MediaViewArg_EposideId] = episode.info.ID;
              data[AppRoutes.MediaViewArg_ChapterId] = chapter.info.ID;

              Navigator.of(context)
                  .pushNamed(AppRoutes.MediaView, arguments: data);
            },
          );
        },
        childCount: episode.chapter.length,
      ),
    );
  }

  List<Widget> _mediaList(BuildContext context, Media media) {
    List<Widget> widgets = new List();

    media.episode.forEach((e) {
      widgets.add(SliverToBoxAdapter(
          child: Text(
        e.info.title,
        textAlign: TextAlign.center,
      )));
      widgets.add(
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 10),
        ),
      );
      widgets.add(_EpisodeList(context, e, media));
    });

    return widgets;
  }

  Widget _CoverView(BuildContext context) {
    final image_width =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.width / 3
            : MediaQuery.of(context).size.width * 0.6;
    final image_height = image_width * 1.25;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
          height: image_height,
          width: image_width,
          child: Image(
            image: AdvancedNetworkImage(
              media.info.cover,
              useDiskCache: true,
              cacheRule: CacheRule(maxAge: const Duration(days: 7)),
            ),
          )),
    );
  }

  Widget _MediaInfoLists(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
//              mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          media.info.title,
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ),
        Text(
          media.info.author ?? "loading author ...",
          textAlign: TextAlign.center,
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
            media.info.intro ?? "loading intro ...",
            textAlign: TextAlign.left,
          ),
        ),
        Divider(),
//        _mediaList(context),
      ],
    );
  }

  Widget land(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _CoverView(context),
//        Flexible(child: SingleChildScrollView(child: _MediaInfoLists(context))),
        Flexible(
          child: FutureBuilder(
              future: getMediaFuture(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? CustomScrollView(
                        shrinkWrap: false,
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.only(top: 10),
                          ),
                          SliverToBoxAdapter(
                            child: _MediaInfoLists(context),
                          ),
                        ]
                          ..addAll(
                            _mediaList(context, snapshot.data),
                          )
                          ..add(SliverPadding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                          )),
                      )
                    : CustomScrollView(
                        shrinkWrap: false,
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.only(top: 10),
                          ),
                          SliverToBoxAdapter(
                            child: _MediaInfoLists(context),
                          ),
                        ]
                          ..add(SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ))
                          ..add(SliverPadding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                          )),
                      );
              }),
        ),
      ],
    );
  }

  Widget port(BuildContext context) {
    return FutureBuilder(
      future: getMediaFuture(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? CustomScrollView(
                shrinkWrap: false,
                slivers: [
                  SliverToBoxAdapter(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _CoverView(context),
                    ],
                  )),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  SliverToBoxAdapter(
                    child: _MediaInfoLists(context),
                  ),
                ]
                  ..addAll(
                    _mediaList(context, snapshot.data),
                  )
                  ..add(SliverPadding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                  )),
              )
            : CustomScrollView(
                shrinkWrap: false,
                slivers: [
                  SliverToBoxAdapter(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _CoverView(context),
                    ],
                  )),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  SliverToBoxAdapter(
                    child: _MediaInfoLists(context),
                  ),
                ]
                  ..add(
                    SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                  ..add(SliverPadding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                  )),
              );
      },
    );
  }

  Future<Media> getMediaFuture() async {
    Media mediaResult = await ParseRunner.Info(this.media);
    mediaResult = await ParseRunner.Episode(mediaResult);
    mediaResult = await ParseRunner.Chapter(mediaResult);

    return mediaResult;
  }

  @override
  void initState() {
    super.initState();
  }

  List<ActionButton> appBarActions = [
    ActionButton(
        name: "Search title",
        icon: Icons.search,
        action: (BuildContext context, Media media) {
          Navigator.of(context).pushNamed(AppRoutes.SearchResult, arguments: {
            AppRoutes.SearchResultArg_type: media.type,
            AppRoutes.SearchResultArg_keyword: media.info.title
          });
        }),
    ActionButton(name: "Share", icon: Icons.share, action: () {}),
    ActionButton(
        name: "Download", icon: Icons.file_download, hide: true, action: () {}),
    ActionButton(
        name: "Search Author",
        icon: Icons.people,
        hide: true,
        action: (BuildContext context, Media media) {
          Navigator.of(context).pushNamed(AppRoutes.SearchResult, arguments: {
            AppRoutes.SearchResultArg_type: media.type,
            AppRoutes.SearchResultArg_keyword: media.info.author
          });
        }),
  ];

  List<Widget> _genActions(BuildContext context) {
    List<Widget> w = <Widget>[]..addAll(appBarActions
        .where((action) => (!action.hide ||
            MediaQuery.of(context).orientation == Orientation.landscape))
        .map((action) => IconButton(
              icon: Icon(action.icon),
              tooltip: action.name,
              onPressed: () => action.action(context, media),
            ))
        .toList());
    if (MediaQuery.of(context).orientation == Orientation.portrait)
      w.add(
        PopupMenuButton(
            itemBuilder: (context) => appBarActions
                .where((action) => action.hide)
                .map((action) => PopupMenuItem(
                        child: ListTile(
                      leading: Icon(action.icon),
                      title: Text(action.name),
                      onTap: () => action.action(context, media),
                    )))
                .toList()),
      );
    return w;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(media.info.title),
        actions: _genActions(context),
      ),
      body: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          child: MediaQuery.of(context).orientation == Orientation.landscape
              ? land(context)
              : port(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.favorite_border), onPressed: () {}),
    );
  }
}
