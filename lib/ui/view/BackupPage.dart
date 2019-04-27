import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../generated/i18n.dart';

class BackupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Backup),
      ),
      body: FutureBuilder(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          return ListView(
            children: <Widget>[
              ListTile(
                onTap: () {},
                title: Text(S.of(context).Backup_Source),
//                subtitle: Text(""),
                leading: Icon(Icons.backup),
              ),
              ListTile(
                onTap: () {},
                title: Text(S.of(context).Restory_Source),
//                subtitle: Text(""),
                leading: Icon(Icons.restore),
              ),
              Divider(),
              ListTile(
                onTap: () {},
                title: Text(S.of(context).Backup_config),
//                subtitle: Text(""),
                leading: Icon(Icons.backup),
              ),
              ListTile(
                onTap: () {},
                title: Text(S.of(context).Restory_config),
//                subtitle: Text(""),
                leading: Icon(Icons.restore),
              ),
              Divider(),
              ListTile(
                onTap: () {},
                title: Text(S.of(context).Backup_Data),
                subtitle: Text(S.of(context).Backup_Data_Summary),
                leading: Icon(Icons.backup),
              ),
              ListTile(
                onTap: () {},
                title: Text(S.of(context).Restory_Data),
                subtitle: Text(S.of(context).Restory_Data_Summary),
                leading: Icon(Icons.restore),
              ),
            ],
          );
        },
      ),
    );
  }
}
