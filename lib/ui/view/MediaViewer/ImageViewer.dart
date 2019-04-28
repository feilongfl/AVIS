import '../../../media/Media.dart';
import 'common/ViewerState.dart';

class ImageViewer extends ViewerState {
  final Media media;
  final String eposide;
  final String chapter;

  ImageViewer({this.media, this.eposide, this.chapter})
      : assert(media != null),
        super(media: media, eposide: eposide, chapter: chapter);

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text(media.info.title),
//        ),
//        body: CircularProgressIndicator());
//  }
}
