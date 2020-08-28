import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/day_title_model.dart';
import '../models/exercise_group_title_model.dart';
import '../util/exercise_group_title_db.dart';

class ExerciseGroupTitleController extends GetxController {
  RxString txtExerciseGroupTitle = ''.obs;
  RxString txtCurrentExerciseGroup = ''.obs;
  RxList exerciseGroupTitleModelList = List<ExerciseGroupTitleModel>().obs;
  Rx exerciseGroupTitleModel = ExerciseGroupTitleModel(0, 0, '', '').obs;
  // RxInt index = 0.obs;
  RxBool isNew = false.obs;
  RxBool checkBoxState = false.obs;
  Rx dayTitleModel = DayTitleModel(0, 0, '', '').obs;
  Rx formKey = GlobalKey<FormState>().obs;

  ExerciseGroupTitleDb db = ExerciseGroupTitleDb();

  deleteExerciseGroup(int index) {
    db.deleteExerciseGroup(exerciseGroupTitleModelList[index]).then((result) {
      showData();
    });
  }

  Future showData() async {
    await db.openDb();
    exerciseGroupTitleModelList.value =
        await db.getExerciseGroups(dayTitleModel.value.id);
  }

  newOrEdit() {
    if (isNew.value) {
      exerciseGroupTitleModel.value =
          ExerciseGroupTitleModel(0, dayTitleModel.value.id, '', 'false');
    }

    exerciseGroupTitleModel.value.exerciseGroupTitle =
        txtExerciseGroupTitle.value;

    db.insertExerciseGroupTitle(exerciseGroupTitleModel.value);

    showData();
  }

  validate() {
    if (formKey.value.currentState.validate()) {
      newOrEdit();
      Get.back();
    }
  }

  validator(value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  editExerciseGroupTitle(int index) {
    exerciseGroupTitleModel(exerciseGroupTitleModelList[index]);
    isNew(false);
  }

  updateCheckbox(bool newValue, int index) {
    checkBoxState(newValue);
    exerciseGroupTitleModel(exerciseGroupTitleModelList[index]);

    checkBoxState.value == true
        ?
        // programTitleModelList[index].currentProgram == 'false'?
        exerciseGroupTitleModel.value.currentExerciseGroup = 'true'
        : exerciseGroupTitleModel.value.currentExerciseGroup = 'false';

    db.insertExerciseGroupTitle(exerciseGroupTitleModel.value);
    showData();
  }

  bool checkboxValue(int index) {
    if (exerciseGroupTitleModelList[index].currentExerciseGroup == 'false')
      return false;
    else
      return true;
  }

  String initialValue() => !isNew()
      ? txtExerciseGroupTitle(exerciseGroupTitleModel.value.exerciseGroupTitle)
      : '';
}
