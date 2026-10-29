import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/blog.dart';

class BlogService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<Blog>> getBlogs() async {
    final resposta = await http.get(Uri.parse('$baseUrl/blog'));

    if (resposta.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(resposta.body);

      // Extrai a lista de dentro da chave "data"
      final List dados = jsonResponse['data'];

      return dados.map((item) => Blog.fromJson(item)).toList();
    } else {
      throw Exception('Não foi possível carregar os blogs');
    }
  }
}
