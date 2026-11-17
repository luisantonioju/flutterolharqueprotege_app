import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'models/videos.dart';

// ==========================================
// 1. TELA DE LISTAGEM DE VÍDEOS (YoutubePage)
// ==========================================
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

                // Envolvemos o card com o GestureDetector para abrir a tela de detalhes ao clicar
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YoutubeDetalhePage(video: video),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: YoutubeVideoCard(
                      key: ValueKey(video.id),
                      video: video,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ==========================================
// 2. CARD DO VÍDEO (Usado na listagem)
// ==========================================
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

    if (RegExp(r'^[a-zA-Z0-9_-]{11}$').hasMatch(valor)) {
      return valor;
    }

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
      _controller?.close();
      _inicializarController();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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

// ==========================================
// 3. TELA DE DETALHES (Abre ao clicar no bloco)
// ==========================================
class YoutubeDetalhePage extends StatefulWidget {
  final Video video;

  const YoutubeDetalhePage({
    super.key,
    required this.video,
  });

  @override
  State<YoutubeDetalhePage> createState() => _YoutubeDetalhePageState();
}

class _YoutubeDetalhePageState extends State<YoutubeDetalhePage> {
  YoutubePlayerController? _controller;

  String _extrairId(String entrada) {
    final valor = entrada.trim();

    if (RegExp(r'^[a-zA-Z0-9_-]{11}$').hasMatch(valor)) {
      return valor;
    }

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
        autoPlay:
            true, // Inicia tocando automaticamente ao abrir a tela de detalhes
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
  void dispose() {
    _controller?.close();
    super.dispose();
  }

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
        title: const Text(
          'Vídeo',
          style: TextStyle(
            color: Color(0xFF1B2A4A),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.titulo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2A4A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.video.descricao,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5B6B79),
                      height: 1.5,
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
