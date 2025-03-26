import 'package:dartz/dartz.dart';
import 'package:iconnect_crm/common/failure.dart';
import 'package:iconnect_crm/core/db/database_service.dart';
import 'package:iconnect_crm/core/db/db_script.dart';
import 'package:iconnect_crm/data/models/category.dart';
import 'package:iconnect_crm/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl
    with DatabaseService<Category>
    implements CategoryRepository {
  @override
  Future<Either<Failure, Category>> createCategory({
    required String title,
  }) async {
    final createdCategory = await createObject(
      fromMap: (Map<String, dynamic> json) => Category.fromMap(json),
      table: DatabaseRequest.tableCategories,
      data: Category(title: title).toMap(),
    );
    return createdCategory.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, bool>> deleteCategory(int id) async {
    final resultDelete = await deleteObject(
      table: DatabaseRequest.tableCategories,
      id: id,
    );
    return resultDelete.fold((l) => Left(l), (r) => Right(true));
  }

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    final categories = await getAll(
      fromMap: (Map<String, dynamic> json) => Category.fromMap(json),
      table: DatabaseRequest.tableCategories,
    );
    return categories.fold(
          (l) => Left(l),
          (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, Category>> updateCategory({
    required int id,
    required String title,
  }) async {
    final resultUpdate = await updateObject(
      fromMap: (Map<String, dynamic> json) => Category.fromMap(json),
      table: DatabaseRequest.tableCategories,
      data: {'title': title},
      id: id,
    );
    return resultUpdate.fold((l) => Left(l), (r) => Right(r));
  }
}
