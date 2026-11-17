import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConteudosExclusivosPage extends StatelessWidget {
  const ConteudosExclusivosPage({super.key});

  // Lista de conteúdos exclusivos
  static const List<Map<String, String>> _conteudos = [
    {
      'canal': 'CNN Brasil',
      'titulo':
          'ECA Digital: Novas regras para proteger menores na internet entram em vigor | CNN PRIME TIME',
      'descricao':
          'O ECA Digital estabelece novas regras para proteger crianças e adolescentes na internet. A legislação atualiza...',
      'imagem': 'assets/img/girls-bed-laptop.png',
    },
    {
      'canal': 'Jovem Pan News',
      'titulo':
          '"ECA Digital": Lei que protege crianças e adolescentes nas redes sociais',
      'descricao':
          'Entenda como funcionam as diretrizes de segurança digital e monitoramento parental exigidas pelas novas leis.',
      'imagem': 'assets/img/ruiva.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5CEEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F4EE),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF1B2A4A),
        ),
        title: SvgPicture.asset(
          'assets/img/olhar_que_protege_transparente.svg',
          height: 90,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _conteudos.length,
        itemBuilder: (context, index) {
          final item = _conteudos[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CARD DO VÍDEO
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset(
                        item['imagem']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF1B2A4A),
                            child: const Center(
                              child: Icon(
                                Icons.video_library,
                                size: 50,
                                color: Colors.white70,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Camada escura
                    Container(
                      height: 200,
                      color: Colors.black.withOpacity(0.3),
                    ),

                    // Botão Play
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF0000),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),

                    // Título sobre o vídeo
                    Positioned(
                      top: 10,
                      left: 12,
                      right: 12,
                      child: Text(
                        item['titulo']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                // RODAPÉ DO CARD
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['titulo']!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B2A4A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['descricao']!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
