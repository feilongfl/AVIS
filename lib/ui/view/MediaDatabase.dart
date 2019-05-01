import 'package:flutter/material.dart';

import '../../common/AppRoutes.dart';
import '../../common/AppShareData.dart';
import '../../media/MediaDataBase.dart';
import '../widget/MediaCardView.dart';

class MediaDataBasePage extends StatefulWidget {
  final String table;

  MediaDataBasePage(this.table)
      : assert(MediaDataBaseProvider.tables.contains(table)),
        super();

  @override
  State<StatefulWidget> createState() => MediaDataBaseState();
}

class MediaDataBaseState extends State<MediaDataBasePage> {
  MediaDataBaseProvider mediadbpri;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<MediaDataBase>> loadData() async {
    if (mediadbpri == null) {
      mediadbpri = MediaDataBaseProvider(this.widget.table);
    }
    if (!mediadbpri.isOpen) await mediadbpri.open();

    return mediadbpri.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.table),
      ),
      body: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) => !snapshot.hasData
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 3
                        : 2),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  MediaDataBase mdb = snapshot.data[index];
                  return MediaCardView(
                    title: mdb.title,
                    cover: mdb.cover,
                    onTap: () => Navigator.of(context).pushNamed(
                        AppRoutes.MediaInfo,
                        arguments:
                            mdb.toMedia(AppShareData.of(context).appParse)),
                  );
                }),
      ),
    );
  }
}
