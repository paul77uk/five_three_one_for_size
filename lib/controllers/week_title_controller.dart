import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/program_title_model.dart';
import '../models/week_title_model.dart';
import '../util/week_title_db.dart';

class WeekTitleController extends GetxController {
  RxString txtWeekNum = ''.obs;
  RxString txtCurrentWeek = ''.obs;
  RxList weekTitleModelList = List<WeekTitleModel>().obs;
  Rx weekTitleModel = WeekTitleModel(0, 0, '', '').obs;
  // RxInt index = 0.obs;
  RxBool isNew = false.obs;
  RxBool checkBoxState = false.obs;
  Rx progamTitleModel = ProgramTitleModel(0, '', '').obs;
  Rx formKey = GlobalKey<FormState>().obs;

  WeekTitleDb db = WeekTitleDb();

  deleteWeek(int index) {
    db.deleteWeek(weekTitleModelList[index]).then((result) {
      showData();
    });
  }

  Future showData() async {
    await db.openDb();
    weekTitleModelList.value = await db.getWeeks(progamTitleModel.value.id);
  }

  newOrEdit() {
    if (isNew.value) {
      weekTitleModel.value =
          WeekTitleModel(0, progamTitleModel.value.id, '', 'false');
    }

    weekTitleModel.value.weekNum = txtWeekNum.value;

    db.insertWeekTitle(weekTitleModel.value);

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

  editWeek(int index) {
    weekTitleModel(weekTitleModelList[index]);
    isNew(false);
  }

  updateCheckbox(bool newValue, int index) {
    checkBoxState(newValue);
    weekTitleModel(weekTitleModelList[index]);

    checkBoxState.value == true
        ?
        // programTitleModelList[index].currentProgram == 'false'?
        weekTitleModel.value.currentWeek = 'true'
        : weekTitleModel.value.currentWeek = 'false';

    db.insertWeekTitle(weekTitleModel.value);
    showData();
  }

  bool checkboxValue(int index) {
    if (weekTitleModelList[index].currentWeek == 'false')
      return false;
    else
      return true;
  }

  String initialValue() =>
      !isNew() ? txtWeekNum(weekTitleModel.value.weekNum) : '';
}
