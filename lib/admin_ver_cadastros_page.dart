import 'package:flutter/material.dart';
import 'services/cadastro_service.dart';

class AdminVerCadastrosPage extends StatefulWidget {
  const AdminVerCadastrosPage({super.key});

  @override
  State<AdminVerCadastrosPage> createState() => _AdminVerCadastrosPageState();
}

class _AdminVerCadastrosPageState extends State<AdminVerCadastrosPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _autenticado = false;
  bool _carregando = false;
  String _dadosJson = '';
  final CadastroService _cadastroService = CadastroService();

  Future<void> _verificarCredenciais() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);

    String emailDigitado = _emailController.text.trim();
    String senhaDigitada = _senhaController.text;

    // Suas credenciais protegidas de administrador
    if (emailDigitado == 'luisantoniodeassisjunior@gmail.com' &&
        senhaDigitada == 'kxtznilehtak#B9') {
      String jsonString = await _cadastroService.obterJsonUsuariosCadastrados();
      setState(() {
        _dadosJson = jsonString.isEmpty
            ? 'Nenhum usuário cadastrado ainda.'
            : jsonString;
        _autenticado = true;
        _carregando = false;
      });
    } else {
      setState(() => _carregando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('E-mail ou senha de Administrador incorretos!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5CEEB),
      appBar: AppBar(
        title: const Text('Painel Restrito - Cadastros (JSON)'),
        backgroundColor: const Color(0xFFF7F4EE),
        foregroundColor: const Color(0xFF1B2A4A),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: !_autenticado
            ? Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(Icons.lock_person,
                            size: 70, color: Color(0xFF1B2A4A)),
                        const SizedBox(height: 16),
                        const Text(
                          'Acesso Restrito ao Administrador',
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
                              val!.isEmpty ? 'Informe o e-mail' : null,
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
                          validator: (val) =>
                              val!.isEmpty ? 'Informe a senha' : null,
                        ),
                        const SizedBox(height: 24),
                        _carregando
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1B2A4A),
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                onPressed: _verificarCredenciais,
                                child: const Text('Desbloquear Base JSON',
                                    style: TextStyle(fontSize: 16)),
                              ),
                      ],
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFF1B2A4A), width: 1.5),
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
                ],
              ),
      ),
    );
  }
}
