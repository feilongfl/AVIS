import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../media/Media.dart';

class MediaDataBaseConst {
  static const c_id = "id";
  static const c_parseuuid = "parseid";
  static const c_mediaid = "mediaid";
  static const c_title = "title";
  static const c_cover = "cover";
  static const c_intro = "intro";
}

class MediaDataBase {
  final String parseid;
  final String mediaid;
  final String title;
  final String cover;
  final String intro;

  MediaDataBase({
    @required this.title,
    @required this.mediaid,
    @required this.parseid,
    this.intro,
    this.cover,
  });

  Map<String, dynamic> toMap() {
    return {
      MediaDataBaseConst.c_parseuuid: parseid,
      MediaDataBaseConst.c_mediaid: mediaid,
      MediaDataBaseConst.c_title: title,
      MediaDataBaseConst.c_cover: cover,
      MediaDataBaseConst.c_intro: intro,
    };
  }

  static MediaDataBase fromMap(Map<String, dynamic> map,
      {String parse, String media}) {
    return MediaDataBase(
      parseid: parse ?? map[MediaDataBaseConst.c_parseuuid],
      mediaid: media ?? map[MediaDataBaseConst.c_mediaid],
      title: map[MediaDataBaseConst.c_title],
      cover: map[MediaDataBaseConst.c_cover],
      intro: map[MediaDataBaseConst.c_intro],
    );
  }

  static MediaDataBase fromMedia(Media media) {
    return MediaDataBase(
      parseid: media.ParseUUID,
      mediaid: media.info.ID,
      title: media.info.title,
      cover: media.info.cover,
      intro: media.info.intro,
    );
  }
}

class MediaDataBaseProvider {
  Database db;

  final String table;

  static const database = "avis.db";

  static const table_favorite = "favorite";
  static const table_history = "history";
  static const table_download = "download";
  static const table_viewed = "viewed";

  MediaDataBaseProvider(this.table) : assert(table != null);

  Future open() async {
    db = await openDatabase(database, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $table ( 
  ${MediaDataBaseConst.c_id} int primary key autoincrement, 
  ${MediaDataBaseConst.c_parseuuid} text not null,
  ${MediaDataBaseConst.c_mediaid} text not null,
  ${MediaDataBaseConst.c_title} text not null,
  ${MediaDataBaseConst.c_cover} text,
  ${MediaDataBaseConst.c_intro} text,
  )
''');
    });
  }

  static const whereParseAndMedia =
      '${MediaDataBaseConst.c_parseuuid} = ? and ${MediaDataBaseConst.c_mediaid} = ?';

  Future<int> insert(MediaDataBase mediadb) async {
    if (getMediaDB(mediadb.parseid, mediadb.mediaid) != null) {
      return update(mediadb);
    }
    return db.insert(table, mediadb.toMap());
  }

  Future<MediaDataBase> getMediaDB(String parseuuid, String mediaid) async {
    List<Map> maps = await db.query(table,
        columns: [
          MediaDataBaseConst.c_title,
          MediaDataBaseConst.c_cover,
          MediaDataBaseConst.c_intro
        ],
        where: whereParseAndMedia,
        whereArgs: [parseuuid, mediaid]);
    if (maps.length > 0) {
      return MediaDataBase.fromMap(maps.first,
          parse: parseuuid, media: mediaid);
    }
    return null;
  }

  Future<int> delete(String parseuuid, String mediaid) async {
    return db.delete(table,
        where: whereParseAndMedia, whereArgs: [parseuuid, mediaid]);
  }

  Future<int> update(MediaDataBase mediadb) async {
    return db.update(table, mediadb.toMap(),
        where: whereParseAndMedia,
        whereArgs: [mediadb.parseid, mediadb.mediaid]);
  }

  Future close() async => db.close();
}
