import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class BackupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup"),
      ),
      body: FutureBuilder(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          return ListView(
            children: <Widget>[
              ListTile(
                onTap: () {},
                title: Text("Backup Source"),
//                subtitle: Text(""),
                leading: Icon(Icons.backup),
              ),
              ListTile(
                onTap: () {},
                title: Text("Restore Source"),
//                subtitle: Text(""),
                leading: Icon(Icons.restore),
              ),
              Divider(),
              ListTile(
                onTap: () {},
                title: Text("Backup Config"),
//                subtitle: Text(""),
                leading: Icon(Icons.backup),
              ),
              ListTile(
                onTap: () {},
                title: Text("Restore Config"),
//                subtitle: Text(""),
                leading: Icon(Icons.restore),
              ),
              Divider(),
              ListTile(
                onTap: () {},
                title: Text("Backup Data"),
                subtitle: Text("Backup history and favorite data."),
                leading: Icon(Icons.backup),
              ),
              ListTile(
                onTap: () {},
                title: Text("Restore Data"),
                subtitle: Text("Restory history and favorite data."),
                leading: Icon(Icons.restore),
              ),
            ],
          );
        },
      ),
    );
  }
}
