import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/rep_max_calculator_controller.dart';
import '../controllers/rep_max_controller.dart';
import '../widgets/delete_swipe.dart';
import '../widgets/prompt_dialog.dart';
import 'rep_max_dialog.dart';

class RepMaxPage extends StatelessWidget {
  final RepMaxController rmc = Get.put(RepMaxController());
  final RepMaxCalculatorController rmcc = Get.put(RepMaxCalculatorController());

  @override
  Widget build(BuildContext context) {
    rmc.showData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Maxes'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount:
              (rmc.repMaxModelList != null) ? rmc.repMaxModelList.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(rmc.repMaxModelList[index].id.toString()),
              background: DeleteSwipe(),
              secondaryBackground: DeleteSwipe(),
              confirmDismiss: (direction) => Get.dialog(
                PromptDialog(
                  index: index,
                  onPressed: () {
                    String strName = rmc.repMaxModelList[index].lift;
                    rmc.deleteRepMax(index);

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
                        rmc.editRepMax(index);
                        rmcc.clearMaxes();
                        Get.to(RepMaxDialog().buildDialog());
                      },
                    ),
                    // title: ListTile(
                    title: Text(
                      rmc.repMaxModelList[index].lift,
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      'Rep Max: ${rmc.repMaxModelList[index].repMax}\nTraining Max: ${rmc.repMaxModelList[index].trainingMax}',
                      textAlign: TextAlign.center,
                    ),
                    trailing: Opacity(
                      opacity: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        color: ThemeData.dark().accentColor,
                        onPressed: null,
                      ),
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
          rmc.isNew(true);
          rmcc.clearMaxes();
          Get.to(
            RepMaxDialog().buildDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
