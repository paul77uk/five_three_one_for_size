import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/exercise__group_title_controller.dart';
import '../controllers/set_controller.dart';
import '../widgets/delete_swipe.dart';
import '../widgets/prompt_dialog.dart';
import 'exercise_group_title_dialog_page.dart';
import 'set_page.dart';

class ExerciseGroupTitlePage extends StatelessWidget {
  final ExerciseGroupTitleController egtc = Get.find();
  final SetController sc = Get.put(SetController());

  @override
  Widget build(BuildContext context) {
    egtc.showData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(egtc.dayTitleModel.value.dayNum),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: (egtc.exerciseGroupTitleModelList != null)
              ? egtc.exerciseGroupTitleModelList.length
              : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(egtc.exerciseGroupTitleModelList[index].id.toString()),
              background: DeleteSwipe(),
              secondaryBackground: DeleteSwipe(),
              confirmDismiss: (direction) => Get.dialog(
                PromptDialog(
                  index: index,
                  onPressed: () {
                    String strName = egtc
                        .exerciseGroupTitleModelList[index].exerciseGroupTitle;
                    egtc.deleteExerciseGroup(index);

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
                        egtc.editExerciseGroupTitle(index);

                        Get.to(ExerciseGroupTitleDialog().buildDialog());
                      },
                    ),
                    title: ListTile(
                      title: Text(
                        egtc.exerciseGroupTitleModelList[index]
                            .exerciseGroupTitle,
                        textAlign: TextAlign.center,
                      ),
                      trailing: Checkbox(
                        checkColor: ThemeData.dark().primaryColorDark,
                        value: egtc.checkboxValue(index),
                        onChanged: (value) => egtc.updateCheckbox(value, index),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        color: ThemeData.dark().accentColor,
                      ),
                      onPressed: () {
                        sc.exerciseGroupTitleModel(
                            egtc.exerciseGroupTitleModelList[index]);
                        Get.to(SetPage());
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
          egtc.isNew(true);
          Get.to(ExerciseGroupTitleDialog().buildDialog());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
