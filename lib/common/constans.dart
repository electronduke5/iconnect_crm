import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  fontFamily: GoogleFonts
      .rubik()
      .fontFamily,
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xFFFAFBFF),
  cardColor: Colors.white,
  cardTheme: CardTheme(
    color: Colors.white,
  ),
  listTileTheme: ListTileThemeData(
    selectedColor: Colors.white,
    selectedTileColor: lightColorScheme.primary,
    textColor: Color(0xFF9197B3),
  ),
);

final ThemeData darkTheme = ThemeData(
  listTileTheme: ListTileThemeData(
    selectedTileColor: lightColorScheme.primary,
    selectedColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),

  fontFamily: GoogleFonts
      .rubik()
      .fontFamily,
  useMaterial3: true,
  colorScheme: darkColorScheme,
  disabledColor: Color(0xFF9197B3),
  scaffoldBackgroundColor: Color(0xFF202020),
  cardColor: Color(0xFF242424),
  cardTheme: CardTheme(
    color: Color(0xFF242424),
  ),
);

//Класс где цвета меняются в зависимости от установленной темы
class DynamicColors {
  static final Color greenIconDataColor = Color(0xFF00AC4F);
  static final Color greenIconBackgroundColor = Color(0xFFD3FFE7);

  static final Color secondaryTextColor = Color(0xFFACACAC);
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF5932EA),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFEADDFF),
  onPrimaryContainer: Color(0xFF21005D),
  secondary: Color(0xFF625B71),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE8DEF8),
  onSecondaryContainer: Color(0xFF1D192B),
  tertiary: Color(0xFF7D5260),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD8E4),
  onTertiaryContainer: Color(0xFF31111D),
  error: Color(0xFFB3261E),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFF9DEDC),
  onErrorContainer: Color(0xFF410E0B),
  outline: Color(0xFF79747E),
  surface: Color(0xFFFFFBFE),
  onSurface: Color(0xFF1C1B1F),
  onSurfaceVariant: Color(0xFF49454F),
  inverseSurface: Color(0xFF313033),
  onInverseSurface: Color(0xFFF4EFF4),
  inversePrimary: Color(0xFFD0BCFF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF6750A4),
);


const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.white,
  onPrimary: Color(0xFF381E72),
  primaryContainer: Color(0xFF4F378B),
  onPrimaryContainer: Color(0xFFEADDFF),
  secondary: Color(0xFFCCC2DC),
  onSecondary: Color(0xFF332D41),
  secondaryContainer: Color(0xFF4A4458),
  onSecondaryContainer: Color(0xFFE8DEF8),
  tertiary: Color(0xFFEFFFF6),
  onTertiary: Color(0xFF00AC4F),
  tertiaryContainer: Color(0xFF633B48),
  onTertiaryContainer: Color(0xFFFFD8E4),
  error: Color(0xFFF2B8B5),
  onError: Color(0xFF601410),
  errorContainer: Color(0xFF8C1D18),
  onErrorContainer: Color(0xFFF9DEDC),
  outline: Color(0xFF938F99),
  surface: Color(0xFF5932EA),
  onSurface: Color(0xFFE6E1E5),
  onSurfaceVariant: Color(0xFFCAC4D0),
  inverseSurface: Color(0xFFE6E1E5),
  onInverseSurface: Color(0xFF313033),
  inversePrimary: Color(0xFF6750A4),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFD0BCFF),
);
