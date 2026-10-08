import 'package:flutter/material.dart';

import '../app/oqp_routes.dart';
import '../data/oqp_content.dart';
import '../design_system/design_system.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OqpScaffold(
      currentRoute: OqpRoutes.home,
      children: [
        const OqpSloganHeader(),
        const SizedBox(height: OqpSpacing.xl),
        const OqpCarousel(slides: OqpData.slides),
        const SizedBox(height: OqpSpacing.xl),
        Text(
          OqpData.homeIntro,
          textAlign: TextAlign.center,
          style: OqpTypography.bodySmall.copyWith(color: OqpColors.textSoft),
        ),
        const SizedBox(height: OqpSpacing.xl),
        const OqpSectionCard(child: OqpBubbleCluster()),
        const SizedBox(height: OqpSpacing.xl),
        const OqpCalloutCard(
          image: OqpImages.girlsBedLaptop,
          text: 'Cuidar e amar, pode salvar e poupar.',
        ),
      ],
    );
  }
}
