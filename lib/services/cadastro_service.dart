import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroService {
  static const String _keyUsuarios = 'lista_usuarios_cadastrados';
  static const String _keyToken = 'user_token';
  static const String _keyUserName = 'user_name';

  // Realiza o cadastro e salva os dados localmente
  Future<bool> cadastrarUsuario({
    required String nome,
    required String email,
    required String senha,
    required String tipoCadastro,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Recupera os usuários cadastrados
      List<String> usuariosStringList = prefs.getStringList(_keyUsuarios) ?? [];

      // Cria o novo usuário
      final novoUsuario = {
        'nome': nome,
        'email': email,
        'senha': senha,
        'tipoCadastro': tipoCadastro,
        'dataCadastro': DateTime.now().toIso8601String(),
      };

      // Converte para JSON e adiciona à lista
      usuariosStringList.add(jsonEncode(novoUsuario));

      // Salva a lista no dispositivo
      await prefs.setStringList(
        _keyUsuarios,
        usuariosStringList,
      );

      // Cria o token da sessão
      final token = 'token_local_${DateTime.now().millisecondsSinceEpoch}';

      await prefs.setString(_keyToken, token);
      await prefs.setString(_keyUserName, nome);

      return true;
    } catch (e) {
      print('Erro ao cadastrar usuário: $e');
      return false;
    }
  }

  // Exporta todos os usuários cadastrados em JSON
  Future<String> obterJsonUsuariosCadastrados() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      List<String> usuariosStringList = prefs.getStringList(_keyUsuarios) ?? [];

      // Converte os dados armazenados em objetos JSON
      List<Map<String, dynamic>> listaDecodificada =
          usuariosStringList.map((item) {
        return jsonDecode(item) as Map<String, dynamic>;
      }).toList();

      // Formata o JSON
      const encoder = JsonEncoder.withIndent('  ');

      return encoder.convert(listaDecodificada);
    } catch (e) {
      print('Erro ao recuperar usuários cadastrados: $e');
      return '[]';
    }
  }

  // Encerra a sessão do usuário
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove(_keyToken);
      await prefs.remove(_keyUserName);
    } catch (e) {
      print('Erro ao realizar logout: $e');
    }
  }

  // Recupera o token do usuário
  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      return prefs.getString(_keyToken);
    } catch (e) {
      print('Erro ao recuperar token: $e');
      return null;
    }
  }

  // Recupera o nome do usuário conectado
  Future<String?> getUserName() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      return prefs.getString(_keyUserName);
    } catch (e) {
      print('Erro ao recuperar nome do usuário: $e');
      return null;
    }
  }
}
