import 'package:flutter/material.dart';

import '../tokens/oqp_colors.dart';
import '../tokens/oqp_layout.dart';
import '../tokens/oqp_typography.dart';

enum OqpButtonVariant { primary, secondary, outline }

class OqpButton extends StatelessWidget {
  const OqpButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = OqpButtonVariant.primary,
    this.icon,
    this.expanded = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final OqpButtonVariant variant;
  final IconData? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final (Color background, Color foreground, BorderSide side) = switch (variant) {
      OqpButtonVariant.primary => (OqpColors.ink, OqpColors.white, BorderSide.none),
      OqpButtonVariant.secondary => (OqpColors.cream, OqpColors.indigo, BorderSide.none),
      OqpButtonVariant.outline => (
          Colors.transparent,
          OqpColors.indigo,
          const BorderSide(color: OqpColors.indigo, width: 1.5),
        ),
    };

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        side: side,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OqpRadii.sm)),
        textStyle: OqpTypography.button,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: OqpSpacing.sm)],
          Text(label.toUpperCase()),
        ],
      ),
    );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}

class OqpTextField extends StatelessWidget {
  const OqpTextField({
    super.key,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction,
  });

  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: OqpTypography.label),
        const SizedBox(height: OqpSpacing.xs),
        Semantics(
          label: label,
          textField: true,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            style: OqpTypography.body.copyWith(color: OqpColors.ink),
          ),
        ),
      ],
    );
  }
}
