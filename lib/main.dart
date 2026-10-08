import 'package:flutter/material.dart';

import 'app/oqp_routes.dart';
import 'design_system/oqp_theme.dart';

void main() => runApp(const OlharQueProtegeApp());

class OlharQueProtegeApp extends StatelessWidget {
  const OlharQueProtegeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olhar Que Protege',
      debugShowCheckedModeBanner: false,
      theme: OqpTheme.light,
      initialRoute: OqpRoutes.home,
      onGenerateRoute: OqpRoutes.onGenerateRoute,
    );
  }
}
