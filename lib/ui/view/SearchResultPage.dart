//import 'package:flutter/material.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
//import 'package:mvc_pattern/mvc_pattern.dart';
//
//import '../../common/AppEnums.dart';
//import '../../common/AppRoutes.dart';
//import '../../generated/i18n.dart';
//import '../../media/Media.dart';
//import '../../parse/ParseRunner/ParseRunner.dart';
//
//class SearchResultPage extends StatefulWidget {
//  final MediaType type;
//  final String keyword;
//
//  SearchResultPage(this.type, this.keyword, {Key key}) : super(key: key);
//
//  @override
//  _SearchResultPageState createState() =>
//      _SearchResultPageState(this.type, this.keyword);
//}
//
//class _SearchResultPageState extends StateMVC {
//  SearchResultPageController searchResultPageController;
//
//  _SearchResultPageState(MediaType type, String keyword) {
//    searchResultPageController = new SearchResultPageController(type, keyword);
//  }
//
////  @override
////  void initState() {
////    super.initState();
////    // do search Here
////    setState(() {
////      searchResultPageController.doSearch();
////    });
////  }
//
//  Widget _searchItem(BuildContext context, Media media) {
//    if (media == null) return Text("load failed");
//
//    final image_width = MediaQuery.of(context).size.width / 3;
//    final image_height = image_width * 0.75;
//    return GestureDetector(
//      onTap: () => Navigator.of(context)
//          .pushNamed(AppRoutes.MediaInfo, arguments: media),
//      child: Row(
//        children: <Widget>[
//          Card(
//            clipBehavior: Clip.antiAlias,
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(10.0),
//            ),
//            child: Container(
//                height: image_height,
//                width: image_width,
//                child: Image(
//                  image: AdvancedNetworkImage(
//                    media.info.cover,
//                    useDiskCache: true,
//                    cacheRule: CacheRule(maxAge: const Duration(days: 7)),
//                  ),
//                  fit: BoxFit.cover,
//                )),
//          ),
//          Expanded(
//            child: Container(
//              padding: EdgeInsets.only(right: 5),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.start,
//                crossAxisAlignment: CrossAxisAlignment.end,
//                children: <Widget>[
//                  Text(
//                    media.info.title,
//                    style: TextStyle(fontSize: 30),
//                  ),
//                  Text(media.info.isFinished
//                      ? S.of(context).finishTip_isFin
//                      : S.of(context).finishTip_notFin),
//                  Padding(
//                    padding: EdgeInsets.only(top: 30),
//                  ),
//                  Text(media.info.author),
////                Text(media.info.date.toString()),
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
////        title: Text("Search Result"),
//        title: Text((searchResultPageController.keyword ??
//            S.of(context).defaultKeywords)),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.settings),
//            onPressed: () {},
//          )
//        ],
//      ),
////      body: Text(
////          searchResultPageController.keyword ?? AppShareData.defaultKeywords),
////      body: GridView.builder(
////          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
////            crossAxisCount: 2,
////            childAspectRatio: 1,
////          ),
////          itemCount: searchResultPageController.medias.length,
////          itemBuilder: (BuildContext context, int position) {
////            return _searchItem(context, position);
////          }),
////      body: ListView.builder(
////          itemCount: searchResultPageController.medias.length,
////          itemBuilder: (BuildContext context, int position) {
////            return _searchItem(context, position);
////          }),
//      body: FutureBuilder<List<Media>>(
//          future: searchResultPageController.doSearch(context),
//          builder: (context, futureData) {
//            return futureData.hasData && futureData.data.length != 0
//                ? ListView.builder(
//                    itemCount: futureData.data.length,
//                    itemBuilder: (BuildContext context, int position) {
//                      return _searchItem(context, futureData.data[position]);
//                    },
//                  )
//                : Center(
//                    child: CircularProgressIndicator(),
//                  );
//          }),
//    );
//  }
//}
//
//class SearchResultPageController extends ControllerMVC {
//  MediaType type;
//  String keyword;
//
//  SearchResultPageController(MediaType type, String keyword) {
//    this.type = type;
//    this.keyword = keyword;
//  }
//
//  Future<List<Media>> doSearch(BuildContext context) async {
//    return ParseRunner.Search(context, this.keyword, this.type);
//  }
//}
