import 'package:path/path.dart';
import 'package:size_and_fitness_app/data/exercise_group_data.dart';
import 'package:sqflite/sqflite.dart';

import '../models/exercise_group_title_model.dart';

class ExerciseGroupTitleDb {
  final int version = 1;
  Database db;
  ExerciseGroupData exerciseGroupData = ExerciseGroupData();

  static final ExerciseGroupTitleDb _exerciseGroupTitleDb =
      ExerciseGroupTitleDb._internal();
  ExerciseGroupTitleDb._internal();
  factory ExerciseGroupTitleDb() {
    return _exerciseGroupTitleDb;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(
          join(await getDatabasesPath(), 'exerciseGroupTitle22.db'),
          onCreate: (database, version) {
        // weekSql.createWeekTitleTable();
        // weekSql.insertBBBWeeks();

        database.execute(
            'CREATE TABLE exerciseGroupTitle(id INTEGER PRIMARY KEY, idDayTitle INTEGER, exerciseGroupTitle TEXT, currentExerciseGroup TEXT, ' +
                'FOREIGN KEY(idDayTitle)REFERENCES dayTitle(id))');
        for (int i = 0; i < 12; i++) {
          for (var item in exerciseGroupData.bbb(i + 1, i + 2, i + 3, i + 4)) {
            // insertIntoExerciseGroup(item[0], item[1]);
            database.rawInsert(
                'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(${item[0]}, "${item[1]}","false")');
            // print('${item[0]}, "${item[1]}"');
          }
          i += 3;
        }

        // for (var item in exerciseGroupData.bbbWeekTwo) {
        //   insertIntoExerciseGroup(item[0], item[1]);
        // }

        // for (var item in exerciseGroupData.bbbWeekThree) {
        //   insertIntoExerciseGroup(item[0], item[1]);
        // }
      }, version: version);
    }
    return db;
  }

  // void insertIntoExerciseGroup(int value1, String value2) {
  //   db.rawInsert(
  //       'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES($value1, "$value2","false")');
  // }

  Future<int> insertExerciseGroupTitle(
      ExerciseGroupTitleModel exerciseGroupTitleModel) async {
    int id = await this.db.insert(
          'exerciseGroupTitle',
          exerciseGroupTitleModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return id;
  }

  Future<List<ExerciseGroupTitleModel>> getExerciseGroups(
      int idDayTitle) async {
    final List<Map<String, dynamic>> maps = await db.query('exerciseGroupTitle',
        where: 'idDayTitle = ?', whereArgs: [idDayTitle]);
    return List.generate(maps.length, (i) {
      return ExerciseGroupTitleModel(
        maps[i]['id'],
        maps[i]['idDayTitle'],
        maps[i]['exerciseGroupTitle'],
        maps[i]['currentExerciseGroup'],
      );
    });
  }

  Future<int> deleteExerciseGroup(
    ExerciseGroupTitleModel exerciseGroupTitle,
  ) async {
    int result = await db.delete("exerciseGroupTitle",
        where: "id = ?", whereArgs: [exerciseGroupTitle.id]);

    return result;
  }
}
