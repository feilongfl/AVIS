import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../common/AppEnums.dart';
import '../../common/AppShareData.dart';
import '../../media/Media.dart';

class SearchResultPage extends StatefulWidget {
  MediaType type;
  String keyword;

  SearchResultPage(this.type, this.keyword, {Key key}) : super(key: key);

  @override
  _SearchResultPageState createState() =>
      _SearchResultPageState(this.type, this.keyword);
}

class _SearchResultPageState extends StateMVC {
  SearchResultPageController searchResultPageController;

  _SearchResultPageState(MediaType type, String keyword) {
    searchResultPageController = new SearchResultPageController(type, keyword);
  }

  @override
  void initState() {
    super.initState();
    // do search Here
    setState(() {
      searchResultPageController.doSearch();
    });
  }

  Widget _searchItem(BuildContext context, int position) {
    var media = searchResultPageController.medias[position];
    return Container(
      padding: EdgeInsets.all(3),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      media.info.cover,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Center(child: Text(media.info.title)),
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text("Search Result"),
        title: Text((searchResultPageController.keyword ??
                AppShareData.defaultKeywords) +
            " (${searchResultPageController.medias.length.toString()})"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
//      body: Text(
//          searchResultPageController.keyword ?? AppShareData.defaultKeywords),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemCount: searchResultPageController.medias.length,
          itemBuilder: (BuildContext context, int position) {
            return _searchItem(context, position);
          }),
    );
  }
}

class SearchResultPageController extends ControllerMVC {
  MediaType type;
  String keyword;
  List<Media> medias = new List();

  SearchResultPageController(MediaType type, String keyword) {
    this.type = type;
    this.keyword = keyword;
  }

  void doSearch() {
    for (int i = 0; i < 20; i++) {
      Media media = Media();
      media.info.title = "demo search";
      media.info.cover = "https://seaside.ebb.io/615x1017.jpg";
      media.info.title += i.toString();
      this.medias.add(media);
    }
  }
}
