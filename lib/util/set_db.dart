import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data/exercise_group_data.dart';
import '../models/set_model.dart';

class SetDb {
  final int version = 1;
  Database db;
  ExerciseGroupData exerciseGroupData = ExerciseGroupData();

  static final SetDb _exerciseGroupTitleDb = SetDb._internal();
  SetDb._internal();
  factory SetDb() {
    return _exerciseGroupTitleDb;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'set66.db'),
          onCreate: (database, version) {
        // weekSql.createWeekTitleTable();
        // weekSql.insertBBBWeeks();
        database.execute(
            'CREATE TABLE setNum(id INTEGER PRIMARY KEY, idExerciseGroupTitle INTEGER, setNumber TEXT,percentage TEXT, reps TEXT, repMaxId INTEGER, completed TEXT, prSet TEXT, ' +
                'FOREIGN KEY(idExerciseGroupTitle)REFERENCES exerciseGroupTitle(id))');

        // warm up data

        // int h = 0;
        // int j = 3;
        for (int i = 0; i < 37; i++) {
          for (int g = 0; g < 4; g++) {
            for (int j = 3; j >= 0; j--) {
              for (var item in exerciseGroupData.setWarmUpData(i + 1, j)) {
                database.rawInsert(
                    'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(${item[0]}, "${item[1]}", "${item[2]}", "5", ${item[3]}, "false", "false")');
              }
            }
          }

          // i += 3;
          // h += 4;
          // if (h % 4 == 0 && h < 13) {
          //   j--;
          // }
        }

        //531 data
        int k = 1;
        int l = 3;
        for (int i = 0; i < 12; i++) {
          if (i % 3 == 0) {
            k++;
            l--;
          }
          for (var item in exerciseGroupData.set531Data(k, l)) {
            database.rawInsert(
                'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(${item[0]}, "${item[1]}", "${item[2]}", "5", ${item[3]}, "false", "false")');
          }
        }

        // BBB data
        int m = 1;
        int n = 3;
        for (int i = 0; i < 12; i++) {
          if (i % 3 == 0) {
            m++;
            n--;
            for (var item in exerciseGroupData.set531Data(m, n)) {
              database.rawInsert(
                  'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(${item[0]}, "${item[1]}", "50", "5", ${item[2]}, "false", "false")');
            }
          }
        }

        // Exercise - Press - Warm Up
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(1, "1", "40", "5", 3, "false", "false")');
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(1, "2", "50", "5", 3, "false", "false")');
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(1, "3", "60", "5", 3, "false", "false")');

//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(2, "1", "65", "5", 3, "false", "false")');
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(2, "2", "75", "5", 3, "false", "false")');
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(2, "3", "85", "5+", 3, "false", "true")');

// //Press BBB
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(3, "1", "50", "10", 3, "false", "false")');
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(3, "2", "50", "10", 3, "false", "false")');
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(3, "3", "50", "10", 3, "false", "false")');
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(3, "4", "50", "10", 3, "false", "false")');
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(3, "5", "50", "10", 3, "false", "false")');

//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(4, "1", "0", "10", 4, "false", "false")');
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(4, "2", "0", "10", 4, "false", "false")');
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(4, "3", "0", "10", 4, "false", "false")');
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(4, "4", "0", "10", 4, "false", "false")');
//         database.rawInsert(
//             'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(4, "5", "0", "10", 4, "false", "false")');
      }, version: version);
    }
    return db;
  }

  Future<int> insertSet(SetModel setModel) async {
    int id = await this.db.insert(
          'setNum',
          setModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return id;
  }

  Future<List<SetModel>> getSets(int idExerciseGroupTitle) async {
    final List<Map<String, dynamic>> maps = await db.query('setNum',
        where: 'idExerciseGroupTitle = ?', whereArgs: [idExerciseGroupTitle]);
    return List.generate(maps.length, (i) {
      return SetModel(
        maps[i]['id'],
        maps[i]['idExerciseGroupTitle'],
        maps[i]['setNumber'],
        maps[i]['percentage'],
        maps[i]['reps'],
        maps[i]['repMaxId'],
        maps[i]['completed'],
        maps[i]['prSet'],
      );
    });
  }

  Future<int> deleteSet(
    SetModel setModel,
  ) async {
    int result =
        await db.delete("setNum", where: "id = ?", whereArgs: [setModel.id]);

    return result;
  }
}
