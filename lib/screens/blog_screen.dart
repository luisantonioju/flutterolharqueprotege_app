import 'package:flutter/material.dart';

import '../app/oqp_routes.dart';
import '../data/oqp_content.dart';
import '../design_system/design_system.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = OqpData.posts;

    return OqpScaffold(
      currentRoute: OqpRoutes.blog,
      children: [
        const OqpPageTitle('Blog'),
        OqpContentCard(content: items.first, featured: true),
        for (final item in items.skip(1)) ...[
          const SizedBox(height: OqpSpacing.xl),
          OqpContentCard(content: item),
        ],
      ],
    );
  }
}
