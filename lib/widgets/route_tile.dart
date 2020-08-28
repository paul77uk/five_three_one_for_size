import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteTile extends StatelessWidget {
  final String title;
  final Widget route;
  final IconData icon;

  const RouteTile({
    Key key,
    this.title,
    this.route,
    this.icon = Icons.navigate_next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Opacity(
            opacity: 0.0,
            child: Icon(Icons.navigate_next),
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: route != null
              ? Icon(icon)
              : Opacity(
                  opacity: 0.0,
                  child: Icon(Icons.navigate_next),
                ),
          onTap: () => route != null
              ? Get.to(route)
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => route),
              //   )
              : null,
        ),
        Divider(
          height: 0.5,
        ),
      ],
    );
  }
}
