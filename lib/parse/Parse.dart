import '../Agent/Agent.dart';
import '../media/Media.dart';

enum ParseType {
  Search,
  info,
  Episode,
  Chapter,
  Source,
  SourceLazy,
  All,
}

class Parse {
  static String ParseUUID;
  static String name;

  List<List<Agent>> agents;

  Future<List<Media>> doWork(ParseType type) async {}
}
