enum OqpContentKind {
  video('Vídeo'),
  article('Leitura');

  const OqpContentKind(this.tagLabel);
  final String tagLabel;
}

class OqpContent {
  const OqpContent({
    required this.kind,
    required this.title,
    required this.description,
    required this.author,
    required this.date,
    required this.image,
    this.duration,
  });

  final OqpContentKind kind;
  final String title;
  final String description;
  final String author;
  final String date;
  final String image;
  final String? duration;
}

class OqpSlide {
  const OqpSlide({required this.image, required this.title, required this.highlight});

  final String image;
  final String title;
  final String highlight;
}

abstract final class OqpImages {
  static const String _base = 'assets/images';
  static const String logoMark = '$_base/logo-mark.png';
  static const String heroHeadphones = '$_base/hero-headphones.png';
  static const String girlLaptopBlue = '$_base/girl-laptop-blue.png';
  static const String girlsBedLaptop = '$_base/girls-bed-laptop.png';
  static const String cyberbullying = '$_base/cyberbullying.png';
  static const String girlYellow = '$_base/girl-yellow.png';
  static const String family = '$_base/family.png';
  static const String blogPhone = '$_base/blog-phone.png';
  static const String blogAlert = '$_base/blog-alert.png';
  static const String blogCommunity = '$_base/blog-community.png';
  static const String videoSchool = '$_base/video-school.png';
  static const String videoBokeh = '$_base/video-bokeh.png';
}

abstract final class OqpData {
  static const List<OqpSlide> slides = [
    OqpSlide(image: OqpImages.heroHeadphones, title: 'PERIGOS', highlight: 'DISCORD'),
    OqpSlide(image: OqpImages.girlLaptopBlue, title: 'CUIDADO', highlight: 'REDES SOCIAIS'),
    OqpSlide(image: OqpImages.girlsBedLaptop, title: 'ATENÇÃO', highlight: 'JOGOS ONLINE'),
  ];

  static const String homeIntro =
      'Muitas meninas estão expostas a riscos na internet. É de extrema importância que os '
      'responsáveis estejam atentos ao comportamento online, orientando e oferecendo diálogo '
      'aberto para garantir a segurança digital delas.';

  static const List<OqpContent> videos = [
    OqpContent(
      kind: OqpContentKind.video,
      title: 'Proteção Digital Infantil: Guia Prático para Pais',
      description:
          'Dicas essenciais sobre como monitorar e proteger as crianças no uso da internet e redes sociais.',
      author: 'Administrador',
      date: '19/08/2026',
      image: OqpImages.videoSchool,
      duration: '1:17',
    ),
    OqpContent(
      kind: OqpContentKind.video,
      title: 'Terceiro Vídeo de Apresentação',
      description: 'Breve descrição do Terceiro Vídeo Inicial de Apresentação',
      author: 'Alessandro',
      date: '19/08/2026',
      image: OqpImages.videoBokeh,
      duration: '1:03',
    ),
    OqpContent(
      kind: OqpContentKind.video,
      title: 'Segundo Vídeo de Apresentação',
      description: 'Breve descrição do Segundo Vídeo Inicial de Apresentação',
      author: 'Alessandro',
      date: '19/08/2026',
      image: OqpImages.videoSchool,
      duration: '1:17',
    ),
    OqpContent(
      kind: OqpContentKind.video,
      title: 'Vídeo Inicial de Apresentação',
      description: 'Breve descrição do Vídeo Inicial de Apresentação',
      author: 'Alessandro',
      date: '19/08/2026',
      image: OqpImages.girlLaptopBlue,
      duration: '0:04',
    ),
  ];

  static const List<OqpContent> posts = [
    OqpContent(
      kind: OqpContentKind.article,
      title: 'A Importância da Proteção Infantil',
      description:
          'Texto detalhado sobre a importância de proteger as crianças e criar um ambiente seguro...',
      author: 'Administrador',
      date: '19/08/2026',
      image: OqpImages.blogPhone,
    ),
    OqpContent(
      kind: OqpContentKind.article,
      title: 'Como Identificar Sinais de Alerta',
      description: 'Texto sobre como perceber comportamentos e prevenir situações de risco...',
      author: 'Administrador',
      date: '18/08/2026',
      image: OqpImages.blogAlert,
    ),
    OqpContent(
      kind: OqpContentKind.article,
      title: 'O Papel da Comunidade na Segurança',
      description:
          'Texto explicando como toda a sociedade pode contribuir no projeto Olhar Que Protege...',
      author: 'Administrador',
      date: '17/08/2026',
      image: OqpImages.blogCommunity,
    ),
  ];
}
