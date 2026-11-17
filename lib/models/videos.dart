class Video {
  final int id;
  final String titulo;
  final String descricao;
  final String arquivo;

  const Video({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.arquivo,
  });
}

// Lista de vídeos do Olhar Que Protege
final List<Video> listaVideos = [
  const Video(
    id: 1,
    titulo:
        'ECA Digital: Novas regras para proteger menores na internet entram em vigor | CNN PRIME TIME',
    descricao:
        'O ECA Digital estabelece novas regras para proteger crianças e adolescentes na internet. A legislação atualiza o Estatuto da Criança e do Adolescente para o ambiente digital.',
    arquivo: 'kqgA4bDdpb8',
  ),
  const Video(
    id: 2,
    titulo:
        'ECA Digital: Lei que protege crianças na internet entra em vigor hoje',
    descricao:
        'Conheça as novas regras para plataformas e redes sociais e a proteção de crianças e adolescentes.',
    arquivo: '8vlPYxH0pFU',
  ),
  const Video(
    id: 3,
    titulo: 'Órgãos governamentais se mobilizam.',
    descricao: 'Veja o vídeo da Prefeitura de Aracaju.',
    arquivo: 'qclcRH5jimU',
  ),
  const Video(
    id: 4,
    titulo: 'Família ensina o Google Family Link.',
    descricao:
        'Aprenda sobre os recursos de proteção e acompanhamento familiar no smartphone.',
    arquivo: 'laExLC8PfS0',
  ),
];
