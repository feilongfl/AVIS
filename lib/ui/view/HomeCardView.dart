import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

import '../../common/AppEnums.dart';
import '../../common/AppRoutes.dart';
import '../../media/Media.dart';
//import '../../parse/ParseRunner/ParseRunner.dart';
import '../../parse/common/Parse.dart';

class HomeCardView extends StatelessWidget {
  Media media;

  HomeCardView(this.media) : super();

  void _onTap(BuildContext context) {
//    Parse parse = ParseRunner.findParse(context, media);
//    if (parse == null) return;
//
//    if (parse.agents[ParseType.Episode.index].length == 0 &&
//        parse.agents[ParseType.Chapter.index].length == 0) {
//      Navigator.of(context).pushNamed(AppRoutes.MediaView,
//          arguments: {AppRoutes.MediaViewArg_Media: this.media});
//    } else {
//      Navigator.of(context)
//          .pushNamed(AppRoutes.MediaInfo, arguments: this.media);
//    }
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
