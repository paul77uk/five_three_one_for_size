import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/day_title_model.dart';
import '../models/week_title_model.dart';
import '../util/day_title_db.dart';

class DayTitleController extends GetxController {
  RxString txtDayNum = ''.obs;
  RxString txtCurrentDay = ''.obs;
  RxList dayTitleModelList = List<DayTitleModel>().obs;
  Rx dayTitleModel = DayTitleModel(0, 0, '', '').obs;
  // RxInt index = 0.obs;
  RxBool isNew = false.obs;
  RxBool checkBoxState = false.obs;
  Rx weekTitleModel = WeekTitleModel(0, 0, '', '').obs;
  Rx formKey = GlobalKey<FormState>().obs;

  DayTitleDb db = DayTitleDb();

  deleteDay(int index) {
    db.deleteDay(dayTitleModelList[index]).then((result) {
      showData();
    });
  }

  Future showData() async {
    await db.openDb();
    dayTitleModelList.value = await db.getDays(weekTitleModel.value.id);
  }

  newOrEdit() {
    if (isNew.value) {
      dayTitleModel.value =
          DayTitleModel(0, weekTitleModel.value.id, '', 'false');
    }

    dayTitleModel.value.dayNum = txtDayNum.value;

    db.insertDayTitle(dayTitleModel.value);

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

  editDay(int index) {
    dayTitleModel(dayTitleModelList[index]);
    isNew(false);
  }

  updateCheckbox(bool newValue, int index) {
    checkBoxState(newValue);
    dayTitleModel(dayTitleModelList[index]);

    checkBoxState.value == true
        ?
        // programTitleModelList[index].currentProgram == 'false'?
        dayTitleModel.value.currentDay = 'true'
        : dayTitleModel.value.currentDay = 'false';

    db.insertDayTitle(dayTitleModel.value);
    showData();
  }

  bool checkboxValue(int index) {
    if (dayTitleModelList[index].currentDay == 'false')
      return false;
    else
      return true;
  }

  String initialValue() =>
      !isNew() ? txtDayNum(dayTitleModel.value.dayNum) : '';
}
