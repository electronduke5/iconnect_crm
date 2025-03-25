import '../../data/models/category.dart';
import '../../data/models/cheque.dart';
import '../../data/models/phone.dart';

class ProductEntity {
  late int id;
  final String title;
  final String? serialNumber;
  final int? count;
  final int? warrantyCount;
  final int purchasePrice;
  final int? salePrice;
  final int? profit;
  final String? dateOfPurchase;
  final String? dateOfSale;
  final Category category;
  final Phone? phone;
  final Cheque? cheque;

  ProductEntity({
    this.id = 0,
    required this.title,
    this.serialNumber,
    this.count,
    this.warrantyCount,
    required this.purchasePrice,
    this.salePrice,
    this.profit,
    this.dateOfPurchase,
    this.dateOfSale,
    required this.category,
    this.phone,
    this.cheque,
  });
}
