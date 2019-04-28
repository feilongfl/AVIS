import '../../Agent/common/Agent.dart';
import '../../common/AppEnums.dart';
import '../../media/Media.dart';
import 'ParseConst.dart';
import 'ParseInfo.dart';

abstract class Parse {
  ParseInfo info;
  ParseType type;
  ParseActionType action;

  List<List<Agent>> agents;

  Future<List<Media>> doWork(ParseType type, dynamic argv) async {
    return null;
  }

  Map<String, dynamic> toJson();

  @override
  String toString();
}
