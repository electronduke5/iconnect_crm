class EmployeeEntity {
  late int id;
  final String surname;
  final String name;
  final String? patronymic;
  final String post;

  EmployeeEntity({
    this.id = 0,
    required this.surname,
    required this.name,
    this.patronymic,
    required this.post,
  });
}
