import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:photo_view/photo_view.dart';

class ImageCard extends StatelessWidget {
  final String url;
  final Map<String, String> header;

//  final double defaultHeight;
  static double lastHeight = 1600;

  ImageCard(this.url, {this.header}) : super();

  ImageProvider _advancedNetworkImage;

  Future<ui.Image> getImage(String url) async {
    Completer<ui.Image> completer = new Completer<ui.Image>();
    _advancedNetworkImage = AdvancedNetworkImage(
      url,
      useDiskCache: true,
      cacheRule: CacheRule(maxAge: const Duration(days: 7)),
      fallbackAssetImage: "assets/images/imageLoadFailed.jpg",
      header: header,
    );
    _advancedNetworkImage.resolve(new ImageConfiguration()).addListener(
        (ImageInfo info, bool _) => completer.complete(info.image));
    return completer.future;
  }

  Widget dynamicHeightBuilder(BuildContext context, AsyncSnapshot snapshot) {
    if (!snapshot.hasData) {
      return Container(
        height: lastHeight,
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    } else {
      lastHeight = snapshot.data.height *
          (MediaQuery.of(context).size.width / snapshot.data.width);
      return Container(
          height: lastHeight,
          child: PhotoView(
            imageProvider: _advancedNetworkImage,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImage(url.replaceAll(r"\", '')),
      builder: dynamicHeightBuilder,
    );
  }
}
