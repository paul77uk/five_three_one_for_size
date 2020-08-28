import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/day_title_model.dart';

class DayTitleDb {
  final int version = 1;
  Database db;

  static final DayTitleDb _dayTitleDb = DayTitleDb._internal();
  DayTitleDb._internal();
  factory DayTitleDb() {
    return _dayTitleDb;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'dayTitle1.db'),
          onCreate: (database, version) {
        // weekSql.createWeekTitleTable();
        // weekSql.insertBBBWeeks();
        database.execute(
            'CREATE TABLE dayTitle(id INTEGER PRIMARY KEY, idWeekTitle INTEGER, dayNum TEXT, currentDay TEXT, ' +
                'FOREIGN KEY(idWeekTitle)REFERENCES weekTitle(id))');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(1, "Day 1","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(1, "Day 2","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(1, " Day 3","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(1, "Day 4","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(1, "Day 5","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(1, "Day 6","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(2, "Day 1","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(2, "Day 2","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(2, " Day 3","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(2, "Day 4","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(2, "Day 5","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(2, "Day 6","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(3, "Day 1","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(3, "Day 2","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(3, " Day 3","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(3, "Day 4","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(3, "Day 5","false")');

        database.rawInsert(
            'INSERT INTO dayTitle(idWeekTitle, dayNum, currentDay) VALUES(3, "Day 6","false")');
      }, version: version);
    }
    return db;
  }

  Future<int> insertDayTitle(DayTitleModel dayTitleModel) async {
    int id = await this.db.insert(
          'dayTitle',
          dayTitleModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    return id;
  }

  Future<List<DayTitleModel>> getDays(int idWeekTitle) async {
    final List<Map<String, dynamic>> maps = await db
        .query('dayTitle', where: 'idWeekTitle = ?', whereArgs: [idWeekTitle]);
    return List.generate(maps.length, (i) {
      return DayTitleModel(
        maps[i]['id'],
        maps[i]['idWeekTitle'],
        maps[i]['dayNum'],
        maps[i]['currentDay'],
      );
    });
  }

  Future<int> deleteDay(
    DayTitleModel day,
  ) async {
    int result =
        await db.delete("dayTitle", where: "id = ?", whereArgs: [day.id]);

    return result;
  }
}
