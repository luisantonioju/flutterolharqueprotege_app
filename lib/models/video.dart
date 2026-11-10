class Video {
  final int id;
  final String titulo;
  final String descricao;
  final String arquivo;

  Video({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.arquivo,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      titulo: json['titulo']?.toString() ?? '',
      descricao: json['descricao']?.toString() ?? '',
      arquivo: json['arquivo']?.toString() ?? '',
    );
  }

  // URL gerada 100% baseada no seu repositório Raw do GitHub
  String get urlCompleta {
    // Pega apenas o nome do arquivo (ex: urEMwu5kZDEfYlNjFScZZa78vazf0Xk3U3JNBqvB.mp4)
    String nomeArquivo = arquivo.split('/').last.trim();

    // Retorna o link Raw oficial codificando espaços (%20) se houverem
    return Uri.encodeFull(
      'https://raw.githubusercontent.com/luisantonioju/flutterolharqueprotege_app/main/assets/video/$nomeArquivo',
    );
  }
}
