import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../ParseRunner/ParseRunner.dart';
import '../../common/AppShareData.dart';
import '../../media/Media.dart';
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

  Widget _mediaList(BuildContext context, int index) {
    return Text(
      index.toString(),
      textAlign: TextAlign.center,
    );
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
          child: CustomScrollView(
            shrinkWrap: false,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 10),
              ),
              SliverToBoxAdapter(
                child: _MediaInfoLists(context),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 3
                        : 2,
                    childAspectRatio: 5.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _mediaList(context, index);
                  },
                  childCount: 32,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 20.0),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget port(BuildContext context) {
    return CustomScrollView(
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
        SliverGrid(
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
              return _mediaList(context, index);
            },
            childCount: 31,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 20.0),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    ParseRunner.Info(media).then((m) {
      setState(() {
        this.media = m;
      });
    });
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
