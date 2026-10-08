import 'package:flutter/material.dart';

import '../app/oqp_routes.dart';
import '../design_system/design_system.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _goBack() {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      navigator.pushReplacementNamed(OqpRoutes.home);
    }
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacementNamed(OqpRoutes.login);
  }

  void _submit() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    String? error;
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      error = 'Preencha todos os campos.';
    } else if (!email.contains('@')) {
      error = 'Informe um email válido.';
    } else if (password.length < 6) {
      error = 'A senha deve ter pelo menos 6 caracteres.';
    } else if (password != _confirmController.text) {
      error = 'As senhas não coincidem.';
    }

    setState(() => _error = error);
    if (error == null) _goToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OqpColors.gray50,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                tooltip: 'Voltar',
                color: OqpColors.ink,
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: _goBack,
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(OqpSpacing.lg),
                  child: Container(
                    padding: const EdgeInsets.all(OqpSpacing.xl),
                    decoration: BoxDecoration(
                      color: OqpColors.white,
                      borderRadius: BorderRadius.circular(OqpRadii.sm * 2),
                      boxShadow: OqpShadows.soft,
                    ),
                    child: AutofillGroup(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(child: OqpLogo(size: 56)),
                          const SizedBox(height: OqpSpacing.md),
                          Text(
                            'Registro',
                            textAlign: TextAlign.center,
                            style: OqpTypography.label.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: OqpColors.ink,
                            ),
                          ),
                          const SizedBox(height: OqpSpacing.xs),
                          Text(
                            'Crie sua conta para acompanhar os conteúdos do Olhar Que Protege.',
                            textAlign: TextAlign.center,
                            style: OqpTypography.meta,
                          ),
                          const SizedBox(height: OqpSpacing.xl),
                          OqpTextField(
                            label: 'Nome completo',
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.name],
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: OqpSpacing.md),
                          OqpTextField(
                            label: 'Email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: OqpSpacing.md),
                          OqpTextField(
                            label: 'Senha',
                            controller: _passwordController,
                            obscureText: true,
                            autofillHints: const [AutofillHints.newPassword],
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: OqpSpacing.md),
                          OqpTextField(
                            label: 'Confirmar senha',
                            controller: _confirmController,
                            obscureText: true,
                            autofillHints: const [AutofillHints.newPassword],
                            textInputAction: TextInputAction.done,
                          ),
                          if (_error != null) ...[
                            const SizedBox(height: OqpSpacing.md),
                            Semantics(
                              liveRegion: true,
                              child: Text(
                                _error!,
                                style: OqpTypography.label.copyWith(color: Colors.red.shade700),
                              ),
                            ),
                          ],
                          const SizedBox(height: OqpSpacing.xl),
                          OqpButton(label: 'Registrar', onPressed: _submit),
                          const SizedBox(height: OqpSpacing.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Já tem uma conta?', style: OqpTypography.meta),
                              TextButton(
                                onPressed: _goToLogin,
                                child: const Text('Entrar'),
                              ),
                            ],
                          ),
                        ],
                      ),
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
