import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/program_title_controller.dart';
import '../widgets/dialog_buttons.dart';

class ProgramTitleDialog {
  final ProgramTitleController ptc = Get.find();

  Widget buildDialog() {
    return AlertDialog(
        title: Obx(
          () => Text((ptc.isNew.value) ? 'New Program' : 'Edit Program'),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Form(
            key: ptc.formKey.value,
            child: Column(children: <Widget>[
              TextFormField(
                  validator: (value) => ptc.validator(value),
                  textCapitalization: TextCapitalization.words,
                  initialValue: ptc.initialValue(),
                  onChanged: ptc.txtTitle,
                  decoration: InputDecoration(hintText: 'Program Title')),
              SizedBox(height: 10),
              DialogButtons(controller: ptc),
            ]),
          ),
        ));
  }
}
