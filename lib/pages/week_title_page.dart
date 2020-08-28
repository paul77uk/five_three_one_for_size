import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/day_title_controller.dart';
import '../controllers/week_title_controller.dart';
import 'day_title_page.dart';
import 'week_title_dialog_page.dart';
import '../widgets/delete_swipe.dart';
import '../widgets/prompt_dialog.dart';

class WeekTitlePage extends StatelessWidget {
  final WeekTitleController wtc = Get.find();
  final DayTitleController dtc = Get.put(DayTitleController());

  @override
  Widget build(BuildContext context) {
    wtc.showData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(wtc.progamTitleModel.value.title),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: (wtc.weekTitleModelList != null)
              ? wtc.weekTitleModelList.length
              : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(wtc.weekTitleModelList[index].id.toString()),
              background: DeleteSwipe(),
              secondaryBackground: DeleteSwipe(),
              confirmDismiss: (direction) => Get.dialog(
                PromptDialog(
                  index: index,
                  onPressed: () {
                    String strName = wtc.weekTitleModelList[index].weekNum;
                    wtc.deleteWeek(index);

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
                        wtc.editWeek(index);

                        Get.to(WeekTitleDialog().buildDialog());
                      },
                    ),
                    title: ListTile(
                      title: Text(
                        wtc.weekTitleModelList[index].weekNum,
                        textAlign: TextAlign.center,
                      ),
                      trailing: Checkbox(
                        checkColor: ThemeData.dark().primaryColorDark,
                        value: wtc.checkboxValue(index),
                        onChanged: (value) => wtc.updateCheckbox(value, index),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        color: ThemeData.dark().accentColor,
                      ),
                      onPressed: () {
                        dtc.weekTitleModel(wtc.weekTitleModelList[index]);
                        Get.to(DayTitlePage());
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
          wtc.isNew(true);
          Get.to(WeekTitleDialog().buildDialog());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
