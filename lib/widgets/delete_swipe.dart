import 'package:flutter/material.dart';

class DeleteSwipe extends StatelessWidget {
  const DeleteSwipe({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: AlignmentDirectional.centerStart,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
