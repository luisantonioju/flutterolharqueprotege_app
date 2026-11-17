import 'package:flutter/material.dart';
import 'services/cadastro_service.dart'; // Certifique-se de que o caminho do import está correto

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _cadastroService = CadastroService();
  bool _carregando = false;

  Future<void> _fazerLogin({String tipo = 'email'}) async {
    if (tipo == 'email' && !_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);

    // Simula uma validação e gera o token de acesso local
    String email = _emailController.text.isNotEmpty
        ? _emailController.text
        : 'usuario_$tipo@app.com';
    bool sucesso = await _cadastroService.cadastrarUsuario(
      nome: tipo == 'email' ? 'Usuário App' : 'Usuário $tipo',
      email: email,
      senha: _senhaController.text,
      tipoCadastro: tipo,
    );

    setState(() => _carregando = false);

    if (sucesso && mounted) {
      // Retorna 'true' para o HomePage sabendo que o usuário logou com sucesso
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login efetuado com sucesso!')),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao efetuar login.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5CEEB),
      appBar: AppBar(
        title: const Text('Entrar'),
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
                  'Acesse sua conta para ver Conteúdos Exclusivos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B2A4A),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
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
                  validator: (val) => val!.isEmpty ? 'Informe sua senha' : null,
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
                        onPressed: () => _fazerLogin(tipo: 'email'),
                        child: const Text('Entrar',
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
                  onPressed: () => _fazerLogin(tipo: 'google'),
                  icon: const Icon(Icons.g_mobiledata, size: 28),
                  label: const Text('Entrar com Google'),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1B2A4A),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => _fazerLogin(tipo: 'x'),
                  icon: const Icon(Icons.close, size: 20),
                  label: const Text('Entrar com o X'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
