import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/HomePageModel.dart';

class HomePageController extends ControllerMVC {
  static int get displaythis => HomePageModel.count;

  static void whatever() => HomePageModel.incre();
}