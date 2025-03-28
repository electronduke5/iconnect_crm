import 'package:dartz/dartz.dart';
import 'package:iconnect_crm/common/failure.dart';

import '../../data/models/category.dart';
import '../../data/models/phone.dart';
import '../../data/models/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();

  Future<Either<Failure, Product>> createProduct({
    required String title,
    String? serialNumber,
    int? count,
    required int purchasePrice,
    String? dateOfPurchase,
    required Category category,
    Phone? phone,
  });

  Future<Either<Failure, Product>> updateProduct({required});

  Future<Either<Failure, bool>> deleteProduct(Product product);
}
