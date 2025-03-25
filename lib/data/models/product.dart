import 'package:iconnect_crm/data/models/category.dart';
import 'package:iconnect_crm/data/models/cheque.dart';
import 'package:iconnect_crm/data/models/phone.dart';
import 'package:iconnect_crm/domain/entity/product.dart';

class Product extends ProductEntity {
  Product({
    super.id,
    required super.title,
    super.serialNumber,
    super.count,
    super.warrantyCount,
    required super.purchasePrice,
    super.salePrice,
    super.profit,
    super.dateOfPurchase,
    super.dateOfSale,
    required super.category,
    super.phone,
    super.cheque,
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'serial_number': serialNumber,
    'count': count,
    'warranty_count': warrantyCount,
    'purchase_price': purchasePrice,
    'sale_price': salePrice,
    'profit': profit,
    'date_of_purchase': dateOfPurchase,
    'date_of_sale': dateOfSale,
    'category_id': category.id,
    'phone_id': phone?.id,
    'cheque_id': cheque?.id,
  };

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json['id'] as int,
    title: json['title'],
    serialNumber: json['serial_number'],
    count: json['count'] as int?,
    warrantyCount: json['warranty_count'] as int?,
    purchasePrice: json['purchase_price'] as int,
    salePrice: json['sale_price'] as int?,
    profit: json['profit'] as int?,
    dateOfPurchase: json['date_of_purchase'],
    dateOfSale: json['date_of_sale'],
    category: Category.fromMap(<String, dynamic>{
      'id': json['category_id'] as int,
      'title': json['title'],
    }),
    phone: Phone.fromMap(<String, dynamic>{
      'id': json['phone_id'] as int?,
      'color': json['color'],
      'battery_status': json['battery_status'],
    }),
    cheque: Cheque.fromMap(<String, dynamic>{
      'id': json['cheque_id'] as int,
      'date': json['date'],
      'total_cost': json['total_cost'] as int,
      'total_discount': json['total_discount'] as int,
      'employee_id': json['employee_id'] as int,
    }),
  );
}
