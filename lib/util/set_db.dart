import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/set_model.dart';

class SetDb {
  final int version = 1;
  Database db;

  static final SetDb _exerciseGroupTitleDb = SetDb._internal();
  SetDb._internal();
  factory SetDb() {
    return _exerciseGroupTitleDb;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'set42.db'),
          onCreate: (database, version) {
        // weekSql.createWeekTitleTable();
        // weekSql.insertBBBWeeks();
        database.execute(
            'CREATE TABLE setNum(id INTEGER PRIMARY KEY, idExerciseGroupTitle INTEGER, setNumber TEXT,percentage TEXT, reps TEXT, repMaxId INTEGER, completed TEXT, prSet TEXT, ' +
                'FOREIGN KEY(idExerciseGroupTitle)REFERENCES exerciseGroupTitle(id))');

        // Exercise - Press - Warm Up
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(1, "1", "40", "5", 3, "false", "false")');
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(1, "2", "50", "5", 3, "false", "false")');
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(1, "3", "60", "5", 3, "false", "false")');

        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(2, "1", "65", "5", 3, "false", "false")');
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(2, "2", "75", "5", 3, "false", "false")');
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(2, "3", "85", "5+", 3, "false", "true")');

//Press BBB
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(3, "1", "50", "10", 3, "false", "false")');
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(3, "2", "50", "10", 3, "false", "false")');
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(3, "3", "50", "10", 3, "false", "false")');
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(3, "4", "50", "10", 3, "false", "false")');
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(3, "5", "50", "10", 3, "false", "false")');

        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(4, "1", "0", "10", 4, "false", "false")');
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(4, "2", "0", "10", 4, "false", "false")');
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(4, "3", "0", "10", 4, "false", "false")');
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(4, "4", "0", "10", 4, "false", "false")');
        database.rawInsert(
            'INSERT INTO setNum(idExerciseGroupTitle, setNumber, percentage, reps, repMaxId, completed, prSet) VALUES(4, "5", "0", "10", 4, "false", "false")');
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
