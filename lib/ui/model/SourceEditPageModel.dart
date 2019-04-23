import 'package:flutter/material.dart';

import '../../parse/Parse.dart';

class SourceEditPageModel extends InheritedWidget {
  final Parse parse;

  SourceEditPageModel({
    @required this.parse,
    @required Widget child,
  })  : assert(parse != null),
        super(child: child);

  static Parse of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(SourceEditPageModel)
            as SourceEditPageModel)
        .parse;
  }

  @override
  bool updateShouldNotify(SourceEditPageModel oldWidget) =>
      oldWidget.parse != parse;
}
