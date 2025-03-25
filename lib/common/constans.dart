import 'package:flutter/material.dart';

final ThemeData mainTheme = ThemeData(
  primaryColor: Color(0xFF5932EA),
  disabledColor: Color(0xFF9197B3),
  scaffoldBackgroundColor: Color(0xFFFAFBFF),
  cardTheme: CardTheme(
    color: Colors.white,
  ),
);

final ThemeData mainThemeDark = ThemeData(
  primaryColor: Color(0xFF5932EA),
  disabledColor: Color(0xFF9197B3),
  scaffoldBackgroundColor: Color(0xFF273142),
);

//Класс где цвета меняются в зависимости от установленной темы
class DynamicColors {
  final Color primaryColor =
      ThemeMode.light == true ? Color(0xFF5932EA) : Color(0xFF5932EA);

  final Color greenIconDataColor = Color(0xFF00AC4F);
  final Color greenIconBackgroundColor = Color(0xFFD3FFE7);
}