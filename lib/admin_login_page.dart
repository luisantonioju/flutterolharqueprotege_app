import 'package:flutter/material.dart';
import 'cadastrar_noticia_page.dart'; // Tela que o admin abre após logar

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _carregando = false;

  void _fazerLoginAdmin() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);

    // Credenciais fixas de Administrador para a apresentação
    // Você pode alterar o e-mail e senha aqui se desejar
    String emailAdmin = 'admin@olharqueprotege.com';
    String senhaAdmin = 'admin123';

    if (_emailController.text.trim() == emailAdmin &&
        _senhaController.text == senhaAdmin) {
      setState(() => _carregando = false);

      // Fecha a tela de login e abre direto a tela de Cadastrar Notícia
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CadastrarNoticiaPage()),
      );
    } else {
      setState(() => _carregando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('E-mail ou senha de Administrador incorretos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5CEEB),
      appBar: AppBar(
        title: const Text('Painel do Administrador'),
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
                const Icon(
                  Icons.admin_panel_settings,
                  size: 80,
                  color: Color(0xFF1B2A4A),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Acesso Restrito para Gestores',
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
                    labelText: 'E-mail do Administrador',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) => val!.isEmpty ? 'Informe o e-mail' : null,
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
                  validator: (val) => val!.isEmpty ? 'Informe a senha' : null,
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
                        onPressed: _fazerLoginAdmin,
                        child: const Text('Entrar como Admin',
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
