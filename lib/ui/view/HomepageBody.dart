import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../common/AppEnums.dart';
import '../../media/Media.dart';
import '../controller/HomePageBodyController.dart';
import 'HomeCardView.dart';

class HomepageBody extends StatefulWidget {
  HomePages page_type = HomePages.Home;

  HomepageBody(this.page_type, {Key key}) : super(key: key);

  @override
  HomepageBodyState createState() => HomepageBodyState(this.page_type);
}

class HomepageBodyState extends StateMVC {
  HomePages page_type = HomePages.Home;
  HomePageBodyController _controller;

  HomepageBodyState(this.page_type) : super() {
    _controller = new HomePageBodyController(this.page_type);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Media>>(
        future: _controller.getMedias(context),
        builder: (context, futureData) {
          return futureData.hasData && futureData.data.length != 0
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 2
                          : 3),
                  itemCount: futureData.data.length,
                  itemBuilder: (BuildContext context, int position) {
                    return HomeCardView(futureData.data[position]);
                  },
                )
              : Center(
                  child: futureData.hasData
                      ? Icon(Icons.cancel)
                      : CircularProgressIndicator(),
                );
        });
  }
}
