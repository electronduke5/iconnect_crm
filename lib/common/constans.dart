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

  factory DynamicColors() => DynamicColors._();
  DynamicColors._();
  final Color primaryColor =
      ThemeMode.light == true ? Color(0xFF5932EA) : Color(0xFF5932EA);

  static final Color greenIconDataColor = Color(0xFF00AC4F);
  static final Color greenIconBackgroundColor = Color(0xFFD3FFE7);
  static final Color primaryTextColor = Colors.black;
  static final Color secondaryTextColor = Color(0xFFACACAC);
}

