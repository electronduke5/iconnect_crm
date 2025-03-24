import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../common/failure.dart';
import 'db_helper.dart';

mixin DatabaseService<T extends Object> {
  Future<Either<Failure, List<T>>> getAll({
    required T Function(Map<String, dynamic>) fromMap,
    required String table,
    Map<String, dynamic>? whereItems,
  }) async {
    try {
      if (whereItems == null) {
        final response = await DatabaseHelper.instance.queryAllRows(table);
        List<T> listT = response.map((element) => fromMap(element)).toList();
        return Right(listT);
      }
      final response = await DatabaseHelper.instance.queryAllRows(
        table,
        whereItems: whereItems.map((key, value) => MapEntry(key, value)),
      );
      List<T> listT = response.map((element) => fromMap(element)).toList();
      return Right(listT);
    } on DatabaseException catch (error) {
      return Left(Failure(error, error.toString(), error.getResultCode()));
    }
  }

  Future<Either<Failure, List<T>>> getAllWithReference({
    required T Function(Map<String, dynamic>) fromMap,
    required String table,
    required List<String> referenceTables,
    required List<String> referenceColumns,
    String? whereColumn,
    String? whereArg,
  }) async {
    try {
      final response = await DatabaseHelper.instance.queryAllRowsWithReference(
        table: table,
        referenceTables: referenceTables,
        referenceColumns: referenceColumns,
        whereColumn: whereColumn,
        whereArg: whereArg,
      );
      List<T> listT = response.map((element) => fromMap(element)).toList();
      return Right(listT);
    } on DatabaseException catch (error) {
      return Left(Failure(error, error.toString(), error.getResultCode()));
    }
  }

  Future<Either<Failure, List<T>>> search({
    required T Function(Map<String, dynamic>) fromMap,
    required String table,
    required List<String> searchingColumns,
    required String searchingValue,
    List<String>? referenceTables,
    List<String>? referenceColumns,
    String? whereColumn,
    String? whereArg,
  }) async {
    try {
      if (referenceTables != null && referenceColumns != null) {
        final response = await DatabaseHelper.instance.searchQueryWithReference(
          table: table,
          searchingColumns: searchingColumns,
          searchingValue: searchingValue,
          referenceTables: referenceTables,
          referenceColumns: referenceColumns,
          whereColumn: whereColumn,
          whereArg: whereArg,
        );
        List<T> listT = response.map((element) => fromMap(element)).toList();
        return Right(listT);
      }
      final response = await DatabaseHelper.instance.searchQuery(
          table, searchingColumns, searchingValue,
          whereArg: whereArg, whereColumn: whereColumn);
      List<T> listT = response.map((element) => fromMap(element)).toList();
      return Right(listT);
    } on DatabaseException catch (error) {
      return Left(Failure(error, error.toString(), error.getResultCode()));
    }
  }

  Future<Either<Failure, T>> getObjectById({
    required T Function(Map<String, dynamic>) fromMap,
    required String table,
    required int id,
  }) async {
    try {
      final response = await DatabaseHelper.instance.queryById(id, table);
      return Right(fromMap(response));
    } on DatabaseException catch (error) {
      return Left(Failure(error, error.toString(), error.getResultCode()));
    }
  }

  // Future<Either<Failure, T>> getObjectByColumn({
  //   required T Function(Map<String, dynamic>) fromMap,
  //   required String table,
  //   required String columnName,
  //   required dynamic columnValue,
  // }) async {
  //   try {
  //     final response = await DatabaseHelper.instance.queryByColumn(table, columnName, columnValue);
  //     return Right(fromMap(response));
  //   } on DatabaseException catch (error) {
  //     return Left(Failure(error, error.toString(), error.getResultCode()));
  //   }
  // }

  Future<Either<Failure, T>> createObject({
    required T Function(Map<String, dynamic>) fromMap,
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await DatabaseHelper.instance.insert(data, table);
      return Right(fromMap(response));
    } on DatabaseException catch (error) {
      //print('DB ERROR: $error');
      //print('ERROR Result code: ${error.getResultCode()}');
      return Left(Failure(error, error.toString(), error.getResultCode()));
    }
  }

  Future<Either<Failure, T>> updateObject({
    required T Function(Map<String, dynamic>) fromMap,
    required String table,
    required Map<String, dynamic> data,
    required int id,
  }) async {
    try {
      final response = await DatabaseHelper.instance.update(id, data, table);

      return Right(fromMap(response));
    } on DatabaseException catch (error) {
      return Left(Failure(error, error.toString(), error.getResultCode()));
    }
  }

  Future<Either<Failure, String>> deleteObject({
    required String table,
    required int id,
  }) async {
    try {
      final resultString = await DatabaseHelper.instance.delete(id, table).then(
          (value) =>
              value == 1 ? 'Успешно удалена 1 запись' : 'Ошибка удаления');
      return Right(resultString);
    } on DatabaseException catch (error) {
      return Left(Failure(error, error.toString(), error.getResultCode()));
    }
  }

  Future<Either<Failure, String>> deleteObjectWhere({
    required String table,
    required String whereColumn,
    required List<dynamic> whereArgs,
  }) async {
    try {
      final resultString = await DatabaseHelper.instance
          .deleteWhere(table, whereColumn, whereArgs)
          .then(
            (value) =>
                value == 1 ? 'Успешно удалена 1 запись' : 'Ошибка удаления',
          );
      return Right(resultString);
    } on DatabaseException catch (error) {
      return Left(Failure(error, error.toString(), error.getResultCode()));
    }
  }
}
