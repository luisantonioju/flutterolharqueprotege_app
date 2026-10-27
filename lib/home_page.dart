import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'models/blog.dart';
import 'services/blog_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BlogService _blogService = BlogService();
  late Future<List<Blog>> _listaBlogs;

  @override
  void initState() {
    super.initState();
    _listaBlogs = _blogService.getBlogs();
  }

  static final List<String> categorias = [
    'Todas',
    'Tecnologia',
    'Educação',
    'Economia',
    'Esporte',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/img/olhar_que_protege_transparente.svg',
          height: 100, // Aumentado de 30 para 48 para ficar maior e legível
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.search),
          ),
        ],
      ),
      drawer: const Drawer(), // Vírgula adicionada corretamente aqui
      body: Column(
        children: [
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: categorias.map((categoria) {
                final selecionada = categoria == 'Todas';
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color:
                          selecionada ? Colors.black : const Color(0xFFEDEDED),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    categoria,
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Blog>>(
              future: _listaBlogs,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (asyncSnapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Erro ao carregar: ${asyncSnapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                final blogs = asyncSnapshot.data ?? [];

                if (blogs.isEmpty) {
                  return const Center(
                    child: Text('Nenhum Blog Encontrado'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: blogs.length,
                  itemBuilder: (context, index) {
                    final blog = blogs[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      color: Colors.white,
                      elevation: 0,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Color(0xFFCBD2D9),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 120,
                            color: const Color(0xFFE4E9EF),
                            child: blog.imagem != null
                                ? Image.network(
                                    blog.imagem!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, erro, stack) =>
                                        const Icon(Icons.image_outlined),
                                  )
                                : const Icon(Icons.image_outlined),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEFF4F8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        blog.categoriaNome,
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      blog.dataFormatada,
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  blog.titulo,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF1b2a4a),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  blog.resumo,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF5B6B79),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
