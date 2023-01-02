import 'package:flutter/material.dart';
import 'package:formularios/utils/material_color_generator.dart';

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    primarySwatch: generateMaterialColor(
      const Color(0xffd81b60),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xffd81b60),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
      enabledBorder: OutlineInputBorder(),
      disabledBorder: OutlineInputBorder(),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.all(Colors.green),
      overlayColor:
          MaterialStateProperty.all(Colors.greenAccent.withOpacity(0.2)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );
}
