import 'package:flutter/material.dart';

import '../../data/oqp_content.dart';
import '../tokens/oqp_typography.dart';

class OqpLogo extends StatelessWidget {
  const OqpLogo({super.key, this.size = 40, this.showWordmark = true});

  final double size;
  final bool showWordmark;

  @override
  Widget build(BuildContext context) {
    final mark = Image.asset(OqpImages.logoMark, width: size, height: size);
    final style = OqpTypography.logo.copyWith(fontSize: size * 0.34);

    return Semantics(
      label: 'Olhar Que Protege',
      excludeSemantics: true,
      child: showWordmark
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                mark,
                SizedBox(width: size * 0.1),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('OLHAR', style: style),
                    Text('QUE', style: style),
                    Text('PROTEGE', style: style),
                  ],
                ),
              ],
            )
          : mark,
    );
  }
}
