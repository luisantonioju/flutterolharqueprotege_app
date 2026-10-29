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

  // URL apontando para o storage do Laravel acessível pelo emulador Android
  String get urlCompleta => 'http://10.0.2.2:8000/storage/$arquivo';
}
