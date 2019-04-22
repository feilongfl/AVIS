import '../common/AppEnums.dart';
import 'MediaInfo.dart';

class MediaChapter {
  int index = 0;
  String chapterId = "";
  MediaInfo info = MediaInfo();

  MediaType type = MediaType.Image;

  MediaChapter({this.info, this.index, this.type, this.chapterId});
}
