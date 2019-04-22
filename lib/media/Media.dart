import '../common/AppEnums.dart';
import 'MediaEpisode.dart';
import 'MediaInfo.dart';

class Media {
  MediaInfoFull info = new MediaInfoFull();
  MediaType type = MediaType.All;
  String ParseUUID = "";

  List<MediaEpisode> episode = new List();
}
