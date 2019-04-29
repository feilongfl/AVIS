import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

import '../../media/Media.dart';

class MediaCardView extends StatelessWidget {
  final Media media;
  final VoidCallback onTap;

  MediaCardView(this.media, {this.onTap}) : super();

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
