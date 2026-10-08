import 'package:flutter/material.dart';

import '../tokens/oqp_colors.dart';
import '../tokens/oqp_layout.dart';
import '../tokens/oqp_typography.dart';

class OqpPageTitle extends StatelessWidget {
  const OqpPageTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: OqpSpacing.md, bottom: OqpSpacing.xl),
      child: Semantics(
        header: true,
        child: Text(text.toUpperCase(), textAlign: TextAlign.center, style: OqpTypography.display),
      ),
    );
  }
}

class OqpSloganHeader extends StatelessWidget {
  const OqpSloganHeader({super.key, this.text = 'MONITORAR = CUIDAR.'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.family_restroom_rounded, size: 34, color: OqpColors.lavenderMuted),
            const SizedBox(width: OqpSpacing.sm),
            Flexible(child: Text(text, style: OqpTypography.slogan)),
          ],
        ),
        const SizedBox(height: OqpSpacing.md),
        FractionallySizedBox(
          widthFactor: 0.75,
          child: Container(height: 3, color: OqpColors.lavenderMuted),
        ),
      ],
    );
  }
}

class OqpTag extends StatelessWidget {
  const OqpTag(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: OqpColors.cream,
        borderRadius: BorderRadius.circular(OqpRadii.pill),
      ),
      child: Text(label.toUpperCase(), style: OqpTypography.tag),
    );
  }
}

class OqpMeta extends StatelessWidget {
  const OqpMeta({super.key, required this.author, required this.date});

  final String author;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Text('Por $author · $date', style: OqpTypography.meta);
  }
}

class OqpSectionCard extends StatelessWidget {
  const OqpSectionCard({
    super.key,
    required this.child,
    this.color = OqpColors.lavender200,
    this.padding = const EdgeInsets.all(OqpSpacing.xl - 4),
  });

  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(OqpRadii.xl),
        boxShadow: OqpShadows.card,
      ),
      child: child,
    );
  }
}

/// Imagem com moldura branca arredondada (padrão das seções Home/Sobre).
class OqpFramedImage extends StatelessWidget {
  const OqpFramedImage({
    super.key,
    required this.image,
    this.aspectRatio = 3 / 2,
    this.circleInset = false,
    this.semanticLabel,
  });

  final String image;
  final double aspectRatio;
  final bool circleInset;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final picture = Image.asset(
      image,
      fit: BoxFit.cover,
      semanticLabel: semanticLabel,
      excludeFromSemantics: semanticLabel == null,
    );

    return Container(
      padding: const EdgeInsets.all(OqpSpacing.xs),
      decoration: BoxDecoration(
        color: OqpColors.white,
        borderRadius: BorderRadius.circular(OqpRadii.lg),
        boxShadow: OqpShadows.card,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(OqpRadii.md),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: circleInset
              ? ColoredBox(
                  color: OqpColors.lavender200,
                  child: Padding(
                    padding: const EdgeInsets.all(OqpSpacing.xs),
                    child: ClipOval(child: picture),
                  ),
                )
              : picture,
        ),
      ),
    );
  }
}

class OqpCalloutCard extends StatelessWidget {
  const OqpCalloutCard({super.key, required this.image, required this.text});

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OqpSectionCard(
      color: OqpColors.lavender300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OqpFramedImage(image: image),
          const SizedBox(height: OqpSpacing.xl),
          Text(text.toUpperCase(), style: OqpTypography.callout),
        ],
      ),
    );
  }
}
