class CategoryEntity{
  late int id;
  final String title;

  CategoryEntity({
    this.id = 0,
    required this.title,
});
}

enum InitCategoriesEnum {
  smartphones(id: 1, title: 'Смартфоны'),
  tv(id: 2, title: 'Телевизоры'),
  playStations(id: 3, title: 'Приставки'),
  accessories(id: 4, title: 'Аксессуары');

  final int id;
  final String title;

  const InitCategoriesEnum({
    required this.id,
    required this.title,
  });
}