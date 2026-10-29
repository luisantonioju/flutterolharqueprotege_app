import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5CEEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F4EE),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1B2A4A)),
        title: SvgPicture.asset(
          'assets/img/olhar_que_protege_transparente.svg',
          height: 100,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SEÇÃO 1: Monitoramento Digital
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF8E9BCE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Monitoramento Digital: Proteção Essencial para Suas Filhas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'A Internet representa hoje uma dimensão essencial da vida, oferecendo um portal vasto de conhecimento, conexão, conteúdo, para crianças e adolescentes. Esse fenômeno poderoso está intrinsecamente ligado a uma série de riscos e vulnerabilidades que exigem uma atuação protetiva e ativa dos pais. Monitorar o uso da Internet por suas filhas — sejam elas crianças, crianças, pré-adolescentes ou adolescentes —, em busca de aproximação — não deve ser visto como uma invasão, mas sim como uma medida fundamental de segurança, controle e orientação no complexo universo digital.\n\n'
                    'O principal motivo para a vigilância é a proteção contra predadores e abusadores online. Indivíduos mal-intencionados frequentemente se disfarçam em plataformas populares, como jogos e redes sociais, visando a aproximação e o aliciamento. O acompanhamento regular e atento permite identificar e bloquear rapidamente contatos ou comportamentos inadequados. Além disso, o monitoramento é vital na prevenção e intervenção contra o cyberbullying, garantindo que suas filhas não sejam vítimas de agressões virtuais que podem causar danos psicológicos profundos e duradouros, no mesmo andamento destas atos, necessitando de correção imediata.\n\n'
                    'Outra preocupação central é a exposição a conteúdos inapropriados. Apesar dos filtros e restrições, o acesso acidental ou intencional a material violento, explícito ou que promova extremismo é um risco constante. A supervisão atenta permite garantir que o consumo digital esteja alinhado com a maturidade da criança ou adolescente, igualmente crucial é a necessidade de gerenciar a saúde mental e o tempo de tela. A constante comparação com padrões irreais nas redes sociais pode levar a distúrbios de autoimagem, ansiedade e depressão. Além disso, o uso descontrolado pode resultar em vício em telas, prejudicando o desempenho acadêmico, o sono e as interações sociais presenciais. Por fim, a navegação sem supervisão expõe a família a riscos de fraudes e vazamento de dados, já que menores nem sempre compreendem os perigos de compartilhar informações pessoais ou clicar em links maliciosos.\n\n'
                    'A maneira mais eficaz de monitorar, no entanto, é através de uma construção de tecnologia e diálogo abertos. O estabelecimento de regras claras sobre tempo de uso e sites permitidos, o uso de ferramentas de controle parental e o simples ato de manter os dispositivos em áreas comuns da casa são passos construtivos. O objetivo final não é a fiscalização punitiva, mas sim educar e capacitar suas filhas para que desenvolvam uma relação segura, equilibrada e responsável com a vasta e poderosa ferramenta que é a internet.',
                    style: TextStyle(
                        fontSize: 13, color: Colors.white, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/img/tiazinha.jpg',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const ContainerPlaceholder(height: 180),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // SEÇÃO 2: O Conhecimento que Transforma Preocupação
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF8E9BCE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Olhar Que Protege: O Conhecimento que Transforma Preocupação em Segurança Real.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A sua filha merece crescer protegida, e você merece a tranquilidade de saber como defendê-la.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFF3DB),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Em um mundo de constante evolução, as ameaças à segurança de nossas meninas também mudam. A incidência da infância é colocada à prova diariamente, muitas vezes em ambientes que nem conseguimos enxergar — especialmente no vasto universo digital. É por isso que criamos o "Olhar Que Protege", uma plataforma de vídeos projetada para ser o seu guia definitivo na missão de monitorar e proteger sua filha menor de idade.\n\n'
                    'Nossa diferença mais do que menor de idade entregamos um treinamento prático e acessível que capacita pais e mães a entenderem e agirem sobre os riscos contemporâneos. Você aprenderá a navegar pelas redes sociais e aplicativos com o conhecimento de um especialista, identificando sinais sutis de cyberbullying, assédio ou envolvimento com conteúdos perigosos. Além disso, ensinaremos você, além da tela, reconhecendo alterações comportamentais cruciais que indicam a necessidade de uma conversa e intervenção.\n\n'
                    'O "Olhar Que Protege" aponta armas o seu amor incondicional e a ação protetiva eficaz. Não se trata de invadir a privacidade, mas de construir uma rede de segurança ativa baseada na observação informada e no diálogo aberto. Proporcione a si mesmo a paz de espírito que vem de estar ativamente preparado.',
                    style: TextStyle(
                        fontSize: 13, color: Colors.white, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/img/familycircle.png',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const ContainerPlaceholder(height: 180),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // SEÇÃO 3: Como surgiu o "Olhar Que Protege"
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF8E9BCE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Como surgiu o "Olhar Que Protege"',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Temos o prazer de apresentar o "Olhar Que Protege", um projeto desenvolvido com paixão e expertise por nossa equipe de alunos do curso técnico em Tecnologia da Informação: Alessandro, Ana, Felipe e Alexandre. Nossa iniciativa nasceu, não apenas de um desafio acadêmico, mas de um profundo compromisso com a sociedade, alinhado diretamente a Agenda 2030 da Organização das Nações Unidas, O "Olhar Que Protege" é a nossa resposta tecnológica à meta 5.2 dos Objetivos de Desenvolvimento Sustentável (ODS), que visa eliminar todas as formas de violência contra os mulheres e meninas.\n\n'
                    'Em um mundo onde a violência e o risco, especialmente o abuso e a exploração, se manifestam cada vez mais no ambiente digital, sentimos a urgência de criar uma ferramenta de empoderamento para os pais. O "Olhar Que Protege" é uma plataforma de vídeos educativos que transforma o conhecimento técnico em informações acessíveis, capacitando os responsáveis a monitorar proativamente o uso que suas filhas menores de idade fazem da internet e das redes sociais. Nosso conteúdo ensina a identificar e prevenir situações de risco online, como cyberbullying e contato com predadores, e, crucialmente, a fortalecer o diálogo em casa, promovendo um ambiente seguro e de confiança.\n\n'
                    'O projeto é a prova de que a Tecnologia da Informação não é apenas sobre códigos e sistemas, mas sobre soluções que salvem, protegem e transformam vidas. Por meio de uma interface simples e conteúdo didático, estamos utilizando nossas habilidades em TI para construir um futuro onde as meninas possam crescer livres do medo e da violência, online e offline. Esta é a nossa contribuição, utilizando a TI como ferramenta para alcançar a ODS 5.2, garantindo um "Olhar Que Protege" a geração do amanhã.',
                    style: TextStyle(
                        fontSize: 13, color: Colors.white, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/img/Capturar.PNG',
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const ContainerPlaceholder(height: 250),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerPlaceholder extends StatelessWidget {
  final double height;
  const ContainerPlaceholder({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.image, size: 50, color: Colors.grey),
      ),
    );
  }
}
