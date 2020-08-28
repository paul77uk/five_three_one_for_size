import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/week_title_model.dart';

class WeekTitleDb {
  final int version = 1;
  Database db;

  static final WeekTitleDb _weekTitleDb = WeekTitleDb._internal();
  WeekTitleDb._internal();
  factory WeekTitleDb() {
    return _weekTitleDb;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'weekTitle6.db'),
          onCreate: (database, version) {
        // weekSql.createWeekTitleTable();
        // weekSql.insertBBBWeeks();
        database.execute(
            'CREATE TABLE weekTitle(id INTEGER PRIMARY KEY, idProgramTitle INTEGER, weekNum TEXT, currentWeek TEXT, ' +
                'FOREIGN KEY(idProgramTitle)REFERENCES programTitle(id))');

        database.rawInsert(
            'INSERT INTO weekTitle(idProgramTitle, weekNum, currentWeek) VALUES(1, "Week 1","false")');

        database.rawInsert(
            'INSERT INTO weekTitle(idProgramTitle, weekNum, currentWeek) VALUES(1, "Week 2","false")');

        database.rawInsert(
            'INSERT INTO weekTitle(idProgramTitle, weekNum, currentWeek) VALUES(1, "Week 3","false")');
      }, version: version);
    }
    return db;
  }

  Future<int> insertWeekTitle(WeekTitleModel weekTitleModel) async {
    int id = await this.db.insert(
          'weekTitle',
          weekTitleModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return id;
  }

  Future<List<WeekTitleModel>> getWeeks(int idProgramTitle) async {
    final List<Map<String, dynamic>> maps = await db.query('weekTitle',
        where: 'idProgramTitle = ?', whereArgs: [idProgramTitle]);
    return List.generate(maps.length, (i) {
      return WeekTitleModel(
        maps[i]['id'],
        maps[i]['idProgramTitle'],
        maps[i]['weekNum'],
        maps[i]['currentWeek'],
      );
    });
  }

  Future<int> deleteWeek(
    WeekTitleModel week,
  ) async {
    int result =
        await db.delete("weekTitle", where: "id = ?", whereArgs: [week.id]);

    return result;
  }
}
