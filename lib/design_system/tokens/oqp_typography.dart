import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'oqp_colors.dart';

/// Montserrat é a fonte principal; Roboto aparece no slogan, carrossel e botões.
abstract final class OqpTypography {
  static TextStyle get display => GoogleFonts.montserrat(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        letterSpacing: 3,
        height: 1.1,
        color: OqpColors.indigo,
      );

  static TextStyle get h1 => GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: OqpColors.indigo,
      );

  static TextStyle get h2 => GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: OqpColors.indigo,
      );

  static TextStyle get h3 => GoogleFonts.montserrat(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: OqpColors.indigo,
      );

  static TextStyle get bodyLarge => GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.55,
        color: OqpColors.textBody,
      );

  static TextStyle get body => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.55,
        color: OqpColors.textBody,
      );

  static TextStyle get bodySmall => GoogleFonts.montserrat(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: OqpColors.textBody,
      );

  static TextStyle get label => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: OqpColors.ink,
      );

  static TextStyle get meta => GoogleFonts.montserrat(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: OqpColors.textMeta,
      );

  static TextStyle get tag => GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
        color: OqpColors.indigo,
      );

  static TextStyle get nav => GoogleFonts.montserrat(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: OqpColors.ink,
      );

  static TextStyle get logo => GoogleFonts.montserrat(
        fontWeight: FontWeight.w800,
        height: 1,
        color: OqpColors.navy,
      );

  static TextStyle get button => GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.6,
      );

  static TextStyle get slogan => GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: OqpColors.lavenderMuted,
      );

  static TextStyle get slideTitle => GoogleFonts.roboto(
        fontSize: 30,
        fontWeight: FontWeight.w900,
        height: 1,
        color: OqpColors.white,
      );

  static TextStyle get bubble => GoogleFonts.montserrat(
        fontWeight: FontWeight.w900,
        height: 1,
      );

  static TextStyle get callout => GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        height: 1.3,
        color: OqpColors.white,
      );
}
