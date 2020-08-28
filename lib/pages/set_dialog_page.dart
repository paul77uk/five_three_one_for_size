import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/rep_max_controller.dart';
import '../controllers/set_controller.dart';
import '../widgets/dialog_buttons.dart';

class SetDialog {
  final SetController sc = Get.find();
  final RepMaxController rmc = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: sc.formKey.value,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Column(
//                 children: [
//                   TextFormField(
//                       validator: sc.validateSetNumber,
//                       keyboardType: TextInputType.number,
//                       initialValue: sc.setNumberInitialValue(),
//                       onChanged: sc.txtSetNumber,
//                       decoration: InputDecoration(hintText: 'Set')),
//                   TextFormField(
//                       validator: sc.validatePercentage,
//                       keyboardType: TextInputType.number,
//                       initialValue: sc.percentageInitialValue(),
//                       onChanged: sc.txtPercentage,
//                       decoration: InputDecoration(hintText: 'Percentage')),
//                   TextFormField(
//                       validator: sc.validateReps,
//                       keyboardType: TextInputType.number,
//                       initialValue: sc.repsInitialValue(),
//                       onChanged: sc.txtReps,
//                       decoration: InputDecoration(hintText: 'Reps')),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text('Pr Set'),
//                 Obx(() => Switch(
//                       value: sc.isSwitched.value,
//                       // widget.setModelList[widget.index].prSet == 'true'
//                       //     ? true
//                       //     : false,
//                       onChanged: (value) {
//                         sc.isSwitched(value);
//                         // helper.insertSet(widget.setModel);
//                       },
//                       activeColor: ThemeData.dark().accentColor,
//                     )),
//               ],
//             ),
//             ListView.builder(
//                 physics: ScrollPhysics(),
//                 padding: EdgeInsets.all(0),
//                 shrinkWrap: true,
//                 itemCount: (rmc.repMaxModelList != null)
//                     ? rmc.repMaxModelList.length
//                     : 0,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Column(
//                     children: <Widget>[
//                       ListTile(
//                           onTap: () {
//                             sc.liftSelected(true);
//                             sc.liftIndex(index);
//                           },
//                           contentPadding: EdgeInsets.all(0),
//                           title: Text(
//                             rmc.repMaxModelList[index].lift,
//                             textAlign: TextAlign.center,
//                           )),
//                       Divider(height: 0),
//                     ],
//                   );
//                 }),
//             SizedBox(height: 10),
//             DialogButtons(controller: sc),
//           ],
//         ),
//       ),
//     );
//   }
// }

  Widget buildDialog() {
    return AlertDialog(
      scrollable: true,
      title: Obx(
        () => Text((sc.isNew.value) ? 'New Set' : 'Edit Set'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: Form(
        key: sc.formKey.value,
        child: Column(
          children: [
            TextFormField(
                validator: sc.validateSetNumber,
                keyboardType: TextInputType.number,
                initialValue: sc.setNumberInitialValue(),
                onChanged: sc.txtSetNumber,
                decoration: InputDecoration(hintText: 'Set')),
            TextFormField(
                validator: sc.validatePercentage,
                keyboardType: TextInputType.number,
                initialValue: sc.percentageInitialValue(),
                onChanged: sc.txtPercentage,
                decoration: InputDecoration(hintText: 'Percentage')),
            TextFormField(
                validator: sc.validateReps,
                initialValue: sc.repsInitialValue(),
                onChanged: sc.txtReps,
                decoration: InputDecoration(hintText: 'Reps')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Pr Set'),
                Obx(() => Switch(
                      value: !sc.isNew()
                          ? sc.isSwitchedValue(sc.builderIndex.value)
                          : sc.newSwitchValue(),
                      onChanged: (value) {
                        sc.isSwitched(value);
                        !sc.isNew()
                            ? sc.editSwitchValue()
                            : sc.newSwitchValue();

                        print(sc.isSwitched.value);
                        print(sc.builderIndex.value);
                      },
                      activeColor: ThemeData.dark().accentColor,
                    )),
              ],
            ),
            ListView.builder(
                physics: ScrollPhysics(),
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: (rmc.repMaxModelList != null)
                    ? rmc.repMaxModelList.length
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                          onTap: () {
                            sc.liftSelected(true);
                            sc.liftIndex(index);
                          },
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            rmc.repMaxModelList[index].lift,
                            textAlign: TextAlign.center,
                          )),
                      Divider(height: 0),
                    ],
                  );
                }),
            SizedBox(height: 10),
            DialogButtons(controller: sc),
          ],
        ),
      ),
    );
  }
}
