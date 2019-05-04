import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

import '../../common/AppRoutes.dart';
import '../../media/Media.dart';
import '../../parse/common/Parse.dart';
import '../../parse/common/ParseConst.dart';
import '../../parse/common/ParseRunner.dart';

class MediaCardView extends StatelessWidget {
//  final Media media;
  final String title;
  final String cover;
  final VoidCallback onTap;
  final bool showTitle;

  MediaCardView({this.title, this.cover, this.onTap, this.showTitle = true})
      : super();

  void _onTap(BuildContext context, Media media) {
    Parse parse = ParseRunner.findParse(context, media);
    if (parse == null) return;

    // no eposide and no chapter direct to source
    if (parse.actions[ParseActionType.Info.index].agents.length == 0 &&
        parse.actions[ParseActionType.Eposide.index].agents.length == 0 &&
        parse.actions[ParseActionType.Chapter.index].agents.length == 0) {
      Navigator.of(context).pushNamed(AppRoutes.MediaView,
          arguments: {AppRoutes.MediaViewArg_Media: media});
    } else {
      Navigator.of(context).pushNamed(AppRoutes.MediaInfo, arguments: media);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: cover == null
                                ? ExactAssetImage(
                                    "assets/images/imageLoadFailed.jpg")
                                : AdvancedNetworkImage(
                                    cover,
                                    useDiskCache: true,
                                    cacheRule: CacheRule(
                                        maxAge: const Duration(days: 7)),
                                  )))),
                Visibility(
                  visible:
                      this.showTitle || this.title == "" || this.title == null,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              color: Colors.black45,
                              child: Text(
                                title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
