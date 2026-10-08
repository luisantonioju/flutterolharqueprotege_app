import 'package:flutter/material.dart';

import '../app/oqp_routes.dart';
import '../data/oqp_content.dart';
import '../design_system/design_system.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  static const List<String> _monitoramento = [
    'A internet representa hoje uma dimensão essencial da vida, oferecendo um portal vasto de conhecimento e conexão. Contudo, para crianças e adolescentes, essa ferramenta poderosa está intrinsecamente ligada a uma série de riscos e vulnerabilidades que exigem uma atuação protetora e ativa dos pais. Monitorar o uso da internet por suas filhas — sejam elas crianças curiosas, pré-adolescentes exploradoras ou adolescentes em busca de identidade — não deve ser visto como uma invasão, mas sim como uma medida fundamental de segurança, carinho e orientação no complexo ambiente digital.',
    'O principal motivo para a vigilância é a proteção contra predadores e assédio online. Indivíduos mal-intencionados frequentemente se disfarçam em plataformas populares, como jogos e redes sociais, visando a aproximação e o aliciamento. O acompanhamento regular e discreto permite identificar e bloquear rapidamente contatos ou comportamentos inadequados. Além disso, o monitoramento é vital na prevenção e intervenção contra o cyberbullying.',
    'Outra preocupação central é a exposição a conteúdo inapropriado. Igualmente crucial é a necessidade de gerenciar a saúde mental e o tempo de tela. A constante comparação com padrões irreais nas redes sociais pode levar a distúrbios de autoimagem, ansiedade e depressão.',
    'A maneira mais eficaz de monitorar, no entanto, é através de uma combinação de tecnologia e diálogo aberto. O objetivo final não é a fiscalização punitiva, mas sim educar e capacitar suas filhas para que desenvolvam uma relação segura, equilibrada e responsável com a vasta e poderosa ferramenta que é a internet.',
  ];

  static const List<String> _conhecimento = [
    'Em um mundo de constante evolução, as ameaças à segurança de nossas meninas também mudam. É por isso que criamos o "Olhar Que Protege": uma plataforma de vídeos projetada para ser o seu guia definitivo na missão de monitorar e proteger sua filha menor de idade.',
    'Nós oferecemos mais do que meras dicas; entregamos um treinamento prático e acessível que capacita pais e mães a entenderem e agirem sobre os riscos contemporâneos.',
    'O "Olhar Que Protege" é a ponte entre o seu amor incondicional e a ação protetiva eficaz. Não se trata de invadir a privacidade, mas de construir uma rede de segurança sólida baseada na observação informada e no diálogo aberto.',
  ];

  static const List<String> _origem = [
    'Temos o prazer de apresentar o "Olhar Que Protege", um projeto desenvolvido com paixão e expertise por nossa equipe de alunos do curso técnico em Tecnologia da Informação: Alessandro, Ana, Felipe e Alexandre. Nossa iniciativa está alinhada diretamente à Agenda 2030 da ONU e é a nossa resposta tecnológica à meta 5.2 dos Objetivos de Desenvolvimento Sustentável (ODS).',
    'Em um mundo onde a violência e o risco se manifestam cada vez mais no ambiente digital, sentimos a urgência de criar uma ferramenta de empoderamento para os pais, transformando o conhecimento técnico em informações acessíveis.',
    'O projeto é a prova de que a Tecnologia da Informação não é apenas sobre códigos e sistemas, mas sobre soluções que salvam, protegem e transformam vidas.',
  ];

  @override
  Widget build(BuildContext context) {
    final onSection = OqpTypography.bodySmall.copyWith(color: OqpColors.white);

    return OqpScaffold(
      currentRoute: OqpRoutes.sobre,
      children: [
        OqpSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Monitoramento Digital: Proteção Essencial para Suas Filhas',
                style: OqpTypography.h2.copyWith(color: OqpColors.white),
              ),
              const SizedBox(height: OqpSpacing.lg),
              const OqpFramedImage(image: OqpImages.girlYellow),
              const SizedBox(height: OqpSpacing.lg),
              for (final p in _monitoramento) ...[
                Text(p, style: onSection),
                const SizedBox(height: OqpSpacing.md),
              ],
            ],
          ),
        ),
        const SizedBox(height: OqpSpacing.xl),
        OqpSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olhar Que Protege: O Conhecimento que Transforma Preocupação em Segurança Real.',
                style: OqpTypography.h2.copyWith(color: OqpColors.white),
              ),
              const SizedBox(height: OqpSpacing.sm),
              Text(
                'A sua filha merece crescer protegida, e você merece a tranquilidade de saber como defendê-la.',
                style: OqpTypography.body.copyWith(
                  color: OqpColors.cream,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: OqpSpacing.lg),
              const OqpFramedImage(image: OqpImages.family, aspectRatio: 1, circleInset: true),
              const SizedBox(height: OqpSpacing.lg),
              for (final p in _conhecimento) ...[
                Text(p, style: onSection),
                const SizedBox(height: OqpSpacing.md),
              ],
            ],
          ),
        ),
        const SizedBox(height: OqpSpacing.xxl),
        Text(
          'Como surgiu o "Olhar Que Protege"',
          textAlign: TextAlign.center,
          style: OqpTypography.h2.copyWith(color: OqpColors.textHeading),
        ),
        const SizedBox(height: OqpSpacing.lg),
        for (final p in _origem) ...[
          Text(
            p,
            textAlign: TextAlign.justify,
            style: OqpTypography.bodySmall.copyWith(color: OqpColors.textSoft),
          ),
          const SizedBox(height: OqpSpacing.md),
        ],
        const SizedBox(height: OqpSpacing.lg),
        const OqpMindMap(),
      ],
    );
  }
}
