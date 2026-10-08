import 'package:flutter/material.dart';

import '../../app/oqp_routes.dart';
import '../tokens/oqp_colors.dart';
import '../tokens/oqp_layout.dart';
import '../tokens/oqp_typography.dart';
import 'oqp_logo.dart';

/// Cabeçalho flutuante creme com logo e botão hambúrguer (abre o endDrawer).
class OqpHeader extends StatelessWidget {
  const OqpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        OqpSpacing.screenGutter,
        OqpSpacing.md,
        OqpSpacing.screenGutter,
        0,
      ),
      child: Container(
        height: 76,
        padding: const EdgeInsets.only(left: OqpSpacing.lg, right: OqpSpacing.xs),
        decoration: BoxDecoration(
          color: OqpColors.cream,
          borderRadius: BorderRadius.circular(OqpRadii.md),
          boxShadow: OqpShadows.card,
        ),
        child: Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(OqpRadii.sm),
              onTap: () {
                if (ModalRoute.of(context)?.settings.name != OqpRoutes.home) {
                  Navigator.of(context).pushReplacementNamed(OqpRoutes.home);
                }
              },
              child: const OqpLogo(size: 38),
            ),
            const Spacer(),
            IconButton(
              tooltip: 'Abrir menu',
              iconSize: 30,
              color: OqpColors.ink,
              icon: const Icon(Icons.menu_rounded),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Menu lateral (hambúrguer) com os mesmos itens da navegação web.
class OqpDrawer extends StatelessWidget {
  const OqpDrawer({super.key, required this.currentRoute});

  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      backgroundColor: OqpColors.cream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(OqpRadii.xl)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(OqpSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const OqpLogo(size: 44),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Fechar menu',
                    color: OqpColors.ink,
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: OqpSpacing.xl),
              for (final item in OqpRoutes.navItems)
                OqpDrawerItem(item: item, active: item.route == currentRoute),
              const Spacer(),
              const Divider(color: OqpColors.lavender100),
              OqpDrawerItem(
                item: const OqpNavItem(
                  label: 'Design System',
                  route: OqpRoutes.designSystem,
                  icon: Icons.palette_rounded,
                ),
                active: currentRoute == OqpRoutes.designSystem,
              ),
              const SizedBox(height: OqpSpacing.md),
              Row(
                children: [
                  const Icon(Icons.family_restroom_rounded, color: OqpColors.lavenderMuted),
                  const SizedBox(width: OqpSpacing.sm),
                  Text('MONITORAR = CUIDAR.', style: OqpTypography.slogan.copyWith(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OqpDrawerItem extends StatelessWidget {
  const OqpDrawerItem({super.key, required this.item, required this.active});

  final OqpNavItem item;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: OqpSpacing.xs),
      child: Material(
        color: active ? OqpColors.lavender50 : Colors.transparent,
        borderRadius: BorderRadius.circular(OqpRadii.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(OqpRadii.md),
          onTap: () {
            final navigator = Navigator.of(context);
            navigator.pop();
            if (active) return;
            if (item.route == OqpRoutes.login || item.route == OqpRoutes.registro) {
              navigator.pushNamed(item.route);
            } else {
              navigator.pushReplacementNamed(item.route);
            }
          },
          child: Semantics(
            selected: active,
            button: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: OqpSpacing.md, vertical: 14),
              child: Row(
                children: [
                  Icon(item.icon, color: active ? OqpColors.indigo : OqpColors.lavenderMuted),
                  const SizedBox(width: OqpSpacing.md),
                  Expanded(
                    child: Text(
                      item.label,
                      style: OqpTypography.nav.copyWith(
                        color: active ? OqpColors.indigo : OqpColors.ink,
                      ),
                    ),
                  ),
                  if (active)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: OqpColors.orange,
                        shape: BoxShape.circle,
                      ),
                    )
                  else
                    const Icon(Icons.chevron_right_rounded, color: OqpColors.lavenderMuted),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Estrutura padrão das telas públicas: header + menu + conteúdo rolável + rodapé.
class OqpScaffold extends StatelessWidget {
  const OqpScaffold({super.key, required this.currentRoute, required this.children});

  final String currentRoute;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      endDrawer: OqpDrawer(currentRoute: currentRoute),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: OqpHeader()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                OqpSpacing.screenGutter,
                OqpSpacing.xl,
                OqpSpacing.screenGutter,
                OqpSpacing.xl,
              ),
              sliver: SliverList(delegate: SliverChildListDelegate(children)),
            ),
            SliverToBoxAdapter(child: OqpFooter(bottomInset: bottomInset)),
          ],
        ),
      ),
    );
  }
}

class OqpFooter extends StatelessWidget {
  const OqpFooter({super.key, this.bottomInset = 0});

  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OqpColors.cream,
      padding: EdgeInsets.fromLTRB(
        OqpSpacing.xl,
        OqpSpacing.xl,
        OqpSpacing.xl,
        OqpSpacing.xl + bottomInset,
      ),
      child: Column(
        children: [
          const OqpLogo(size: 36),
          const SizedBox(height: OqpSpacing.md),
          Text(
            'Projeto alinhado à ODS 5.2 · Agenda 2030 da ONU',
            textAlign: TextAlign.center,
            style: OqpTypography.meta,
          ),
        ],
      ),
    );
  }
}
