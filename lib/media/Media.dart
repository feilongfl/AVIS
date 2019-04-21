import '../common/AppEnums.dart';
import 'MediaEposide.dart';
import 'MediaInfo.dart';

class Media {
  MediaInfoFull info = new MediaInfoFull();
  MediaType type = MediaType.All;
  String ParseUUID = "";

  List<MediaEposide> eposide = new List();
}
