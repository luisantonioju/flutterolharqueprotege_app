import 'package:flutter/material.dart';

import '../app/oqp_routes.dart';
import '../data/oqp_content.dart';
import '../design_system/design_system.dart';

class DesignSystemScreen extends StatelessWidget {
  const DesignSystemScreen({super.key});

  static const List<(String, Color, String)> _palette = [
    ('Orange', OqpColors.orange, '#F26B2C'),
    ('Navy', OqpColors.navy, '#1B2A4A'),
    ('Indigo', OqpColors.indigo, '#22186B'),
    ('Plum', OqpColors.plum, '#4A1A6B'),
    ('Cream', OqpColors.cream, '#FFF3E3'),
    ('Ink', OqpColors.ink, '#111827'),
    ('Lavender 50', OqpColors.lavender50, '#CBCFF5'),
    ('Lavender 100', OqpColors.lavender100, '#BEC5EE'),
    ('Lavender 200', OqpColors.lavender200, '#A3AADB'),
    ('Lavender 300', OqpColors.lavender300, '#8A8BC4'),
    ('Periwinkle', OqpColors.periwinkle, '#7B86E0'),
    ('Gray 50', OqpColors.gray50, '#F3F4F6'),
  ];

  @override
  Widget build(BuildContext context) {
    final typeScale = <(String, TextStyle)>[
      ('Display', OqpTypography.display),
      ('H1', OqpTypography.h1),
      ('H2', OqpTypography.h2),
      ('H3', OqpTypography.h3),
      ('Body', OqpTypography.body),
      ('Meta', OqpTypography.meta),
      ('Slogan', OqpTypography.slogan),
    ];

    return OqpScaffold(
      currentRoute: OqpRoutes.designSystem,
      children: [
        const OqpPageTitle('Design System'),
        const _SectionLabel('Cores'),
        Wrap(
          spacing: OqpSpacing.md,
          runSpacing: OqpSpacing.md,
          children: [for (final (name, color, hex) in _palette) _Swatch(name: name, color: color, hex: hex)],
        ),
        const _SectionLabel('Tipografia'),
        for (final (name, style) in typeScale)
          Padding(
            padding: const EdgeInsets.only(bottom: OqpSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name.toUpperCase(), style: OqpTypography.tag),
                Text('Olhar Que Protege', style: style),
              ],
            ),
          ),
        const _SectionLabel('Botões e tags'),
        Wrap(
          spacing: OqpSpacing.md,
          runSpacing: OqpSpacing.md,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            OqpButton(label: 'Log in', onPressed: () {}),
            OqpButton(label: 'Assistir', icon: Icons.play_arrow_rounded, variant: OqpButtonVariant.secondary, onPressed: () {}),
            OqpButton(label: 'Saiba mais', variant: OqpButtonVariant.outline, onPressed: () {}),
            const OqpTag('Destaque'),
            const OqpTag('Vídeo'),
            const OqpTag('Leitura'),
          ],
        ),
        const _SectionLabel('Formulário'),
        const OqpTextField(label: 'Email', keyboardType: TextInputType.emailAddress),
        const _SectionLabel('Bolhas'),
        const Wrap(
          spacing: OqpSpacing.md,
          runSpacing: OqpSpacing.md,
          children: [
            OqpWordBubble(word: 'Cuidar', size: 96, background: OqpColors.lavender50, foreground: OqpColors.plumDeep),
            OqpWordBubble(word: 'Amar', size: 96, background: OqpColors.cream, foreground: OqpColors.plum),
            OqpWordBubble(word: 'Evite', size: 96, background: OqpColors.lavender300, foreground: OqpColors.cream),
            OqpWordBubble(word: 'Zelar', size: 96, background: OqpColors.periwinkle, foreground: OqpColors.cream),
          ],
        ),
        const _SectionLabel('Card de conteúdo'),
        OqpContentCard(content: OqpData.videos[1]),
        const SizedBox(height: OqpSpacing.lg),
        OqpContentCard(content: OqpData.posts[1]),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: OqpSpacing.xl, bottom: OqpSpacing.md),
      child: Text(text, style: OqpTypography.h3),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.name, required this.color, required this.hex});

  final String name;
  final Color color;
  final String hex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(OqpRadii.md),
              border: Border.all(color: OqpColors.white, width: 2),
            ),
          ),
          const SizedBox(height: OqpSpacing.xs),
          Text(name, style: OqpTypography.meta.copyWith(color: OqpColors.ink, fontWeight: FontWeight.w600)),
          Text(hex, style: OqpTypography.meta),
        ],
      ),
    );
  }
}
