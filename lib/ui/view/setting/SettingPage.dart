import 'package:flutter/material.dart';

import '../../../common/AppRoutes.dart';
import '../../../generated/i18n.dart';

class SettingPage extends StatelessWidget {

  Widget _subSettingTile(BuildContext context, String title, String route,
      IconData icon) {
    return ListTile(
      onTap: () =>
          Navigator.of(context)
              .pushNamed(route),
      title: Text(title),
      leading: Icon(icon),
      trailing: Icon(Icons.arrow_forward),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(S
          .of(context)
          .Settings)),
      body: ListView(
        children: <Widget>[
          _subSettingTile(
              context, "Home Page Tabs", AppRoutes.Settings_HomePageTabs,
              Icons.home),
        ],
      ),
    );
  }
}
