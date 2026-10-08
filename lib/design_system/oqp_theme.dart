import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tokens/oqp_colors.dart';
import 'tokens/oqp_layout.dart';
import 'tokens/oqp_typography.dart';

abstract final class OqpTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: OqpColors.indigo,
        primary: OqpColors.indigo,
        secondary: OqpColors.orange,
        surface: OqpColors.lavender50,
      ),
    );

    final fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(OqpRadii.sm),
      borderSide: const BorderSide(color: OqpColors.gray300),
    );

    return base.copyWith(
      scaffoldBackgroundColor: OqpColors.lavender100,
      textTheme: GoogleFonts.montserratTextTheme(base.textTheme).apply(
        bodyColor: OqpColors.textBody,
        displayColor: OqpColors.indigo,
      ),
      iconTheme: const IconThemeData(color: OqpColors.indigo),
      dividerTheme: const DividerThemeData(color: OqpColors.lavender200, thickness: 1),
      drawerTheme: const DrawerThemeData(backgroundColor: OqpColors.cream),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: OqpColors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: OqpSpacing.md, vertical: 14),
        border: fieldBorder,
        enabledBorder: fieldBorder,
        focusedBorder: fieldBorder.copyWith(
          borderSide: const BorderSide(color: OqpColors.indigo, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: OqpColors.ink,
          foregroundColor: OqpColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OqpRadii.sm)),
          textStyle: OqpTypography.button,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: OqpColors.gray500,
          textStyle: OqpTypography.body,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        side: const BorderSide(color: OqpColors.gray500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? OqpColors.ink : OqpColors.white,
        ),
      ),
    );
  }
}
