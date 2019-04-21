import 'package:mvc_pattern/mvc_pattern.dart';

import '../../ParseRunner/ParseRunner.dart';
import '../../common/AppEnums.dart';
import '../../media/Media.dart';

class HomePageBodyController extends ControllerMVC {
  HomePages page_type;

  HomePageBodyController(this.page_type);

  Future<List<Media>> getMedias() async {
    return ParseRunner.Homepage(page_type);
  }
}
