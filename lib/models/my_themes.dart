import 'package:flutter/material.dart';

//класс для хранения двух тем приложения
class MyTheme {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF6750A4),
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
      errorContainer: Color(0xFFF9DEDC),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410E0B),
      background: Color(0xFFFFFBFE),
      onBackground: Color(0xFF1C1B1F),
      surface: Color(0xFFFFFBFE),
      onSurface: Color(0xFF1C1B1F),
      surfaceVariant: Color(0xFFE7E0EC),
      onSurfaceVariant: Color(0xFF49454F),
      outline: Color(0xFF79747E),
      onInverseSurface: Color.fromARGB(255, 174, 165, 179),
      inverseSurface: Color(0xFF313033),
      inversePrimary: Color(0xFFD0BCFF),
      shadow: Color(0xFF000000),
    ),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Color(0xFF1C1B1F),
        fontSize: 16,
      ),
      bodyLarge: TextStyle(
        color: Color(0xFF625B71),
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFD0BCFF),
      onPrimary: Color(0xFF381E72),
      primaryContainer: Color(0xFF4F378B),
      onPrimaryContainer: Color(0xFFEADDFF),
      secondary: Color(0xFFCCC2DC),
      onSecondary: Color(0xFF332D41),
      secondaryContainer: Color(0xFF4A4458),
      onSecondaryContainer: Color(0xFFE8DEF8),
      tertiary: Color(0xFFEFB8C8),
      onTertiary: Color(0xFF492532),
      tertiaryContainer: Color(0xFF633B48),
      onTertiaryContainer: Color(0xFFFFD8E4),
      error: Color(0xFFF2B8B5),
      errorContainer: Color(0xFF8C1D18),
      onError: Color(0xFF601410),
      onErrorContainer: Color(0xFFF9DEDC),
      background: Color(0xFF1C1B1F),
      onBackground: Color(0xFFE6E1E5),
      surface: Color(0xFF1C1B1F),
      onSurface: Color(0xFFE6E1E5),
      surfaceVariant: Color(0xFF49454F),
      onSurfaceVariant: Color(0xFFCAC4D0),
      outline: Color(0xFF938F99),
      onInverseSurface: Color.fromARGB(255, 115, 109, 126),
      inverseSurface: Color(0xFFE6E1E5),
      inversePrimary: Color(0xFF6750A4),
      shadow: Color(0xFF000000),
    ),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Color(0xFFE6E1E5),
        fontSize: 16,
      ),
      bodyLarge: TextStyle(
        color: Color(0xFFD0BCFF),
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
