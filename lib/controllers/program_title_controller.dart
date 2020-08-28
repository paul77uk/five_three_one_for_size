import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/program_title_model.dart';
import '../util/program_title_db.dart';

class ProgramTitleController extends GetxController {
  RxString txtTitle = ''.obs;
  RxString txtCurrentProgram = ''.obs;
  RxList programTitleModelList = List<ProgramTitleModel>().obs;
  Rx programTitleModel = ProgramTitleModel(0, '', '').obs;
  // RxInt index = 0.obs;
  RxBool isNew = false.obs;
  RxBool checkBoxState = false.obs;
  Rx formKey = GlobalKey<FormState>().obs;

  ProgramTitleDb db = ProgramTitleDb();

  deleteProgram(int index) {
    db.deleteProgram(programTitleModelList[index]).then((result) {
      showData();
    });
  }

  Future showData() async {
    await db.openDb();
    programTitleModelList.value = await db.getPrograms();
  }

  newOrEdit() {
    if (isNew.value) {
      programTitleModel.value = ProgramTitleModel(0, '', 'false');
    }

    programTitleModel.value.title = txtTitle.value;

    db.insertProgramTitle(programTitleModel.value);

    showData();
  }

  validate() {
    if (formKey.value.currentState.validate()) {
      newOrEdit();
      Get.back();
    }
  }

  editProgram(int index) {
    programTitleModel(programTitleModelList[index]);
    isNew(false);
  }

  updateCheckbox(bool newValue, int index) {
    checkBoxState(newValue);
    programTitleModel(programTitleModelList[index]);

    checkBoxState.value == true
        ? programTitleModel.value.currentProgram = 'true'
        : programTitleModel.value.currentProgram = 'false';

    db.insertProgramTitle(programTitleModel.value);
    showData();
  }

  bool checkboxValue(int index) {
    if (programTitleModelList[index].currentProgram == 'false')
      return false;
    else
      return true;
  }

  String initialValue() =>
      !isNew() ? txtTitle(programTitleModel.value.title) : '';

  validator(value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}
