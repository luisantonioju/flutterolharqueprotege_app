import 'package:flutter/material.dart';

class CadastrarNoticiaPage extends StatefulWidget {
  const CadastrarNoticiaPage({super.key});

  @override
  State<CadastrarNoticiaPage> createState() => _CadastrarNoticiaPageState();
}

class _CadastrarNoticiaPageState extends State<CadastrarNoticiaPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _resumoController = TextEditingController();
  final _conteudoController = TextEditingController();
  final _imagemController = TextEditingController();

  bool _salvando = false;

  void _salvarNoticia() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _salvando = true);

    // Simulação de salvamento da notícia pelo administrador
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _salvando = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notícia cadastrada com sucesso!')),
        );
        Navigator.pop(context); // Retorna para a tela anterior
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5CEEB),
      appBar: AppBar(
        title: const Text('Cadastrar Notícia (Admin)'),
        backgroundColor: const Color(0xFFF7F4EE),
        foregroundColor: const Color(0xFF1B2A4A),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Adicionar Nova Notícia ao Portal',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2A4A),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Título da Notícia',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? 'Informe o título' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _resumoController,
                  decoration: const InputDecoration(
                    labelText: 'Resumo',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  validator: (val) => val!.isEmpty ? 'Informe o resumo' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _conteudoController,
                  decoration: const InputDecoration(
                    labelText: 'Conteúdo Completo',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  validator: (val) =>
                      val!.isEmpty ? 'Informe o conteúdo' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imagemController,
                  decoration: const InputDecoration(
                    labelText: 'URL ou Caminho da Imagem',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? 'Informe a imagem' : null,
                ),
                const SizedBox(height: 24),
                _salvando
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B2A4A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _salvarNoticia,
                        child: const Text('Salvar Notícia',
                            style: TextStyle(fontSize: 16)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
