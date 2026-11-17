import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'models/videos.dart';

class YoutubePage extends StatelessWidget {
  const YoutubePage({super.key});

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
          height: 100,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
      ),
      body: listaVideos.isEmpty
          ? const Center(
              child: Text(
                'Nenhum vídeo disponível.',
                style: TextStyle(
                  color: Color(0xFF1B2A4A),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: listaVideos.length,
              itemBuilder: (context, index) {
                final video = listaVideos[index];

                return YoutubeVideoCard(
                  key: ValueKey(video.id),
                  video: video,
                );
              },
            ),
    );
  }
}

// PLAYER INCORPORADO DO YOUTUBE

class YoutubeVideoCard extends StatefulWidget {
  final Video video;

  const YoutubeVideoCard({
    super.key,
    required this.video,
  });

  @override
  State<YoutubeVideoCard> createState() => _YoutubeVideoCardState();
}

class _YoutubeVideoCardState extends State<YoutubeVideoCard> {
  YoutubePlayerController? _controller;

  String _extrairId(String entrada) {
    final valor = entrada.trim();

    // Caso seja informado somente o ID do vídeo.
    if (RegExp(r'^[a-zA-Z0-9_-]{11}$').hasMatch(valor)) {
      return valor;
    }

    // Links youtube.com/watch, youtu.be, embed e Shorts.
    final padrao = RegExp(
      r'(?:youtube\.com/watch\?.*?[&?]v=|youtu\.be/|youtube\.com/embed/|youtube\.com/shorts/)([a-zA-Z0-9_-]{11})',
    );

    final resultado = padrao.firstMatch(valor);

    return resultado?.group(1) ?? '';
  }

  void _inicializarController() {
    final videoId = _extrairId(widget.video.arquivo);

    if (videoId.isNotEmpty) {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: false,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _inicializarController();
  }

  @override
  void didUpdateWidget(covariant YoutubeVideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.video.arquivo != widget.video.arquivo) {
      _controller?.close(); // Correção para fechar o controller nesta versão
      _inicializarController();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.close(); // Correção para fechar o controller nesta versão
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      color: Colors.white,
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFFCBD2D9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PLAYER DE VÍDEO INCORPORADO
          if (_controller != null)
            YoutubePlayer(
              controller: _controller!,
              aspectRatio: 16 / 9,
            )
          else
            const AspectRatio(
              aspectRatio: 16 / 9,
              child: Center(
                child: Text('Vídeo indisponível'),
              ),
            ),

          // INFORMAÇÕES DO VÍDEO
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.video.titulo,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2A4A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.video.descricao,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF5B6B79),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
