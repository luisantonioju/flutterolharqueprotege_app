import 'package:flutter/material.dart';
import 'services/cadastro_service.dart'; // Ajuste o caminho do import se necessário

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _cadastroService = CadastroService();
  bool _carregando = false;

  Future<void> _realizarCadastro({String tipo = 'email'}) async {
    if (tipo == 'email' && !_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);

    String nome = _nomeController.text.isNotEmpty
        ? _nomeController.text
        : 'Usuário $tipo';
    String email = _emailController.text.isNotEmpty
        ? _emailController.text
        : 'usuario_$tipo@app.com';

    bool sucesso = await _cadastroService.cadastrarUsuario(
      nome: nome,
      email: email,
      senha: _senhaController.text,
      tipoCadastro: tipo,
    );

    setState(() => _carregando = false);

    if (sucesso && mounted) {
      Navigator.pop(
          context, true); // Retorna verdadeiro indicando que cadastrou e logou
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao realizar cadastro.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5CEEB),
      appBar: AppBar(
        title: const Text('Criar Conta'),
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
                  'Cadastre-se para acessar Conteúdos Exclusivos!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2A4A),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome Completo',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? 'Informe seu nome' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) =>
                      val!.isEmpty ? 'Informe seu e-mail' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _senhaController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (val) => val!.length < 6
                      ? 'A senha deve ter ao menos 6 caracteres'
                      : null,
                ),
                const SizedBox(height: 24),
                _carregando
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B2A4A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () => _realizarCadastro(tipo: 'email'),
                        child: const Text('Cadastrar',
                            style: TextStyle(fontSize: 16)),
                      ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFF1B2A4A)),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1B2A4A),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => _realizarCadastro(tipo: 'google'),
                  icon: const Icon(Icons.g_mobiledata, size: 28),
                  label: const Text('Cadastrar com Google'),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1B2A4A),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => _realizarCadastro(tipo: 'x'),
                  icon: const Icon(Icons.close, size: 20),
                  label: const Text('Cadastrar com o X'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
