import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../tokens/oqp_colors.dart';
import '../tokens/oqp_layout.dart';

/// Versão mobile do mapa mental "Olhar Que Protege" da página Sobre.
class OqpMindMap extends StatelessWidget {
  const OqpMindMap({super.key});

  static const List<(String, String)> _notes = [
    (
      'Objetivo',
      'Conscientizar crianças e adultos inexperientes no assunto, mostrando que esses abusos afetam negativamente a vida das crianças.',
    ),
    (
      'Proposta / Tecnologia',
      'Criar uma plataforma de galeria de vídeos curtos, de fácil entendimento. HTML, CSS, JavaScript.',
    ),
    (
      'ODS 5.2',
      'Eliminar todas as formas de violência contra todas as mulheres e meninas nas esferas públicas e privadas, incluindo o tráfico e exploração sexual e de outros tipos.',
    ),
    ('Funcionalidade', 'Uma plataforma educacional e informativa, de fácil entendimento.'),
    ('Usuários', 'Pais, responsáveis e para crianças.'),
    (
      'Interface',
      'Quando entrar no site, vai se deparar com a logo, opções sobre e vídeos. Ao clicar em cada opção, você encontra uma abordagem educacional e acolhedora.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: OqpColors.white,
        borderRadius: BorderRadius.circular(OqpRadii.lg),
        boxShadow: OqpShadows.card,
      ),
      child: Container(
        padding: const EdgeInsets.all(OqpSpacing.lg),
        decoration: BoxDecoration(
          color: OqpColors.slate,
          borderRadius: BorderRadius.circular(OqpRadii.md),
        ),
        child: Column(
          children: [
            Text(
              'OLHAR QUE\nPROTEGE',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                height: 1,
                color: OqpColors.orange,
                shadows: const [Shadow(color: OqpColors.navy, offset: Offset(2, 2))],
              ),
            ),
            const SizedBox(height: OqpSpacing.md),
            const Icon(Icons.south_rounded, color: OqpColors.ink),
            const SizedBox(height: OqpSpacing.md),
            for (final (title, body) in _notes) ...[
              _Note(title: title, body: body),
              const SizedBox(height: OqpSpacing.lg),
            ],
          ],
        ),
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(OqpSpacing.md),
      decoration: BoxDecoration(
        color: OqpColors.paper,
        border: Border.all(color: OqpColors.ink),
        boxShadow: OqpShadows.note,
      ),
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w700, color: OqpColors.ink),
          ),
          const Divider(color: OqpColors.ink, height: OqpSpacing.lg, thickness: 1),
          Text(
            body,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: 12, height: 1.4, color: OqpColors.ink),
          ),
        ],
      ),
    );
  }
}
