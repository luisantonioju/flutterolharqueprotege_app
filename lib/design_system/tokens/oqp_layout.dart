import 'package:flutter/material.dart';

import 'oqp_colors.dart';

abstract final class OqpSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  static const double screenGutter = lg;
}

abstract final class OqpRadii {
  static const double sm = 4;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double pill = 999;
}

abstract final class OqpShadows {
  static const List<BoxShadow> card = [
    BoxShadow(color: OqpColors.shadow, blurRadius: 18, offset: Offset(0, 8)),
  ];

  static const List<BoxShadow> soft = [
    BoxShadow(color: OqpColors.shadow, blurRadius: 10, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> note = [
    BoxShadow(color: OqpColors.ink, offset: Offset(4, 4)),
  ];
}
