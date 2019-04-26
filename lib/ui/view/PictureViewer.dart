import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:photo_view/photo_view.dart';

class PictureViewer extends StatelessWidget {
  final List<String> imageUrl;

  PictureViewer(this.imageUrl, {Key key})
      : assert(imageUrl != null),
        assert(imageUrl != ""),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: AdvancedNetworkImage(
        imageUrl[0], //todo add some pages
        useDiskCache: true,
        cacheRule: CacheRule(maxAge: const Duration(days: 7)),
      ),
    ));
  }
}
