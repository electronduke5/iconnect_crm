import '../../data/models/employee.dart';

class ChequeEntity{
  late int id;
  final String date;
  final int totalCost;
  final int? totalDiscount;
  final Employee employee;

  ChequeEntity({
    this.id = 0,
    required this.date,
    required this.totalCost,
    this.totalDiscount,
    required this.employee,
});
}