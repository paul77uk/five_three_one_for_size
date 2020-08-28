import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/rep_max_controller.dart';
import '../controllers/set_controller.dart';
import '../widgets/delete_swipe.dart';
import '../widgets/prompt_dialog.dart';
import '../widgets/set_table.dart';
import 'set_dialog_page.dart';

class SetPage extends StatelessWidget {
  final SetController sc = Get.find();
  final RepMaxController rmc = Get.find();

  @override
  Widget build(BuildContext context) {
    rmc.showData();
    sc.showData();
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Text('Pr Set'),
        //       Obx(() => Switch(
        //             value: sc.isSwitchedValue(sc.builderIndex.value),
        //             // widget.setModelList[widget.index].prSet == 'true'
        //             //     ? true
        //             //     : false,
        //             onChanged: (value) => sc.upDateSwitchValue(value),
        //             activeColor: ThemeData.dark().accentColor,
        //           )),
        //     ],
        //   ),
        // ],
        centerTitle: true,
        title: Text(sc.exerciseGroupTitleModel.value.exerciseGroupTitle),
      ),
      body: ListView(
        children: <Widget>[
          SetTable(
            setNum: 'Set',
            percentage: '%',
            lift: 'Lift',
            weight: 'Weight',
            reps: 'Reps',
            textColor: ThemeData.dark().accentColor,
            isHeader: true,
          ),
          Obx(
            () => ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: (sc.setModelList != null) ? sc.setModelList.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(sc.setModelList[index].id.toString()),
                  background: DeleteSwipe(),
                  secondaryBackground: DeleteSwipe(),
                  confirmDismiss: (direction) => Get.dialog(
                    PromptDialog(
                      index: index,
                      onPressed: () {
                        String strName = sc.setModelList[index].setNumber;
                        sc.deleteSet(index);

                        Get.back();
                        Get.rawSnackbar(message: "$strName deleted");
                      },
                    ),
                  ),
                  child: Column(
                    children: [
                      SetTable(
                        setNum: sc.setModelList[index].setNumber,
                        lift: rmc
                            .repMaxModelList[sc.setModelList[index].repMaxId]
                            .lift,
                        percentage: sc.setModelList[index].percentage,
                        weight: sc.percentageOfTrainingMax(
                            index,
                            rmc.repMaxModelList[sc.setModelList[index].repMaxId]
                                .trainingMax),
                        reps: sc.setModelList[index].reps,
                        textColor: Colors.white,
                        index: index,
                      ),
                      sc.setModelList[index].prSet == 'true'
                          ? PrSetContainer(index: index)
                          : Container(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // if is true, creates a new ItemModel

          sc.isNew(true);
          sc.isSwitched(false);
          Get.to(SetDialog().buildDialog());
          // Get.defaultDialog(
          //     title: sc.isNew.value ? 'New Set' : 'Edit Set',
          //     content: SetDialog().buildDialog());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PrSetContainer extends StatelessWidget {
  final SetController sc = Get.find();
  final RepMaxController rmc = Get.find();

  final int index;

  PrSetContainer({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.white,
      )),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'Set ${sc.setModelList[index].setNumber} Pr Set',
            style: TextStyle(color: ThemeData.dark().accentColor),
          ),
        ),
        title: SizedBox(
          height: 38,
          child: TextField(
            controller: sc.pr,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText:
                  'To beat: ${sc.repsToBeat(index, rmc.repMaxModelList[sc.setModelList[index].repMaxId].repMax, rmc.repMaxModelList[sc.setModelList[index].repMaxId].trainingMax)}',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        trailing: RaisedButton(
          color: ThemeData.dark().accentColor,
          onPressed: () {
            Get.snackbar(
              '',
              sc.newPr(
                index,
                rmc.repMaxModelList[sc.setModelList[index].repMaxId].repMax,
                rmc.repMaxModelList[sc.setModelList[index].repMaxId],
              ),
            );
          },
          child: Text(
            'Save',
            style: TextStyle(color: ThemeData.dark().primaryColor),
          ),
        ),
      ),
    );
  }
}
