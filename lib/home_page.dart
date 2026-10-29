import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'sobre_page.dart';
import 'videos_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _paginaAtual = 0;
  Timer? _timerCarrossel;

  @override
  void initState() {
    super.initState();

    // Configurando o temporizador para mudar de slide a cada 1 segundo
    _timerCarrossel = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_pageController.hasClients) {
        int proximaPagina = _paginaAtual + 1;
        if (proximaPagina >= carrosselImagens.length) {
          proximaPagina = 0; // Volta para a primeira imagem ao chegar no fim
        }

        _pageController.animateToPage(
          proximaPagina,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timerCarrossel?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  static final List<String> categorias = [
    'Todas',
    'Tecnologia',
    'Educação',
    'Economia',
    'Esporte',
  ];

  final List<String> carrosselImagens = [
    'assets/img/banner1.jpg',
    'assets/img/banner2.jpg',
    'assets/img/banner3.jpg',
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.search, color: Color(0xFF1B2A4A)),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFF7F4EE),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/img/olhar_que_protege_transparente.svg',
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            // Localize este trecho dentro do seu Drawer no home_page.dart:
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu lateral

                // ➔ Redireciona para a nova página Sobre
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SobrePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Vídeos'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu lateral
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VideosPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('Blog'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Cadastrar-me'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Entrar'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.star_outline),
              title: const Text('Extras'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Equipe'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CATEGORIAS
            SizedBox(
              height: 55,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                children: categorias.map((categoria) {
                  final selecionada = categoria == 'Todas';
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selecionada
                            ? const Color(0xFF1B2A4A)
                            : const Color(0xFFCBD2D9),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      categoria,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            selecionada ? FontWeight.bold : FontWeight.normal,
                        color: const Color(0xFF1B2A4A),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // CARROSSEL AUTOMÁTICO
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: carrosselImagens.length,
                  onPageChanged: (index) {
                    setState(() {
                      _paginaAtual = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            carrosselImagens[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: const Color(0xFFD3D8EC),
                              child: const Center(
                                child: Icon(Icons.image,
                                    size: 50, color: Colors.grey),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              color: Colors.black.withOpacity(0.4),
                              child: const Text(
                                'Acompanhamento Consciente\nMonitorar é um ato de amor e preservação da integridade.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // ========================================================
            // 1. CARD SUPERIOR: IMAGEM PREENCHENDO O BLOCO
            // ========================================================
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(
                    'assets/img/SUA_IMAGEM_AQUI.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFF9CAAE1),
                      child: const Center(
                        child: Icon(Icons.image_outlined,
                            size: 50, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ========================================================
            // 2. CARD INFERIOR: FOTO DAS MENINAS + TEXTO AO LADO
            // ========================================================
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF8E9BCE),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/img/meninas-assistindo-laptop-adolescentes-modernos-em-casa-surpresa-e-emocoes 1.png',
                        width: 130,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 130,
                          height: 100,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'CUIDAR E AMAR, PODE SALVAR E POUPAR.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
