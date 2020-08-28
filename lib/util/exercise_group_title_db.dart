import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/exercise_group_title_model.dart';

class ExerciseGroupTitleDb {
  final int version = 1;
  Database db;

  static final ExerciseGroupTitleDb _exerciseGroupTitleDb =
      ExerciseGroupTitleDb._internal();
  ExerciseGroupTitleDb._internal();
  factory ExerciseGroupTitleDb() {
    return _exerciseGroupTitleDb;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(
          join(await getDatabasesPath(), 'exerciseGroupTitle2.db'),
          onCreate: (database, version) {
        // weekSql.createWeekTitleTable();
        // weekSql.insertBBBWeeks();
        database.execute(
            'CREATE TABLE exerciseGroupTitle(id INTEGER PRIMARY KEY, idDayTitle INTEGER, exerciseGroupTitle TEXT, currentExerciseGroup TEXT, ' +
                'FOREIGN KEY(idDayTitle)REFERENCES dayTitle(id))');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(1, "Warm Up","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(1, "531","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(1, "BBB","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(1, "Chin-ups","false")');
      }, version: version);
    }
    return db;
  }

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
