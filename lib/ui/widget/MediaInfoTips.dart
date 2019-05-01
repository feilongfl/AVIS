import 'package:flutter/material.dart';

import 'Clock.dart';

class MediaInfoTips extends StatelessWidget {
  final String mediaTitle;
  final String mediaEposideTitle;
  final String mediaChapterTitle;

  MediaInfoTips(
      {this.mediaTitle, this.mediaEposideTitle, this.mediaChapterTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.black26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              mediaTitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                mediaEposideTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                mediaChapterTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: 20,
              ),
              Clock()
            ],
          )
        ],
      ),
    );
  }
}
