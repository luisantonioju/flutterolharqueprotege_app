import 'package:flutter/material.dart';
import 'services/cadastro_service.dart';

class UsuariosCadastradosPage extends StatefulWidget {
  const UsuariosCadastradosPage({super.key});

  @override
  State<UsuariosCadastradosPage> createState() =>
      _UsuariosCadastradosPageState();
}

class _UsuariosCadastradosPageState extends State<UsuariosCadastradosPage> {
  final CadastroService _cadastroService = CadastroService();
  String _dadosJson = 'Carregando dados...';
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    String jsonString = await _cadastroService.obterJsonUsuariosCadastrados();
    setState(() {
      _dadosJson =
          jsonString.isEmpty ? 'Nenhum usuário cadastrado ainda.' : jsonString;
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5CEEB),
      appBar: AppBar(
        title: const Text('Usuários Cadastrados (JSON)'),
        backgroundColor: const Color(0xFFF7F4EE),
        foregroundColor: const Color(0xFF1B2A4A),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() => _carregando = true);
              _carregarDados();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _carregando
            ? const Center(child: CircularProgressIndicator())
            : Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: const Color(0xFF1B2A4A), width: 1.5),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    _dadosJson,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      color: Color(0xFF1B2A4A),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
