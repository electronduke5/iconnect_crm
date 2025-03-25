import 'dart:io';

import 'package:iconnect_crm/core/db/db_script.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();

  factory DatabaseHelper() => instance;

  DatabaseHelper._instance();

  final int _version = 1;
  static String? _pathDB;
  static Directory? _appSupportDirectory;
  static Database? _database;

  Future<Database> get database async => _database ??= await init();

  Future<Database> init() async {
    _appSupportDirectory = await path_provider.getApplicationSupportDirectory();
    _pathDB = path.join(_appSupportDirectory!.path, DatabaseRequest.dbName);
    print('DB Path: $_pathDB');

    sqfliteFfiInit();
    return _database = await databaseFactoryFfi.openDatabase(
      _pathDB!,
      options: OpenDatabaseOptions(
        version: _version,
        onConfigure: _onConfigure,
        onCreate: (db, version) => onCreateTable,
        onUpgrade: (db, oldVersion, newVersion) => _onUpgrade,
      ),
    );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {}
  }

  static String getPathForSaveDbCopy() => path.join(_appSupportDirectory!.path, 'iConnect CRM DB dumps');

  Future<Map<String, dynamic>> insert(
      Map<String, dynamic> data, String table) async {
    Database db = await instance.database;
    int createdId = await db.insert(table, data);
    return await queryById(createdId, table);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(
      String table, {
        Map<String, dynamic>? whereItems,
      }) async {
    Database db = await instance.database;
    if (whereItems == null || whereItems.isEmpty) {
      return await db.query(table);
    }
    return await db.query(table,
        where: whereItems.keys.map((key) => '$key = ?').join(' AND '),
        whereArgs: whereItems.values.toList());
  }

  Future<List<Map<String, dynamic>>> queryAllRowsWithReference({
    required String table,
    required List<String> referenceTables,
    required List<String> referenceColumns,
    String? whereColumn,
    String? whereArg,
  }) async {
    Database db = await instance.database;
    if (whereColumn != null && whereArg?.isEmpty == false) {}
    return await db.rawQuery(
      DatabaseSelectRequests.selectAllWithReference(
        table: table,
        referenceTables: referenceTables,
        referenceColumns: referenceColumns,
        whereColumn: whereColumn,
        whereArg: whereArg,
      ),
    );
  }

  Future<Map<String, dynamic>> queryByIdWithReference({
    required int id,
    required String table,
    required String referenceTable,
    required String referenceColumn,
  }) async {
    Database db = await instance.database;
    final result = await db.rawQuery(DatabaseSelectRequests.selectWithReference(
      table,
      referenceTable,
      referenceColumn,
      id,
    ));
    return result.first;
  }

  Future<List<Map<String, dynamic>>> searchQuery(
      String table,
      List<String> searchingColumns,
      String searchingValue, {
        String? whereColumn,
        String? whereArg,
      }) async {
    Database db = await instance.database;

    if (whereColumn != null && whereArg?.isEmpty == false) {
      return await db.query(
        table,
        where:
        '$whereColumn = $whereArg AND (${searchingColumns.map((column) => '$column LIKE \'%$searchingValue%\'').join(' OR ')})',
      );
    }
    return await db.query(
      table,
      where: searchingColumns
          .map((column) => '$column LIKE \'%$searchingValue%\'')
          .join(' OR '),
    );
  }

  Future<List<Map<String, dynamic>>> searchQueryWithReference({
    required String table,
    required List<String> searchingColumns,
    required String searchingValue,
    required List<String> referenceTables,
    required List<String> referenceColumns,
    String? whereColumn,
    String? whereArg,
  }) async {
    Database db = await instance.database;

    return await db.rawQuery(
      DatabaseSelectRequests.searchWithReference(
        table: table,
        referenceTables: referenceTables,
        referenceColumns: referenceColumns,
        searchingColumns: searchingColumns,
        searchingValue: searchingValue,
        whereColumn: whereColumn,
        whereArg: whereArg,
      ),
    );
  }

  Future<Map<String, dynamic>> update(
      int id, Map<String, dynamic> data, String table) async {
    Database db = await instance.database;
    await db.update(table, data, where: 'id = ?', whereArgs: [id]);
    return await queryById(id, table);
  }

  Future<int> delete(int id, String table) async {
    Database db = await instance.database;
    int resDelete = await db.delete(table, where: 'id = ?', whereArgs: [id]);
    return resDelete;
  }

  Future<int> deleteWhere(String table, String whereColumn, List<dynamic> whereArgs) async {
    Database db = await instance.database;
    int resDelete = await db.delete(table, where: '$whereColumn = ?', whereArgs: whereArgs);
    return resDelete;
  }

  Future<Map<String, dynamic>> queryById(int id, String table) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
    await db.query(table, where: 'id = ?', whereArgs: [id]);
    return result.first;
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> onDropDatabase() async {
    print('onDrop');
    await instance.database.then((db) => db.close());

    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactoryFfi.deleteDatabase(_pathDB!);
    } else {
      deleteDatabase(_pathDB!);
    }
  }

  Future<void> onCreateTable(Database db) async {
    print('onCreateTable Fun');
    for (var tableCreateString in DatabaseRequest.tableCreateList) {
      await db.execute(tableCreateString);
    }
  }

  Future<File> dbToCopy() async {
    return File(_pathDB!);
  }
}