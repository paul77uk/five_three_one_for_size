import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/set_controller.dart';
import '../pages/set_dialog_page.dart';

class SetTable extends StatelessWidget {
  final SetController sc = Get.find();

  final String setNum;
  final String lift;
  final String percentage;
  final String weight;
  final String reps;
  final Color textColor;
  final bool isHeader;

  final int index;

  SetTable(
      {Key key,
      this.setNum,
      this.lift,
      this.percentage,
      this.weight,
      this.reps,
      this.textColor,
      this.isHeader = false,
      this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.white70),
      columnWidths: {
        0: FractionColumnWidth(0.1),
        1: FractionColumnWidth(0.13),
        2: FractionColumnWidth(0.2),
        3: FractionColumnWidth(0.15),
        4: FractionColumnWidth(0.17),
        5: FractionColumnWidth(0.15),
        6: FractionColumnWidth(0.1),
      },
      children: [
        TableRow(children: [
          Opacity(
            opacity: isHeader ? 0 : 1,
            child: Column(children: [
              SizedBox(
                height: 48,
                child: isHeader
                    ? Icon(Icons.edit)
                    : IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 18,
                          color: ThemeData.dark().accentColor,
                        ),
                        onPressed: () {
                          sc.builderIndex(index);

                          sc.editSet(index);
                          sc.liftSelected(false);
                          Get.to(SetDialog().buildDialog());
                          // Get.defaultDialog(
                          //     title: sc.isNew.value ? 'New Set' : 'Edit Set',
                          //     content: SetDialogContent());
                        }),
              ),
            ]),
          ),
          TableTextColum(
            text: setNum,
            textColor: textColor,
          ),
          TableTextColum(
            text: lift,
            textColor: textColor,
          ),
          TableTextColum(
            text: percentage,
            textColor: textColor,
          ),
          TableTextColum(
            text: weight,
            textColor: textColor,
          ),
          TableTextColum(
            text: reps,
            textColor: textColor,
          ),
          Opacity(
            opacity: isHeader ? 0 : 1,
            child: Column(children: [
              SizedBox(
                height: 48,
                child: isHeader
                    ? Icon(Icons.check_box)
                    : Checkbox(
                        checkColor: ThemeData.dark().primaryColorDark,
                        value: sc.checkboxValue(index),
                        onChanged: (value) => sc.updateCheckbox(value, index),
                      ),
              ),
            ]),
          ),
        ]),
      ],
    );
  }
}

class TableTextColum extends StatelessWidget {
  final SetController sc = Get.find();
  TableTextColum({
    Key key,
    @required this.text,
    this.textColor,
  }) : super(key: key);

  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      )
    ]);
  }
}
