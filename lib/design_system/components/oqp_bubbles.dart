import 'package:flutter/material.dart';

import '../../data/oqp_content.dart';
import '../tokens/oqp_colors.dart';
import '../tokens/oqp_layout.dart';
import '../tokens/oqp_typography.dart';

class OqpWordBubble extends StatelessWidget {
  const OqpWordBubble({
    super.key,
    required this.word,
    required this.size,
    required this.background,
    required this.foreground,
  });

  final String word;
  final double size;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        boxShadow: OqpShadows.soft,
      ),
      padding: EdgeInsets.all(size * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              word.toUpperCase(),
              style: OqpTypography.bubble.copyWith(fontSize: size * 0.22, color: foreground),
            ),
          ),
          SizedBox(height: size * 0.03),
          Container(
            width: size * 0.32,
            height: 2.5,
            decoration: BoxDecoration(
              color: OqpColors.white,
              borderRadius: BorderRadius.circular(OqpRadii.pill),
            ),
          ),
        ],
      ),
    );
  }
}

class OqpImageBubble extends StatelessWidget {
  const OqpImageBubble({super.key, required this.image, required this.size});

  final String image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: OqpShadows.card),
      child: ClipOval(child: Image.asset(image, fit: BoxFit.cover, excludeFromSemantics: true)),
    );
  }
}

/// Composição "Cuidar · Amar · Evite · Zelar" adaptada para largura mobile.
class OqpBubbleCluster extends StatelessWidget {
  const OqpBubbleCluster({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        return Semantics(
          label: 'Cuidar, amar, evitar e zelar',
          child: SizedBox(
            height: w * 1.42,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: OqpImageBubble(image: OqpImages.girlLaptopBlue, size: w * 0.56),
                ),
                Positioned(
                  right: 0,
                  top: w * 0.1,
                  child: OqpWordBubble(
                    word: 'Cuidar',
                    size: w * 0.44,
                    background: OqpColors.lavender100,
                    foreground: OqpColors.plumDeep,
                  ),
                ),
                Positioned(
                  left: w * 0.28,
                  top: w * 0.42,
                  child: OqpWordBubble(
                    word: 'Amar',
                    size: w * 0.42,
                    background: OqpColors.cream,
                    foreground: OqpColors.plum,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: w * 0.66,
                  child: OqpWordBubble(
                    word: 'Evite',
                    size: w * 0.4,
                    background: OqpColors.lavender300,
                    foreground: OqpColors.cream,
                  ),
                ),
                Positioned(
                  left: w * 0.44,
                  top: w * 1.02,
                  child: OqpWordBubble(
                    word: 'Zelar',
                    size: w * 0.38,
                    background: OqpColors.periwinkle,
                    foreground: OqpColors.cream,
                  ),
                ),
                Positioned(
                  left: w * 0.04,
                  top: w * 0.86,
                  child: OqpImageBubble(image: OqpImages.cyberbullying, size: w * 0.44),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
