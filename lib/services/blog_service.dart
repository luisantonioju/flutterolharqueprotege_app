import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/blog.dart'; // Import relativo corrigido

class BlogService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<Blog>> getBlogs() async {
    final resposta = await http.get(Uri.parse('$baseUrl/blogs'));

    if (resposta.statusCode == 200) {
      final List dados = jsonDecode(resposta.body);
      return dados.map((item) => Blog.fromJson(item)).toList();
    } else {
      throw Exception('Não foi possível carregar os blogs');
    }
  }
}
