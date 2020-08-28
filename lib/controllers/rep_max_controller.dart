import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/rep_max.dart';
import '../util/rep_max_db.dart';

class RepMaxController extends GetxController {
  RxString txtLift = ''.obs;
  RxString txtRepMax = ''.obs;
  RxString txtTrainingMax = ''.obs;
  RxList repMaxModelList = List<RepMaxModel>().obs;
  Rx repMaxModel = RepMaxModel(0, '', '', '').obs;

  RxBool isNew = false.obs;
  // RxBool checkBoxState = false.obs;
  // Rx dayTitleModel = DayTitleModel(0, 0, '', '').obs;
  Rx formKey = GlobalKey<FormState>().obs;

  RepMaxDb db = RepMaxDb();

  deleteRepMax(int index) {
    db.deleteRepMax(repMaxModelList[index]).then((result) {
      showData();
    });
  }

  Future showData() async {
    await db.openDb();
    repMaxModelList.value = await db.getRepMaxes();
  }

  newOrEdit() {
    if (isNew.value) {
      repMaxModel.value = RepMaxModel(0, '', '', '');
    }

    repMaxModel.value.lift = txtLift.value;
    repMaxModel.value.repMax = txtRepMax.value;
    repMaxModel.value.trainingMax = txtTrainingMax.value;

    db.insertRepMax(repMaxModel.value);

    showData();
  }

  validate() {
    if (formKey.value.currentState.validate()) {
      newOrEdit();
      Get.back();
    }
  }

  String liftValidator(value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String validateRepMax(String value) {
    final repMaxRegex = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
    if (value.isEmpty) {
      return 'Enter starting 1 rep max';
    } else if (!repMaxRegex.hasMatch(value)) {
      return 'Enter a valid number';
    }
    return null;
  }

  String validateTrainingMax(String value) {
    final repMaxRegex = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
    final bodyweightText = RegExp('BW', dotAll: true);
    if (value.isEmpty) {
      return 'Enter starting training max percentage or BW';
    } else if (!repMaxRegex.hasMatch(value) &&
        !bodyweightText.hasMatch(value)) {
      return 'Enter a valid number or BW';
    }
    return null;
  }

  editRepMax(int index) {
    repMaxModel(repMaxModelList[index]);
    isNew(false);
  }

  // updateCheckbox(bool newValue, int index) {
  //   checkBoxState(newValue);
  //   exerciseGroupTitleModel(exerciseGroupTitleModelList[index]);

  //   checkBoxState.value == true
  //       ?
  //       // programTitleModelList[index].currentProgram == 'false'?
  //       exerciseGroupTitleModel.value.currentExerciseGroup = 'true'
  //       : exerciseGroupTitleModel.value.currentExerciseGroup = 'false';

  //   db.insertExerciseGroupTitle(exerciseGroupTitleModel.value);
  //   showData();
  // }

  // bool checkboxValue(int index) {
  //   if (exerciseGroupTitleModelList[index].currentExerciseGroup == 'false')
  //     return false;
  //   else
  //     return true;
  // }
  String liftInitialValue() => !isNew() ? txtLift(repMaxModel.value.lift) : '';

  String repMaxInitialValue() =>
      !isNew() ? txtRepMax(repMaxModel.value.repMax) : '';

  String trainingMaxInitialValue() =>
      !isNew() ? txtTrainingMax(repMaxModel.value.trainingMax) : '';
}
