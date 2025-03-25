import 'package:iconnect_crm/domain/entity/category.dart';

class Category extends CategoryEntity {
  Category({super.id, required super.title});

  Map<String, dynamic> toMap() => {'title': title};

  factory Category.fromMap(Map<String, dynamic> json) =>
      Category(id: json['id'] as int, title: json['title']);
}
