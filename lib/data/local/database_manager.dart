import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../util/log.util.dart';

class DatabaseManager {
  static late Database database;

  static Future<void> delete(
    dynamic id, {
    required String table,
  }) async {
    LogUtil.log(
      "DatabaseManager",
      message: "Deleting from table: $table at id: $id",
    );
    await database.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteAll(String table) async {
    LogUtil.log(
      "DatabaseManager",
      message: "Deleting all rows from table: $table",
    );
    await database.delete(table);
  }

  static Future<void> update(
    dynamic id, {
    required Map<String, dynamic> data,
    required String table,
  }) async {
    LogUtil.log(
      "DatabaseManager",
      message: "Updating table: $table at id: $id",
    );
    await database.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> readAll(String table) async {
    LogUtil.log(
      "DatabaseManager",
      message: "Reading all from table: $table",
    );
    return await database.query(table);
  }

  static Future<Map<String, dynamic>?> read(
    dynamic id, {
    required String table,
  }) async {
    LogUtil.log(
      "DatabaseManager",
      message: "Reading from table: $table at id: $id",
    );
    try {
      return (await database.query(
        table,
        where: 'id = ?',
        whereArgs: [id],
      ))
          .first;
    } catch (e) {
      return null;
    }
  }

  static Future<void> insert(
    Map<String, dynamic> data, {
    required String table,
  }) async {
    LogUtil.log(
      "DatabaseManager",
      message: "Inserting into table: $table\nData: $data",
    );
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await database.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> init() async {
    LogUtil.log(
      "DatabaseManager",
      message: "Initializing database manager",
    );
    database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'register_database.db'),
      // When the database is first created, create a register table.
      onCreate: (db, version) {
        LogUtil.log(
          "DatabaseManager",
          message: "Creating tables",
        );
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE register(id TEXT PRIMARY KEY, oneThousand INTEGER, fiveHundred INTEGER, twoHundred INTEGER, oneHundred INTEGER, fifty INTEGER, twenty INTEGER, ten INTEGER, five INTEGER, dateModified, TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  static void dispose() {
    LogUtil.log(
      "DatabaseManager",
      message: "Disposing database managet",
    );
    database.close();
  }
}
