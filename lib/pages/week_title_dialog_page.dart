import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/week_title_controller.dart';
import '../widgets/dialog_buttons.dart';

class WeekTitleDialog {
  final WeekTitleController wtc = Get.find();

  Widget buildDialog() {
    return AlertDialog(
        title: Obx(
          () => Text((wtc.isNew.value) ? 'New Week' : 'Edit Week'),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Form(
            key: wtc.formKey.value,
            child: Column(children: <Widget>[
              TextFormField(
                  validator: (value) => wtc.validator(value),
                  textCapitalization: TextCapitalization.words,
                  initialValue: wtc.initialValue(),
                  onChanged: wtc.txtWeekNum,
                  decoration: InputDecoration(hintText: 'Week Title')),
              SizedBox(height: 10),
              DialogButtons(controller: wtc),
            ]),
          ),
        ));
  }
}
