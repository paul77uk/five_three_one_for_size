import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/exercise__group_title_controller.dart';
import '../widgets/dialog_buttons.dart';

class ExerciseGroupTitleDialog {
  final ExerciseGroupTitleController egtc = Get.find();

  Widget buildDialog() {
    return AlertDialog(
        title: Obx(
          () => Text((egtc.isNew.value)
              ? 'New Exercise Group'
              : 'Edit Exercise Group'),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Form(
            key: egtc.formKey.value,
            child: Column(children: <Widget>[
              TextFormField(
                  validator: (value) => egtc.validator(value),
                  textCapitalization: TextCapitalization.words,
                  initialValue: egtc.initialValue(),
                  onChanged: egtc.txtExerciseGroupTitle,
                  decoration: InputDecoration(hintText: 'Day Title')),
              SizedBox(height: 10),
              DialogButtons(controller: egtc),
            ]),
          ),
        ));
  }
}
