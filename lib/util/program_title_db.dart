import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/program_title_model.dart';

class ProgramTitleDb {
  final int version = 1;
  Database db;

  static final ProgramTitleDb _programTitleDb = ProgramTitleDb._internal();
  ProgramTitleDb._internal();
  factory ProgramTitleDb() {
    return _programTitleDb;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(
          join(await getDatabasesPath(), 'programTitle28.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE programTitle(id INTEGER PRIMARY KEY, title TEXT, currentProgram TEXT)');
        // weekSql.createWeekTitleTable();
        database.rawInsert(
            'INSERT INTO programTitle(title, currentProgram) VALUES("Boring But Big", "false")');

        // weekSql.insertBBBWeeks();
      }, version: version);
    }
    return db;
  }

  Future<int> insertProgramTitle(ProgramTitleModel programTitleModel) async {
    int id = await this.db.insert(
          'programTitle',
          programTitleModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return id;
  }

  Future<List<ProgramTitleModel>> getPrograms() async {
    final List<Map<String, dynamic>> maps = await db.query('programTitle');
    return List.generate(maps.length, (i) {
      return ProgramTitleModel(
        maps[i]['id'],
        maps[i]['title'],
        maps[i]['currentProgram'],
      );
    });
  }

  Future<int> deleteProgram(
    ProgramTitleModel program,
  ) async {
    // int result = await db.delete("exerciseNameAndTitle",
    //     where: "idProgramTitle = ?", whereArgs: [program.id]);
    int result = await db
        .delete("programTitle", where: "id = ?", whereArgs: [program.id]);
    // result = await db
    //     .delete("week", where: "idProgramTitle = ?", whereArgs: [program.id]);
    // result =
    //     await db.delete("day", where: "idWeek = ?", whereArgs: [program.id]);
    // result = await db
    //     .delete("exerciseTitle", where: "idDay = ?", whereArgs: [program.id]);
    return result;
  }
}
