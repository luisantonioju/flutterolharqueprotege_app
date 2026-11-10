import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'models/video.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  // Lista estática simulando os dados que viriam da API (offline)
  late final List<Video> _listaVideos = [
    Video(
      id: 1,
      titulo: 'Vídeo 1 - Exemplo',
      descricao: 'Descrição do primeiro vídeo carregado do repositório GitHub.',
      arquivo: 'urEMwu5kZDEfYlNjFScZZa78vazf0Xk3U3JNBqvB.mp4',
    ),
    Video(
      id: 2,
      titulo: 'Vídeo 2 - Exemplo',
      descricao: 'Descrição do segundo vídeo com espaço no nome do arquivo.',
      arquivo: 'F8PCdITz4DZyiOxnpjSmiwkAWCImENfxwPm1fbTB (1).mp4',
    ),
    Video(
      id: 3,
      titulo: 'Vídeo 3 - Exemplo',
      descricao: 'Descrição do terceiro vídeo carregado do repositório GitHub.',
      arquivo: 'PFJ9OKMDGK7nS4jk8ZeOZH5DtXv8eTTkWewTH8XV.mp4',
    ),
  ];

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
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _listaVideos.length,
        itemBuilder: (context, index) {
          final video = _listaVideos[index];
          return VideoPlayerCard(video: video);
        },
      ),
    );
  }
}

// Widget isolado para gerenciar o Player de cada vídeo individualmente com eficiência
class VideoPlayerCard extends StatefulWidget {
  final Video video;
  const VideoPlayerCard({super.key, required this.video});

  @override
  State<VideoPlayerCard> createState() => _VideoPlayerCardState();
}

class _VideoPlayerCardState extends State<VideoPlayerCard> {
  late VideoPlayerController _controller;
  bool _estaCarregado = false;
  String? _mensagemErro;

  @override
  void initState() {
    super.initState();

    // Mapeamento explícito dos 3 links Raw do seu repositório GitHub para teste offline
    String urlParaTocar = '';

    if (widget.video.arquivo
        .contains('urEMwu5kZDEfYlNjFScZZa78vazf0Xk3U3JNBqvB')) {
      urlParaTocar =
          'https://raw.githubusercontent.com/luisantonioju/flutterolharqueprotege_app/main/assets/video/urEMwu5kZDEfYlNjFScZZa78vazf0Xk3U3JNBqvB.mp4';
    } else if (widget.video.arquivo
        .contains('PFJ9OKMDGK7nS4jk8ZeOZH5DtXv8eTTkWewTH8XV')) {
      urlParaTocar =
          'https://raw.githubusercontent.com/luisantonioju/flutterolharqueprotege_app/main/assets/video/PFJ9OKMDGK7nS4jk8ZeOZH5DtXv8eTTkWewTH8XV.mp4';
    } else if (widget.video.arquivo
        .contains('F8PCdITz4DZyiOxnpjSmiwkAWCImENfxwPm1fbTB')) {
      urlParaTocar =
          'https://raw.githubusercontent.com/luisantonioju/flutterolharqueprotege_app/main/assets/video/F8PCdITz4DZyiOxnpjSmiwkAWCImENfxwPm1fbTB%20(1).mp4';
    }

    _controller = VideoPlayerController.networkUrl(Uri.parse(urlParaTocar))
      ..initialize().then((_) {
        setState(() {
          _estaCarregado = true;
        });
      }).catchError((error) {
        setState(() {
          _mensagemErro = 'Erro ao carregar';
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _alternarPlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFCBD2D9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.black,
            child: _mensagemErro != null
                ? SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        _mensagemErro!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  )
                : _estaCarregado
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            VideoPlayer(_controller),
                            IconButton(
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_filled,
                                size: 64,
                                color: Colors.white.withOpacity(0.85),
                              ),
                              onPressed: _alternarPlayPause,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
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
