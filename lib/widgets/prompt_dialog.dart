import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromptDialog extends StatelessWidget {
  PromptDialog({
    Key key,
    this.index,
    this.onPressed,
  }) : super(key: key);

  final int index;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure you want to delete"),
      actions: <Widget>[
        FlatButton(
            child: Text(
              "Ok",
              // style: TextStyle(color: ThemeData.dark().accentColor),
            ),
            onPressed: onPressed),
        FlatButton(
          child: Text(
            'Cancel',
            // style: TextStyle(color: ThemeData.dark().accentColor),
          ),
          onPressed: () {
            // Dismiss the dialog but don't
            // dismiss the swiped item
            // programDaoBloc.getProgramsFromDb();

            Get.back();
          },
        )
      ],
    );
  }
}
