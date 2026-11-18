class Video {
  final String id;
  final String titulo;
  final String descricao;
  final String
      arquivo; // URL ou ID do YouTube (ex: 'dQw4w9WgXcQ' ou link completo)

  const Video({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.arquivo,
  });
}
