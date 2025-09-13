import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "app_color_scheme.dart";

class AppTheme {
  final TextTheme _textTheme = GoogleFonts.getTextTheme("Noto Sans");

  ThemeData light() => _theme(lightScheme);
  ThemeData dark() => _theme(darkScheme);

  ThemeData _theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      centerTitle: true,
    ),
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: _textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );
}
