import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/rep_max.dart';

class RepMaxDb {
  final int version = 1;
  Database db;

  static final RepMaxDb _repMaxDb = RepMaxDb._internal();
  RepMaxDb._internal();
  factory RepMaxDb() {
    return _repMaxDb;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'repMax3.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE repMax(id INTEGER PRIMARY KEY, lift TEXT, repMax TEXT, trainingMax TEXT)');

        database.rawInsert(
            'INSERT INTO repMax(lift, repMax, trainingMax) VALUES("Squat", "68", "60")');
        database.rawInsert(
            'INSERT INTO repMax(lift, repMax, trainingMax) VALUES("Bench", "86", "80")');
        database.rawInsert(
            'INSERT INTO repMax(lift, repMax, trainingMax) VALUES("DeadLift", "120", "110")');
        database.rawInsert(
            'INSERT INTO repMax(lift, repMax, trainingMax) VALUES("Press", "65", "55")');
        database.rawInsert(
            'INSERT INTO repMax(lift, repMax, trainingMax) VALUES("Chin-ups", "5", "BW")');
      }, version: version);
    }
    return db;
  }

  Future<int> insertRepMax(RepMaxModel repMaxModel) async {
    int id = await this.db.insert(
          'repMax',
          repMaxModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return id;
  }

  Future<List<RepMaxModel>> getRepMaxes() async {
    final List<Map<String, dynamic>> maps = await db.query('repMax');
    return List.generate(maps.length, (i) {
      return RepMaxModel(
        maps[i]['id'],
        maps[i]['lift'],
        maps[i]['repMax'],
        maps[i]['trainingMax'],
      );
    });
  }

  Future<int> deleteRepMax(
    RepMaxModel repMax,
  ) async {
    int result =
        await db.delete("repMax", where: "id = ?", whereArgs: [repMax.id]);

    return result;
  }
}
