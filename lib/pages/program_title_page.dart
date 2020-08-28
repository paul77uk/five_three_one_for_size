import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/program_title_controller.dart';
import '../controllers/week_title_controller.dart';
import '../widgets/delete_swipe.dart';
import '../widgets/prompt_dialog.dart';
import 'program_title_dialog_page.dart';
import 'week_title_page.dart';

class ProgramTitlePage extends StatelessWidget {
  final ProgramTitleController ptc = Get.put(ProgramTitleController());
  final WeekTitleController wtc = Get.put(WeekTitleController());

  @override
  Widget build(BuildContext context) {
    ptc.showData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Programs'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: (ptc.programTitleModelList != null)
              ? ptc.programTitleModelList.length
              : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(ptc.programTitleModelList[index].id.toString()),
              background: DeleteSwipe(),
              secondaryBackground: DeleteSwipe(),
              confirmDismiss: (direction) => Get.dialog(
                PromptDialog(
                  index: index,
                  onPressed: () {
                    String strName = ptc.programTitleModelList[index].title;
                    ptc.deleteProgram(index);

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
                        ptc.editProgram(index);

                        Get.to(ProgramTitleDialog().buildDialog());
                      },
                    ),
                    title: ListTile(
                      title: Text(
                        ptc.programTitleModelList[index].title,
                        textAlign: TextAlign.center,
                      ),
                      trailing: Checkbox(
                        checkColor: ThemeData.dark().primaryColorDark,
                        value: ptc.checkboxValue(index),
                        onChanged: (value) => ptc.updateCheckbox(value, index),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        color: ThemeData.dark().accentColor,
                      ),
                      onPressed: () {
                        wtc.progamTitleModel(ptc.programTitleModelList[index]);
                        Get.to(WeekTitlePage());
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
          ptc.isNew(true);
          Get.to(
            ProgramTitleDialog().buildDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
