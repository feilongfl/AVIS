import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../common/AppRoutes.dart';
import '../../../common/AppShareData.dart';
import '../../../generated/i18n.dart';
import '../homepage/HomepageTabItem.dart';

class HomePageTabsSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageTabsSettingState();
}

class HomePageTabsSettingState extends StateMVC {
  Widget _ItemTile(BuildContext context, HomepageTabItem item) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.uuid),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).pushNamed(
                  AppRoutes.Settings_HomePageTabs_edit,
                  arguments: item)),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => setState(
                  () => AppShareData.of(context).homepageTabItem_remove(item))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page Settings"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context)
                .pushNamed(AppRoutes.Settings_HomePageTabs_edit)
                .then((hs) => setState(
                    () => AppShareData.of(context).homepageTabItem_add(hs)))),
      ),
      body: ListView(
        children: <Widget>[]..addAll(
            AppShareData.of(context).homepageTabItems.length == 0
                ? [
                    ListTile(
                      title: Text(S.of(context).NULL),
                    )
                  ]
                : AppShareData.of(context)
                    .homepageTabItems
                    .map((h) => _ItemTile(context, h))),
      ),
    );
  }
}
