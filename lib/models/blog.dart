class Blog {
  final int id;
  final String titulo;
  final String resumo;
  final String conteudo;
  final String? imagem;
  final int categoriaId;
  final String categoriaNome;
  final DateTime createdAt;

  Blog({
    required this.id,
    required this.titulo,
    required this.resumo,
    required this.conteudo,
    this.imagem,
    required this.categoriaId,
    required this.categoriaNome,
    required this.createdAt,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      titulo: json['titulo']?.toString() ?? '',
      resumo: json['resumo']?.toString() ?? '',
      conteudo: json['conteudo']?.toString() ?? '',
      imagem: json['imagem']?.toString(),
      categoriaId: json['categoria_id'] is int
          ? json['categoria_id']
          : int.tryParse(json['categoria_id']?.toString() ?? '0') ?? 0,
      categoriaNome: json['categoria_nome']?.toString() ?? 'Geral',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  // Getter ajustado para carregar as imagens da pasta assets/img/
  String? get imagemAsset {
    if (imagem == null || imagem!.isEmpty) return null;
    // Se o caminho já vier completo, retorna ele; senão, concatena com assets/img/
    if (imagem!.startsWith('assets/')) return imagem;
    return 'assets/img/$imagem';
  }

  String get dataFormatada {
    final dia = createdAt.day.toString().padLeft(2, '0');
    final mes = createdAt.month.toString().padLeft(2, '0');
    final ano = createdAt.year.toString();
    return '$dia/$mes/$ano';
  }
}
