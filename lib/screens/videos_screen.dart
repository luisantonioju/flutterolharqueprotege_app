import 'package:flutter/material.dart';

import '../app/oqp_routes.dart';
import '../data/oqp_content.dart';
import '../design_system/design_system.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = OqpData.videos;

    return OqpScaffold(
      currentRoute: OqpRoutes.videos,
      children: [
        const OqpPageTitle('Vídeos'),
        OqpContentCard(content: items.first, featured: true),
        for (final item in items.skip(1)) ...[
          const SizedBox(height: OqpSpacing.xl),
          OqpContentCard(content: item),
        ],
      ],
    );
  }
}
