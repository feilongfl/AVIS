import 'package:flutter/material.dart';

import '../../common/AppShareData.dart';
import '../../media/Media.dart';

class HomeCardView extends StatelessWidget {
  Media media;

  HomeCardView(this.media) : super();

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Padding(
        padding: EdgeInsets.all(3),
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(AppRoutes.MediaInfo, arguments: this.media),
          child: ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
//        fit: StackFit.expand,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              media.info.cover,
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
