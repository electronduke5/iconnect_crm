import 'package:iconnect_crm/domain/entity/cheque.dart';

import 'employee.dart';

class Cheque extends ChequeEntity {
  Cheque({
    super.id,
    required super.date,
    required super.totalCost,
    super.totalDiscount,
    required super.employee,
  });

  Map<String, dynamic> toMap() => {
    'date': date,
    'total_cost': totalCost,
    'total_discount': totalDiscount,
    'employee_id': employee.id,
  };

  factory Cheque.fromMap(Map<String, dynamic> json) => Cheque(
    id: json['id'] as int,
    date: json['date'],
    totalCost: json['total_cost'] as int,
    totalDiscount: json['total_discount'] as int,
    employee: Employee.fromMap(<String, dynamic>{
      'id': json['employee_id'] as int,
      'surname': json['surname'],
      'name': json['name'],
      'patronymic': json['patronymic'],
      'post': json['post'],
    }),
  );
}
