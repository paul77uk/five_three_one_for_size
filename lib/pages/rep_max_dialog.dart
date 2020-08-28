import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/rep_max_controller.dart';
import '../widgets/dialog_buttons.dart';
import '../widgets/rep_and_training_max_calculator.dart';

class RepMaxDialog {
  final RepMaxController rpc = Get.find();

  Widget buildDialog() {
    return AlertDialog(
        title: Obx(
          () => Text((rpc.isNew.value) ? 'New Max' : 'Edit Max'),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Form(
            key: rpc.formKey.value,
            child: Column(children: <Widget>[
              TextFormField(
                validator: rpc.liftValidator,
                textCapitalization: TextCapitalization.words,
                initialValue: rpc.liftInitialValue(),
                onChanged: rpc.txtLift,
                decoration: InputDecoration(hintText: 'Lift'),
              ),
              TextFormField(
                validator: rpc.validateRepMax,
                keyboardType: TextInputType.number,
                initialValue: rpc.repMaxInitialValue(),
                onChanged: rpc.txtRepMax,
                decoration: InputDecoration(hintText: 'Rep Max'),
              ),
              TextFormField(
                validator: rpc.validateTrainingMax,
                textCapitalization: TextCapitalization.words,
                initialValue: rpc.trainingMaxInitialValue(),
                onChanged: rpc.txtTrainingMax,
                decoration: InputDecoration(hintText: 'Training Max'),
              ),
              SizedBox(height: 10),
              RepMaxAndTrainingMaxCalculator(),
              SizedBox(height: 10),
              DialogButtons(controller: rpc),
            ]),
          ),
        ));
  }
}
