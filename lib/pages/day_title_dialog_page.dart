import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/day_title_controller.dart';
import '../widgets/dialog_buttons.dart';

class DayTitleDialog {
  final DayTitleController dtc = Get.find();

  Widget buildDialog() {
    return AlertDialog(
        title: Obx(
          () => Text((dtc.isNew.value) ? 'New Day' : 'Edit Day'),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Form(
            key: dtc.formKey.value,
            child: Column(children: <Widget>[
              TextFormField(
                  validator: (value) => dtc.validator(value),
                  textCapitalization: TextCapitalization.words,
                  initialValue: dtc.initialValue(),
                  onChanged: dtc.txtDayNum,
                  decoration: InputDecoration(hintText: 'Day Title')),
              SizedBox(height: 10),
              DialogButtons(controller: dtc),
            ]),
          ),
        ));
  }
}
