import 'package:flutter/material.dart';

import '../screens/blog_screen.dart';
import '../screens/design_system_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/registro_screen.dart';
import '../screens/sobre_screen.dart';
import '../screens/videos_screen.dart';

class OqpNavItem {
  const OqpNavItem({required this.label, required this.route, required this.icon});

  final String label;
  final String route;
  final IconData icon;
}

abstract final class OqpRoutes {
  static const String home = '/';
  static const String sobre = '/sobre';
  static const String videos = '/videos';
  static const String blog = '/blog';
  static const String registro = '/registro';
  static const String login = '/login';
  static const String designSystem = '/design-system';

  static const List<OqpNavItem> navItems = [
    OqpNavItem(label: 'Home', route: home, icon: Icons.home_rounded),
    OqpNavItem(label: 'Sobre', route: sobre, icon: Icons.info_rounded),
    OqpNavItem(label: 'Vídeos', route: videos, icon: Icons.play_circle_rounded),
    OqpNavItem(label: 'Blog', route: blog, icon: Icons.article_rounded),
    OqpNavItem(label: 'Registro', route: registro, icon: Icons.person_add_alt_1_rounded),
    OqpNavItem(label: 'Login', route: login, icon: Icons.login_rounded),
  ];

  static Route<void> onGenerateRoute(RouteSettings settings) {
    final Widget page = switch (settings.name) {
      sobre => const SobreScreen(),
      videos => const VideosScreen(),
      blog => const BlogScreen(),
      registro => const RegistroScreen(),
      login => const LoginScreen(),
      designSystem => const DesignSystemScreen(),
      _ => const HomeScreen(),
    };

    return PageRouteBuilder<void>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
