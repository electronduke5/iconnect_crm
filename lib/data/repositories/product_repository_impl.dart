import 'package:dartz/dartz.dart';
import 'package:iconnect_crm/common/failure.dart';
import 'package:iconnect_crm/core/db/database_service.dart';
import 'package:iconnect_crm/core/db/db_script.dart';
import 'package:iconnect_crm/data/models/product.dart';
import 'package:iconnect_crm/domain/repositories/product_repository.dart';

import '../models/category.dart';
import '../models/phone.dart';

class ProductRepositoryImpl
    with DatabaseService<Product>
    implements ProductRepository {
  @override
  Future<Either<Failure, Product>> createProduct({
    required String title,
    String? serialNumber,
    int? count,
    required int purchasePrice,
    String? dateOfPurchase,
    required Category category,
    Phone? phone,
  }) async {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteProduct(Product product) async {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    final products = await getAll(
      fromMap: (Map<String, dynamic> json) => Product.fromMap(json),
      table: DatabaseRequest.tableProducts,
    );

    return products.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, Product>> updateProduct({required}) async {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
