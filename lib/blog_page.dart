import 'package:flutter/material.dart';

// Modelo para representar cada Post do Blog
class BlogPost {
  final String title;
  final String category;
  final String date;
  final String summary;
  final String content;
  final String imagePath;

  const BlogPost({
    required this.title,
    required this.category,
    required this.date,
    required this.summary,
    required this.content,
    required this.imagePath,
  });
}

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  // Lista com as 3 notícias usando as suas imagens da pasta assets/img/
  final List<BlogPost> posts = const [
    BlogPost(
      title: 'Alertas e Segurança Digital para Crianças na Internet',
      category: 'Segurança',
      date: '10/11/2026',
      summary:
          'Saiba como identificar riscos, configurar proteções nos dispositivos e manter a navegação dos seus filhos segura.',
      content:
          'Com o aumento do tempo de tela, é essencial manter atenção aos aplicativos e jogos utilizados pelas crianças. Este guia prático traz orientações fundamentais para pais e educadores protegerem os pequenos contra perigos virtuais.',
      imagePath: 'assets/img/blog-alert.png',
    ),
    BlogPost(
      title: 'Comunidade Unida pela Proteção Infantil Online',
      category: 'Comunidade',
      date: '08/11/2026',
      summary:
          'Encontros e workshops reúnem famílias para discutir o uso consciente das redes sociais e tecnologia.',
      content:
          'A troca de experiências entre pais e educadores fortalece a rede de apoio na proteção digital. Participar de debates e eventos comunitários nos ajuda a compreender as novas dinâmicas das plataformas digitais.',
      imagePath: 'assets/img/blog-community.png',
    ),
    BlogPost(
      title: 'Uso de Celulares e Telas no Cotidiano das Crianças',
      category: 'Tecnologia',
      date: '05/11/2026',
      summary:
          'Dicas práticas para estabelecer limites de uso de smartphones e incentivar hábitos saudáveis.',
      content:
          'O acesso precoce aos celulares exige regras claras sobre horários e tipos de conteúdos consumidos. Confira boas práticas para equilibrar a vida digital e atividades offline.',
      imagePath: 'assets/img/blog-phone.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                // Abre a tela de notícia detalhada idêntica ao print
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogPostDetailPage(post: post),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    post.imagePath,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                post.category,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue.shade800,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              post.date,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          post.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          post.summary,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Tela de Detalhes da Notícia (Idêntica ao layout do print fornecido)
class BlogPostDetailPage extends StatelessWidget {
  final BlogPost post;

  const BlogPostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notícia'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem destacada no topo
            Image.asset(
              post.imagePath,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categoria + Data
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA5F3FC).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          post.category,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF1E3A8A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        post.date,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Título principal
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Resumo / Conteúdo
                  Text(
                    post.summary,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    post.content,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
