import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepMaxCalculatorController extends GetxController {
  RxInt roundToNum = 0.obs;
  RxString weight = ''.obs;
  RxString reps = ''.obs;
  RxString oneRepMax = ''.obs;
  RxString trainingMaxPercentage = ''.obs;
  RxString trainingMax = ''.obs;

  Rx formKey = GlobalKey<FormState>().obs;

  onSaveContactButtonPressed() {
    print((weight.value));
    var testDouble = int.parse(weight.value);
    print(testDouble);

    var oneRepMaxDouble =
        (double.parse(weight.value) * double.parse(reps.value)) * 0.0333 +
            double.parse(weight.value);
    var trainingMaxDouble =
        (oneRepMaxDouble / 100) * double.parse(trainingMaxPercentage.value);
    oneRepMax.value = oneRepMaxDouble.toStringAsFixed(0);

    trainingMax.value = trainingMaxDouble.toStringAsFixed(0);
  }

  clearMaxes() {
    oneRepMax('');
    trainingMax('');
  }
}
