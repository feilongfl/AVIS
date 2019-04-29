import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

import '../../media/Media.dart';

class MediaTileView extends StatelessWidget {
  final Media media;
  final double imageWidthHeight;
  final VoidCallback onTap;

  MediaTileView(this.media, this.imageWidthHeight, {this.onTap}) : super();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 4),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
            child: Container(
                width: imageWidthHeight,
                height: imageWidthHeight,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AdvancedNetworkImage(
                          media.info.cover,
                          useDiskCache: true,
                          cacheRule: CacheRule(maxAge: const Duration(days: 7)),
                        )))),
          ),
          Expanded(
            child: Container(
              height: imageWidthHeight,
              padding: EdgeInsets.only(left: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          media.info.title,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Text(
                        media.info.author.name,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        media.info.intro ?? "",
                        maxLines: 4,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
