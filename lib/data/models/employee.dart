import 'package:iconnect_crm/domain/entity/employee.dart';

class Employee extends EmployeeEntity {
  Employee({
    super.id,
    required super.surname,
    required super.name,
    super.patronymic,
    required super.post,
  });

  Map<String, dynamic> toMap() => {
    'surname': surname,
    'name': name,
    'patronymic': patronymic,
    'post': post,
  };

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
    id: json['id'] as int,
    surname: json['surname'],
    name: json['name'],
    patronymic: json['patronymic'],
    post: json['post'],
  );
}
