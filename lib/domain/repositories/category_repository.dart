import 'package:dartz/dartz.dart';
import 'package:iconnect_crm/common/failure.dart';
import 'package:iconnect_crm/data/models/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();

  Future<Either<Failure, Category>> createCategory({required String title});

  Future<Either<Failure, Category>> updateCategory({
    required int id,
    required String title,
  });

  Future<Either<Failure, bool>> deleteCategory(int id);
}
