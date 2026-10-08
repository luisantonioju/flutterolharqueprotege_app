import 'package:flutter/material.dart';

import '../app/oqp_routes.dart';
import '../design_system/design_system.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _remember = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                          const SizedBox(height: OqpSpacing.xxl),
                          OqpTextField(
                            label: 'Email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: OqpSpacing.md),
                          OqpTextField(
                            label: 'Password',
                            controller: _passwordController,
                            obscureText: true,
                            autofillHints: const [AutofillHints.password],
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: OqpSpacing.sm),
                          CheckboxListTile(
                            value: _remember,
                            onChanged: (v) => setState(() => _remember = v ?? false),
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: Text('Remember me', style: OqpTypography.label),
                          ),
                          const SizedBox(height: OqpSpacing.sm),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: OqpSpacing.md,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text('Forgot your password?'),
                              ),
                              OqpButton(label: 'Log in', onPressed: () {}),
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
