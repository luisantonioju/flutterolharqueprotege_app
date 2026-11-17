import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'sobre_page.dart';
import 'youtube_page.dart';
import 'blog_page.dart';
import 'admin_login_page.dart';
import 'cadastro_page.dart';
import 'login_page.dart';
import 'services/cadastro_service.dart';
import 'admin_ver_cadastros_page.dart';
import 'conteudos_exclusivos_page.dart'; // Importação da tela de Conteúdos Exclusivos

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _paginaAtual = 0;
  Timer? _timerCarrossel;

  bool _logado = false;
  final CadastroService _cadastroService = CadastroService();

  @override
  void initState() {
    super.initState();
    _checarSessao();

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

  Future<void> _checarSessao() async {
    final token = await _cadastroService.getToken();
    if (mounted) {
      setState(() {
        _logado = token != null;
      });
    }
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
    'assets/img/hero-headphones.png',
    'assets/img/girls-bed-laptop.png',
    'assets/img/ruiva.png',
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
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.pop(context);
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
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const YoutubePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('Blog'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BlogPage(),
                  ),
                );
              },
            ),
            const Divider(),

            // Opções dinâmicas com base no login do usuário comum
            if (_logado) ...[
              ListTile(
                leading: const Icon(Icons.star, color: Colors.amber),
                title: const Text('Conteúdos Exclusivos'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConteudosExclusivosPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Sair'),
                onTap: () async {
                  await _cadastroService.logout();
                  if (mounted) {
                    Navigator.pop(context);
                    setState(() {
                      _logado = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Sessão encerrada com sucesso.')),
                    );
                  }
                },
              ),
            ] else ...[
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Entrar'),
                onTap: () async {
                  Navigator.pop(context);
                  final entrou = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                  if (entrou == true) {
                    setState(() {
                      _logado = true;
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Cadastre-se'),
                onTap: () async {
                  Navigator.pop(context);
                  final cadastrado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CadastroPage()),
                  );
                  if (cadastrado == true) {
                    setState(() {
                      _logado = true;
                    });
                  }
                },
              ),
            ],

            const Divider(),

            // Seção isolada para Gestores / Administradores
            ListTile(
              leading: const Icon(Icons.admin_panel_settings,
                  color: Color(0xFF1B2A4A)),
              title: const Text('Área do Administrador'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminLoginPage(),
                  ),
                );
              },
            ),

            // Atalho para ver a base de dados JSON dos usuários cadastrados (Protegido por senha)
            ListTile(
              leading: const Icon(Icons.data_object, color: Color(0xFF1B2A4A)),
              title: const Text('Ver Cadastros (JSON)'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminVerCadastrosPage(),
                  ),
                );
              },
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

            // 1. CARD SUPERIOR
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

            // 2. CARD INFERIOR
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
