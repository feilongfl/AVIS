import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../common/AppRoutes.dart';
import '../../common/AppShareData.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: FutureBuilder(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          return ListView(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColorLight,
                padding:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? EdgeInsets.only(top: 30, bottom: 20)
                        : EdgeInsets.only(top: 70, bottom: 50),
                child: Center(
                  child: (!snapshot.hasData)
                      ? CircularProgressIndicator()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              snapshot.data.appName,
                              style: TextStyle(fontSize: 32),
                            ),
                            Text(
                                '${snapshot.data.version} (${snapshot.data.buildNumber})'),
                          ],
                        ),
                ),
              ),
              ListTile(
                onTap: () => AppRoutes.LaunchURL(AppShareData.FEILONGBLOG),
                title: Text(AppShareData.FEILONG),
                subtitle: Text(AppShareData.FEILONGBLOG),
                leading: Icon(Icons.portrait),
              ),
              ListTile(
                onTap: () => AppRoutes.LaunchURL(AppShareData.GITHUB),
                title: Text("Github"),
                subtitle: Text(AppShareData.GITHUB),
                leading: Icon(Icons.cake),
              ),
              ListTile(
                onTap: () => AppRoutes.LaunchURL(AppShareData.GITHUBRELEASE),
                title: Text("Release"),
                subtitle: Text(AppShareData.GITHUBRELEASE),
                leading: Icon(Icons.file_download),
              ),
            ],
          );
        },
      ),
    );
  }
}
