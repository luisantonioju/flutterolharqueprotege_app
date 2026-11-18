import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'models/videoz.dart';

// ==========================================
// 1. TELA DE LISTAGEM DE CONTEÚDOS EXCLUSIVOS
// ==========================================
class ConteudosExclusivosPage extends StatelessWidget {
  const ConteudosExclusivosPage({super.key});

  // IDs ajustados entre aspas para corresponder ao tipo String do model
  static final List<Video> _conteudos = [
    const Video(
      id: '1',
      titulo: 'Conta de Adolescentes no Instagram',
      descricao:
          'Este conteúdo oficial da Meta fornece orientações sobre como configurar e gerenciar contas de adolescentes nas plataformas da empresa, visando garantir uma experiência segura e adequada à faixa etária.',
      arquivo: 'MHOtZNkhIlg',
    ),
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
      body: _conteudos.isEmpty
          ? const Center(
              child: Text(
                'Nenhum conteúdo disponível.',
                style: TextStyle(
                  color: Color(0xFF1B2A4A),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: _conteudos.length,
              itemBuilder: (context, index) {
                final video = _conteudos[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConteudoDetalhePage(video: video),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ConteudoVideoCard(
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
// 2. CARD DO VÍDEO (Com Player do YouTube)
// ==========================================
class ConteudoVideoCard extends StatefulWidget {
  final Video video;

  const ConteudoVideoCard({
    super.key,
    required this.video,
  });

  @override
  State<ConteudoVideoCard> createState() => _ConteudoVideoCardState();
}

class _ConteudoVideoCardState extends State<ConteudoVideoCard> {
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
  void didUpdateWidget(covariant ConteudoVideoCard oldWidget) {
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
    return Container(
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
        border: Border.all(
          color: const Color(0xFFCBD2D9),
        ),
      ),
      clipBehavior: Clip.antiAlias,
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.video.titulo,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2A4A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.video.descricao,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
  }
}

// ==========================================
// 3. TELA DE DETALHES DO CONTEÚDO EXCLUSIVO
// ==========================================
class ConteudoDetalhePage extends StatefulWidget {
  final Video video;

  const ConteudoDetalhePage({
    super.key,
    required this.video,
  });

  @override
  State<ConteudoDetalhePage> createState() => _ConteudoDetalhePageState();
}

class _ConteudoDetalhePageState extends State<ConteudoDetalhePage> {
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
        autoPlay: true,
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
          'Conteúdo Exclusivo',
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
