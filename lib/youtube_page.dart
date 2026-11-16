import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoItem {
  final int id;
  final String titulo;
  final String descricao;
  final String url;

  VideoItem({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.url,
  });
}

class YouTubePage extends StatelessWidget {
  const YouTubePage({super.key});

  List<VideoItem> get _listaVideos => [
        VideoItem(
          id: 1,
          titulo:
              'ECA Digital: Novas regras para proteger menores na internet entram em vigor | CNN PRIME TIME',
          descricao:
              'O ECA Digital, que estabelece novas regras para proteger crianças e adolescentes na internet, entrou em vigor nesta terça-feira (17). A lei é uma atualização do Estatuto da Criança e do Adolescente voltada para as plataformas digitais. #CNNBrasil',
          url: 'https://www.youtube.com/watch?v=jMHypDuvGlc',
        ),
        VideoItem(
          id: 2,
          titulo:
              'ECA Digital: Lei que protege crianças na internet entra em vigor hoje; especialista comenta',
          descricao:
              'A nova legislação impõe regras rígidas para plataformas e redes sociais, proibindo a autodeclaração de idade e exigindo mecanismos de verificação mais seguros.',
          url: 'https://www.youtube.com/watch?v=8vlPYxH0pFU',
        ),
        VideoItem(
          id: 3,
          titulo: 'Órgãos governamentais se mobilizam.',
          descricao: 'Veja o vídeo da Prefeitura de Aracaju.',
          url: 'https://www.youtube.com/watch?v=zxzb5wcMzsE',
        ),
        VideoItem(
          id: 4,
          titulo: 'Família ensina o Google Family Link.',
          descricao:
              'Aprenda como fazer a ativação no smartphone de seu filho.',
          url: 'https://www.youtube.com/watch?v=laExLC8PfS0',
        ),
      ];

  Future<void> _abrirLink(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o vídeo.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube - Olhar Que Protege'),
        backgroundColor: const Color(0xFFFD5900),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _listaVideos.length,
        itemBuilder: (context, index) {
          final video = _listaVideos[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.red,
                child: Icon(Icons.play_arrow, color: Colors.white, size: 28),
              ),
              title: Text(
                video.titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  video.descricao,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              trailing: const Icon(Icons.open_in_new, color: Colors.grey),
              onTap: () => _abrirLink(context, video.url),
            ),
          );
        },
      ),
    );
  }
}
