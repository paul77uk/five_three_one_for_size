import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/rep_max_calculator_controller.dart';

class RepMaxAndTrainingMaxCalculator extends StatelessWidget {
  final RepMaxCalculatorController rmcc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: rmcc.formKey.value,
      child: FittedBox(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text(
                'Rep Max & Training Max Calculator',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Divider(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: Card(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Weight:'),
                      ),
                      Container(
                        width: 30,
                        height: 50,
                        padding: EdgeInsets.only(bottom: 16),
                        child: TextFormField(
                          keyboardType: TextInputType.numberWithOptions(),
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            rmcc.weight(value);
                            // print(value);
                            // print(rmcc.weight.value);
                          },
                        ),
                      )
                    ],
                  )),
                ),
                SizedBox(width: 8),
                Flexible(
                  fit: FlexFit.loose,
                  child: Card(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Reps:'),
                      ),
                      Container(
                        width: 30,
                        height: 50,
                        padding: EdgeInsets.only(bottom: 16),
                        child: TextFormField(
                          keyboardType: TextInputType.numberWithOptions(),
                          textAlign: TextAlign.center,
                          onChanged: (value) => rmcc.reps(value),
                        ),
                      )
                    ],
                  )),
                ),
              ],
            ),
            Card(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Training Max Percentage:',
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 30,
                  height: 50,
                  padding: EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    textAlign: TextAlign.center,
                    onChanged: (value) => rmcc.trainingMaxPercentage(value),
                  ),
                )
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 120,
                  child: Card(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('1 Rep Max:'),
                      ),
                      Container(
                        width: 50,
                        height: 40,
                        padding: EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Obx(
                            () => Text(
                              rmcc.oneRepMax.value,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                ),
                SizedBox(width: 8),
                Container(
                  width: 130,
                  child: Card(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Training Max:'),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Obx(
                            () => Text(
                              rmcc.trainingMax.value,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                ),
              ],
            ),
            RaisedButton(
              onPressed: rmcc.onSaveContactButtonPressed,
              child: Row(
// Center on the main axis (horizontally)
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('SAVE'),
                ],
              ),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
