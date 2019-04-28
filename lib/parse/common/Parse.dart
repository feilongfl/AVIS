import '../event/Event.dart';
import 'ParseAction.dart';
import 'ParseConst.dart';
import 'ParseInfo.dart';

abstract class Parse {
  ParseInfo info;
  ParseType type;
  List<ParseAction> actions;

  Future<List<Event>> doWork(ParseActionType type, List<Event> events) async {}

  Map<String, dynamic> toJson();

  @override
  String toString();
}
