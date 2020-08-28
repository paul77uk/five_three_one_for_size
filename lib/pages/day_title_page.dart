import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/day_title_controller.dart';
import '../controllers/exercise__group_title_controller.dart';
import '../widgets/delete_swipe.dart';
import '../widgets/prompt_dialog.dart';
import 'day_title_dialog_page.dart';
import 'exercise_group_title_page.dart';

class DayTitlePage extends StatelessWidget {
  final DayTitleController dtc = Get.find();
  final ExerciseGroupTitleController egtc =
      Get.put(ExerciseGroupTitleController());

  @override
  Widget build(BuildContext context) {
    dtc.showData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(dtc.weekTitleModel.value.weekNum),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: (dtc.dayTitleModelList != null)
              ? dtc.dayTitleModelList.length
              : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(dtc.dayTitleModelList[index].id.toString()),
              background: DeleteSwipe(),
              secondaryBackground: DeleteSwipe(),
              confirmDismiss: (direction) => Get.dialog(
                PromptDialog(
                  index: index,
                  onPressed: () {
                    String strName = dtc.dayTitleModelList[index].dayNum;
                    dtc.deleteDay(index);

                    Get.back();
                    Get.rawSnackbar(message: "$strName deleted");
                  },
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.edit),
                      color: ThemeData.dark().accentColor,
                      onPressed: () {
                        dtc.editDay(index);

                        Get.to(DayTitleDialog().buildDialog());
                      },
                    ),
                    title: ListTile(
                      title: Text(
                        dtc.dayTitleModelList[index].dayNum,
                        textAlign: TextAlign.center,
                      ),
                      trailing: Checkbox(
                        checkColor: ThemeData.dark().primaryColorDark,
                        value: dtc.checkboxValue(index),
                        onChanged: (value) => dtc.updateCheckbox(value, index),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        color: ThemeData.dark().accentColor,
                      ),
                      onPressed: () {
                        egtc.dayTitleModel(dtc.dayTitleModelList[index]);
                        Get.to(ExerciseGroupTitlePage());
                      },
                    ),
                  ),
                  Divider(),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // if is true, creates a new ItemModel
          dtc.isNew(true);
          Get.to(DayTitleDialog().buildDialog());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
