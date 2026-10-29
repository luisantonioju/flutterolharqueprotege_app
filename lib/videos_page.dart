import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'models/video.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  late Future<List<Video>> _listaVideos;

  // URL da API de vídeos ajustada para o emulador Android
  static const String apiUrl = 'http://10.0.2.2:8000/api/videos';

  @override
  void initState() {
    super.initState();
    _listaVideos = fetchVideos();
  }

  Future<List<Video>> fetchVideos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      List<dynamic> dados = [];

      // Tratamento para a estrutura paginada do Laravel
      if (decodedData is Map<String, dynamic>) {
        if (decodedData.containsKey('data') && decodedData['data'] is Map) {
          final innerData = decodedData['data'];
          if (innerData.containsKey('data') && innerData['data'] is List) {
            dados = innerData['data'];
          }
        } else if (decodedData.containsKey('data') &&
            decodedData['data'] is List) {
          dados = decodedData['data'];
        }
      } else if (decodedData is List) {
        dados = decodedData;
      }

      return dados.map((item) => Video.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao carregar vídeos: ${response.statusCode}');
    }
  }

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
      body: FutureBuilder<List<Video>>(
        future: _listaVideos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF1B2A4A)),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Erro ao carregar vídeos:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1B2A4A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }

          final videos = snapshot.data ?? [];

          if (videos.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum vídeo encontrado.',
                style: TextStyle(fontSize: 16, color: Color(0xFF1B2A4A)),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return VideoPlayerCard(video: video);
            },
          );
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

    // Mapeamento inteligente para usar os links diretos do GitHub raw baseados no nome do arquivo
    String urlParaTocar = widget.video.urlCompleta;

    if (widget.video.arquivo
        .contains('urEMwu5kZDEfYlNjFScZZa78vazf0Xk3U3JNBqvB')) {
      urlParaTocar =
          'https://raw.githubusercontent.com/alessandrojunior466-ops/oljar-protege/main/public/assets/video/urEMwu5kZDEfYlNjFScZZa78vazf0Xk3U3JNBqvB.mp4';
    } else if (widget.video.arquivo
        .contains('PFJ9OKMDGK7nS4jk8ZeOZH5DtXv8eTTkWewTH8XV')) {
      urlParaTocar =
          'https://raw.githubusercontent.com/alessandrojunior466-ops/oljar-protege/main/public/assets/video/PFJ9OKMDGK7nS4jk8ZeOZH5DtXv8eTTkWewTH8XV.mp4';
    } else if (widget.video.arquivo
        .contains('F8PCdITz4DZyiOxnpjSmiwkAWCImENfxwPm1fbTB')) {
      urlParaTocar =
          'https://raw.githubusercontent.com/alessandrojunior466-ops/oljar-protege/main/public/assets/video/F8PCdITz4DZyiOxnpjSmiwkAWCImENfxwPm1fbTB%20(1).mp4';
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
          // Área de Exibição do Vídeo com proporção correta
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
                            // Botão centralizado de play/pause translúcido
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
          // Área de texto totalmente separada abaixo do player
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
