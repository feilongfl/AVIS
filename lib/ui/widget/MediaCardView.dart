import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

import '../../common/AppRoutes.dart';
import '../../media/Media.dart';
import '../../parse/common/Parse.dart';
import '../../parse/common/ParseConst.dart';
import '../../parse/common/ParseRunner.dart';

class MediaCardView extends StatelessWidget {
  Media media;

  MediaCardView(this.media) : super();

  void _onTap(BuildContext context) {
    Parse parse = ParseRunner.findParse(context, media);
    if (parse == null) return;

    // no eposide and no chapter direct to source
    if (parse.actions[ParseActionType.Info.index].agents.length == 0 &&
        parse.actions[ParseActionType.Eposide.index].agents.length == 0 &&
        parse.actions[ParseActionType.Chapter.index].agents.length == 0) {
      Navigator.of(context).pushNamed(AppRoutes.MediaView,
          arguments: {AppRoutes.MediaViewArg_Media: this.media});
    } else {
      Navigator.of(context)
          .pushNamed(AppRoutes.MediaInfo, arguments: this.media);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Padding(
        padding: EdgeInsets.all(3),
        child: GestureDetector(
          onTap: () => _onTap(context),
          child: ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AdvancedNetworkImage(
                              media.info.cover,
                              useDiskCache: true,
                              cacheRule:
                                  CacheRule(maxAge: const Duration(days: 7)),
                            )))),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            color: Colors.black45,
                            child: Text(
                              media.info.title,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
