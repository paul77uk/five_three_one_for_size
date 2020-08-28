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
          join(await getDatabasesPath(), 'exerciseGroupTitle8.db'),
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

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(2, "Warm Up","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(2, "531","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(2, "BBB","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(2, "Hanging Leg Raise","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(3, "Warm Up","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(3, "531","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(3, "BBB","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(3, "Dumbbell Row","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(4, "Warm Up","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(4, "531","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(4, "BBB","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(4, "Leg Curl","false")');

//Week 2 Day 1
        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(5, "Warm Up","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(5, "531","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(5, "BBB","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(5, "Chin-ups","false")');

// day 2
        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(6, "Warm Up","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(6, "531","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(6, "BBB","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(6, "Hanging Leg Raise","false")');

// day 3
        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(7, "Warm Up","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(7, "531","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(7, "BBB","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(7, "Dumbbell Row","false")');

//day 4
        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(8, "Warm Up","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(8, "531","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(8, "BBB","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(8, "Leg Curl","false")');

//Week 3 Day 1
        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(9, "Warm Up","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(9, "531","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(9, "BBB","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(9, "Chin-ups","false")');

// day 2
        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(10, "Warm Up","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(10, "531","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(10, "BBB","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(10, "Hanging Leg Raise","false")');

// day 3
        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(11, "Warm Up","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(11, "531","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(11, "BBB","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(11, "Dumbbell Row","false")');

//day 4
        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(12, "Warm Up","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(12, "531","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(12, "BBB","false")');

        database.rawInsert(
            'INSERT INTO exerciseGroupTitle(idDayTitle, exerciseGroupTitle, currentExerciseGroup) VALUES(12, "Leg Curl","false")');
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
