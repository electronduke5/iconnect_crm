import 'package:flutter/material.dart';

enum ColorEnum {
  red(name: 'Красный', color: Colors.red),
  blue(name: 'Синий', color: Colors.blueAccent),
  green(name: 'Зеленый', color: Colors.green),
  yellow(name: 'Желтый', color: Colors.yellow),
  orange(name: 'Оранжевый', color: Colors.orange),
  purple(name: 'Фиолетовый', color: Colors.purple),
  pink(name: 'Розовый', color: Colors.pink),
  brown(name: 'Коричневый', color: Colors.brown),
  grey(name: 'Серый', color: Colors.grey),
  black(name: 'Черный', color: Colors.black),
  white(name: 'Белый', color: Colors.white),
  teal(name: 'Бирюзовый', color: Colors.teal),
  lightBlue(name: 'Голубой', color: Colors.lightBlue),
  lightGreen(name: 'Салатовый', color: Colors.lightGreen),
  amber(name: 'Золотой', color: Colors.amber),
  blueGrey(name: 'Серебряный', color: Colors.blueGrey);

  final String name;
  final Color color;

  const ColorEnum({required this.name, required this.color});

  // Метод для получения enum по русскому названию
  static ColorEnum? fromName(String name) {
    for (var value in ColorEnum.values) {
      if (value.name == name.toLowerCase()) {
        return value;
      }
    }
    return null;
  }

  // Метод для получения всех русских названий
  static List<String> get allNames =>
      ColorEnum.values.map((e) => e.name).toList();

  static Map<String, Color> toMap() {
    return {for (var color in ColorEnum.values) color.name: color.color};
  }
}
