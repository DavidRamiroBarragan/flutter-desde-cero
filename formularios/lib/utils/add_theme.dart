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
      ));
}
