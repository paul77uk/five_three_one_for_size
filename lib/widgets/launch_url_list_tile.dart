import 'package:flutter/material.dart';

import 'launch_url.dart';

class LaunchUrlListTile extends StatelessWidget {
  final String title;
  final String url;
  final IconData icon;

  const LaunchUrlListTile({
    Key key,
    this.title,
    this.url,
    this.icon = Icons.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LaunchUrl(
          child: ListTile(
            leading: Opacity(
              opacity: 0,
              child: Icon(Icons.link),
            ),
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            trailing: Icon(icon),
          ),
          url: url,
        ),
        Divider(height: 0.5),
      ],
    );
  }
}
