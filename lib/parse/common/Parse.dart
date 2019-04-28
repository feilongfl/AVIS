
import '../../Agent/common/Agent.dart';
import '../../common/AppEnums.dart';
import '../../media/Media.dart';

abstract class Parse {
  String url; // Source URL
  MediaType type;
  String comment; //Source intro
  String updateUrl; // Source Parse Script Update URL
  String author; //Author
  String author_email; //Author e-mail
  String author_website; //Author website or blog

  List<List<Agent>> agents;

  Future<List<Media>> doWork(ParseType type, dynamic argv) async {
    return null;
  }

  Map<String, dynamic> toJson();

  @override
  String toString();


}
