import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogButtons extends StatelessWidget {
  final dynamic controller;
  DialogButtons({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RaisedButton(
          color: ThemeData.dark().accentColor,
          child: Text(
            'Cancel',
            style: TextStyle(color: ThemeData.dark().primaryColor),
          ),
          onPressed: () {
            Get.back();
            // Navigator.pop(context);
          },
        ),
        RaisedButton(
            color: ThemeData.dark().accentColor,
            child: Text(
              'Save',
              style: TextStyle(color: ThemeData.dark().primaryColor),
            ),
            onPressed: () {
              controller.validate();
            }),
      ],
    );
  }
}
