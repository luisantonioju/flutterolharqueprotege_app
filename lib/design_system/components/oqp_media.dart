import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/oqp_content.dart';
import '../tokens/oqp_colors.dart';
import '../tokens/oqp_layout.dart';
import '../tokens/oqp_typography.dart';
import 'oqp_basics.dart';

/// Moldura de player de vídeo com controles visuais.
/// Para reprodução real, substitua a imagem por um `VideoPlayer` (pacote video_player).
class OqpVideoFrame extends StatefulWidget {
  const OqpVideoFrame({
    super.key,
    required this.image,
    required this.duration,
    this.aspectRatio = 16 / 9,
  });

  final String image;
  final String duration;
  final double aspectRatio;

  @override
  State<OqpVideoFrame> createState() => _OqpVideoFrameState();
}

class _OqpVideoFrameState extends State<OqpVideoFrame> {
  bool _playing = false;

  void _toggle() => setState(() => _playing = !_playing);

  @override
  Widget build(BuildContext context) {
    final controlStyle = GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: OqpColors.white,
    );

    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(widget.image, fit: BoxFit.cover, excludeFromSemantics: true),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.55, 1],
                colors: [OqpColors.scrimTransparent, OqpColors.scrimDark],
              ),
            ),
          ),
          if (!_playing)
            Center(
              child: Material(
                color: OqpColors.cream,
                shape: const CircleBorder(),
                elevation: 4,
                child: IconButton(
                  tooltip: 'Reproduzir vídeo',
                  iconSize: 34,
                  color: OqpColors.indigo,
                  onPressed: _toggle,
                  icon: const Icon(Icons.play_arrow_rounded),
                ),
              ),
            ),
          Positioned(
            left: OqpSpacing.md,
            right: OqpSpacing.md,
            bottom: OqpSpacing.sm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      tooltip: _playing ? 'Pausar' : 'Reproduzir',
                      visualDensity: VisualDensity.compact,
                      color: OqpColors.white,
                      onPressed: _toggle,
                      icon: Icon(_playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
                    ),
                    Text('0:00 / ${widget.duration}', style: controlStyle),
                    const Spacer(),
                    const Icon(Icons.volume_up_rounded, size: 18, color: OqpColors.white),
                    const SizedBox(width: OqpSpacing.md),
                    const Icon(Icons.fullscreen_rounded, size: 20, color: OqpColors.white),
                    const SizedBox(width: OqpSpacing.sm),
                    const Icon(Icons.more_vert_rounded, size: 18, color: OqpColors.white),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: _playing ? 0.35 : 0.05,
                    minHeight: 3,
                    backgroundColor: OqpColors.whiteTrack,
                    valueColor: const AlwaysStoppedAnimation(OqpColors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Card de conteúdo (vídeo ou post). `featured` = card de destaque no topo da lista.
class OqpContentCard extends StatelessWidget {
  const OqpContentCard({super.key, required this.content, this.featured = false});

  final OqpContent content;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final isVideo = content.kind == OqpContentKind.video;

    final Widget media = isVideo
        ? OqpVideoFrame(
            image: content.image,
            duration: content.duration ?? '0:00',
            aspectRatio: featured ? 4 / 5 : 16 / 9,
          )
        : AspectRatio(
            aspectRatio: featured ? 4 / 3 : 16 / 9,
            child: Image.asset(content.image, fit: BoxFit.cover, excludeFromSemantics: true),
          );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: OqpColors.lavender50,
        borderRadius: BorderRadius.circular(OqpRadii.lg),
        boxShadow: OqpShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          media,
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OqpMeta(author: content.author, date: content.date),
                const SizedBox(height: OqpSpacing.sm),
                Text(content.title, style: featured ? OqpTypography.h1 : OqpTypography.h3),
                const SizedBox(height: OqpSpacing.sm),
                Text(content.description, style: OqpTypography.body),
                const SizedBox(height: OqpSpacing.lg),
                OqpTag(featured ? 'Destaque' : content.kind.tagLabel),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OqpCarousel extends StatefulWidget {
  const OqpCarousel({super.key, required this.slides});

  final List<OqpSlide> slides;

  @override
  State<OqpCarousel> createState() => _OqpCarouselState();
}

class _OqpCarouselState extends State<OqpCarousel> {
  final PageController _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    final count = widget.slides.length;
    _controller.animateToPage(
      (index + count) % count,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _CarouselArrow(
              icon: Icons.chevron_left_rounded,
              tooltip: 'Slide anterior',
              onPressed: () => _goTo(_index - 1),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: widget.slides.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: OqpSpacing.xs),
                    child: _SlideView(slide: widget.slides[i]),
                  ),
                ),
              ),
            ),
            _CarouselArrow(
              icon: Icons.chevron_right_rounded,
              tooltip: 'Próximo slide',
              onPressed: () => _goTo(_index + 1),
            ),
          ],
        ),
        const SizedBox(height: OqpSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.slides.length, (i) {
            final active = i == _index;
            return Semantics(
              button: true,
              label: 'Ir para o slide ${i + 1}',
              selected: active,
              child: GestureDetector(
                onTap: () => _goTo(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: OqpSpacing.xs),
                  width: active ? 22 : 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: active ? OqpColors.textSoft : OqpColors.lavender200,
                    borderRadius: BorderRadius.circular(OqpRadii.pill),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _CarouselArrow extends StatelessWidget {
  const _CarouselArrow({required this.icon, required this.tooltip, required this.onPressed});

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: 28,
      color: OqpColors.lavenderMuted,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 44),
    );
  }
}

class _SlideView extends StatelessWidget {
  const _SlideView({required this.slide});

  final OqpSlide slide;

  @override
  Widget build(BuildContext context) {
    const textShadow = [Shadow(color: Color(0x66000000), blurRadius: 8)];

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: OqpColors.white,
        borderRadius: BorderRadius.circular(OqpRadii.lg),
        boxShadow: OqpShadows.soft,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(OqpRadii.md),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(slide.image, fit: BoxFit.cover, excludeFromSemantics: true),
            Positioned(
              right: OqpSpacing.md,
              top: OqpSpacing.md,
              child: Semantics(
                label: '${slide.title} ${slide.highlight}',
                excludeSemantics: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(slide.title, style: OqpTypography.slideTitle.copyWith(shadows: textShadow)),
                    Text(
                      slide.highlight,
                      style: OqpTypography.slideTitle.copyWith(
                        fontSize: 22,
                        color: OqpColors.discord,
                        shadows: textShadow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
