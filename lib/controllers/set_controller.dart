import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/exercise_group_title_model.dart';
import '../models/rep_max.dart';
import '../models/set_model.dart';
import '../util/rep_max_db.dart';
import '../util/set_db.dart';

class SetController extends GetxController {
  RxString txtSetNumber = ''.obs;
  RxString txtPercentage = ''.obs;
  RxString txtReps = ''.obs;
  RxString txtCompleted = ''.obs;
  RxList setModelList = List<SetModel>().obs;
  Rx setModel = SetModel(0, 0, '', '', '', 0, '', '').obs;
  RxInt liftIndex = 0.obs;
  RxInt builderIndex = 0.obs;
  RxBool isNew = false.obs;
  RxBool liftSelected = false.obs;
  RxBool isSwitched = false.obs;
  RxBool checkBoxState = false.obs;
  Rx exerciseGroupTitleModel = ExerciseGroupTitleModel(0, 0, '', '').obs;
  Rx formKey = GlobalKey<FormState>().obs;

  var pr = TextEditingController();

  SetDb db = SetDb();
  RepMaxDb repMaxDb = RepMaxDb();

  deleteSet(int index) {
    db.deleteSet(setModelList[index]).then((result) {
      showData();
    });
  }

  Future showData() async {
    await db.openDb();
    setModelList.value = await db.getSets(exerciseGroupTitleModel.value.id);
  }

  newOrEdit() {
    if (isNew.value) {
      setModel.value = SetModel(
          0, exerciseGroupTitleModel.value.id, '', '', '', 0, 'false', 'false');
    }

    setModel.value.setNumber = txtSetNumber.value;
    setModel.value.percentage = txtPercentage.value;
    setModel.value.reps = txtReps.value;

    setModel.value.repMaxId =
        liftSelected.value ? liftIndex.value : setModel.value.repMaxId;

    isSwitched.value == true
        ? setModel.value.prSet = 'true'
        : setModel.value.prSet = 'false';

    db.insertSet(setModel.value);

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

  String validateSetNumber(value) {
    final repMaxRegex = RegExp(r'^-?[0-9]+$');
    if (value.isEmpty) {
      return 'Enter a value';
    } else if (!repMaxRegex.hasMatch(value)) {
      return 'Enter a valid number';
    }
    return null;
  }

  String validatePercentage(value) {
    final repMaxRegex = RegExp(r'^-?[0-9]+$');
    if (value.isEmpty) {
      return 'Enter a value';
    } else if (!repMaxRegex.hasMatch(value)) {
      return 'Enter a valid number';
    }
    return null;
  }

  String validateReps(value) {
    // final repMaxRegex = RegExp(r'^-?[0-9]+$');
    if (value.isEmpty) {
      return 'Enter a value';
    }
    // else if (!repMaxRegex.hasMatch(value)) {
    //   return 'Enter a valid number';
    // }
    return null;
  }

  editSet(int index) {
    setModel(setModelList[index]);
    isNew(false);
  }

  updateCheckbox(bool newValue, int index) {
    checkBoxState(newValue);
    setModel(setModelList[index]);

    checkBoxState.value == true
        ?
        // programTitleModelList[index].currentProgram == 'false'?
        setModel.value.completed = 'true'
        : setModel.value.completed = 'false';

    db.insertSet(setModel.value);
    showData();
  }

  bool checkboxValue(int index) {
    if (setModelList[index].completed == 'false')
      return false;
    else
      return true;
  }

  String setNumberInitialValue() =>
      !isNew() ? txtSetNumber(setModel.value.setNumber) : '';

  String percentageInitialValue() =>
      !isNew() ? txtPercentage(setModel.value.percentage) : '';

  String repsInitialValue() => !isNew() ? txtReps(setModel.value.reps) : '';

  String newPr(int index, String repMaxModel, RepMaxModel repMaxModelModel) {
    var percentage = int.parse(setModelList[index].percentage);
    String text = '';

    double parsedRepMax = double.parse(repMaxModel);
    double parsedTrainingMax =
        (double.parse(repMaxModelModel.trainingMax) / 100 * percentage);

    double parsedPr = double.parse(pr.value.text);
    int calculatedPr =
        (parsedTrainingMax * parsedPr * 0.0333 + parsedTrainingMax).truncate();
    if (calculatedPr > parsedRepMax) {
      print(calculatedPr.toString());
      repMaxModelModel.repMax = calculatedPr.toString();
      repMaxDb.insertRepMax(repMaxModelModel);
      text = 'Well done your new PR is $calculatedPr';
    } else if (pr.value.text == '1') {
      calculatedPr = parsedTrainingMax.truncate();
      text =
          '${calculatedPr.toStringAsFixed(0)}  You only managed ${pr.value.text} you need to lower your Training Max';
    } else if (pr.value.text == '2') {
      text =
          '${calculatedPr.toStringAsFixed(0)}  You only managed ${pr.value.text} you need to lower your Training Max';
    } else if (pr.value.text == '0') {
      calculatedPr = 0;
      text =
          'You couldn\'t hit you Training Max for 1, you need to lower your Training Max';
    } else if (calculatedPr <= parsedRepMax) {
      text =
          '${calculatedPr.toStringAsFixed(0)}  No PR this time, keep working, it\'s about marginal gains';
    }

    return text;
  }

  String percentageOfTrainingMax(int index, String trainingMax) {
    double parsedTrainingMax =
        trainingMax == 'BW' ? 0 : double.parse(trainingMax);
    double result = (parsedTrainingMax / 100) *
        double.parse(setModelList[index].percentage);

    return trainingMax == 'BW' ? 'BW' : result.toStringAsFixed(0);
    // result.toStringAsFixed(0);
  }

  bool isSwitchedValue(index) =>
      setModelList[index].prSet == 'true' ? true : false;

  editSwitchValue() {
    setModel(setModelList[builderIndex.value]);

    isSwitched.value == true
        ? setModel.value.prSet = 'true'
        : setModel.value.prSet = 'false';

    db.insertSet(setModel.value);
    showData();
  }

  bool newSwitchValue() {
    setModel.value = SetModel(
        0, exerciseGroupTitleModel.value.id, '', '', '', 0, 'false', 'false');

    isSwitched.value == true
        ? setModel.value.prSet = 'true'
        : setModel.value.prSet = 'false';

    return setModel.value.prSet == 'true' ? true : false;
  }

  String repsToBeat(int index, String repMax, String trainingMax) {
    int i;

    int parsedRepMax = int.parse(repMax);
    if (trainingMax == 'BW') {
      i = int.parse(repMax);
    } else if (trainingMax != 'BW') {
      double parsedTrainingMax = (int.parse(trainingMax) /
          100 *
          int.parse(setModelList[index].percentage));
      for (i = 1;
          (parsedTrainingMax * i * 0.0333 + parsedTrainingMax).truncate() <
              parsedRepMax;
          i++) {
        print(parsedRepMax);
        // print(i);
      }
    }
    // i = i - 1;
    showData();
    return i.toString();
  }

  String blah() {
    return 'blah';
  }

  printPrSets() {
    for (int i = 1; i < setModelList.length; i++) {
      print(i);
      // if (setModelList[builderIndex.value].prSet == 'true') {
      //   Text(setModelList[builderIndex.value].setNumber);
      // }
    }
  }
}
